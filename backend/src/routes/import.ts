import { FastifyInstance } from 'fastify'
import { drizzle } from 'drizzle-orm/postgres-js'
import postgres from 'postgres'
import { userCollections, cardSets, cards, collection } from '../db/schema'
import { eq, and } from 'drizzle-orm'
import { parseExcel } from '../seed/parseExcel'
import * as fs from 'fs'
import * as path from 'path'
import { pipeline } from 'stream/promises'
import * as os from 'os'

// LOB-EN001 → LOB-001 | LOB-001 → LOB-001
function normalizeCode(code: string): string {
  const m = code.match(/^([A-Z0-9]+)-(?:[A-Z]{0,2})?(\d+[A-Z]?)$/)
  return m ? `${m[1]}-${m[2]}` : code
}

interface YGOCardSet { set_name: string; set_code: string }
interface YGOCard {
  id: number
  name: string
  card_sets?: Array<{ set_code: string; set_name: string }>
}

async function fetchAllYGOSets(): Promise<YGOCardSet[]> {
  const res = await fetch('https://db.ygoprodeck.com/api/v7/cardsets.php')
  if (!res.ok) throw new Error('YGOPRODeck cardsets API failed')
  return res.json()
}

async function fetchCardsForSet(setName: string): Promise<YGOCard[]> {
  const res = await fetch(`https://db.ygoprodeck.com/api/v7/cardinfo.php?cardset=${encodeURIComponent(setName)}`)
  if (!res.ok) return []
  const data = await res.json()
  return data.data || []
}

function delay(ms: number) { return new Promise(r => setTimeout(r, ms)) }

export async function importRoutes(fastify: FastifyInstance) {
  const connectionString = process.env.DATABASE_URL || 'postgresql://yugioh:yugioh@localhost:5434/collection'
  const client = postgres(connectionString)
  const db = drizzle(client)

  // POST /api/collections/:id/import-excel
  fastify.post<{ Params: { id: string } }>('/api/collections/:id/import-excel', {
    preHandler: [fastify.authenticate],
  }, async (request, reply) => {
    const { id: userId } = request.user as { id: number; email: string }
    const collectionId = parseInt(request.params.id)

    const [col] = await db.select().from(userCollections).where(eq(userCollections.id, collectionId)).limit(1)
    if (!col || col.userId !== userId) return reply.status(404).send({ error: 'Colección no encontrada' })

    const data = await request.file()
    if (!data) return reply.status(400).send({ error: 'No se recibió archivo' })

    const tmpPath = path.join(os.tmpdir(), `import_${Date.now()}.xlsx`)
    await pipeline(data.file, fs.createWriteStream(tmpPath))

    let rows
    try {
      rows = parseExcel(tmpPath)
    } catch {
      fs.unlinkSync(tmpPath)
      return reply.status(400).send({ error: 'No se pudo leer el archivo Excel' })
    }
    fs.unlinkSync(tmpPath)

    if (!rows.length) return reply.status(400).send({ error: 'El archivo no tiene filas válidas' })

    const setPrefixes = [...new Set(rows.map(r => r.set_code))]

    let ygoSets: YGOCardSet[]
    try {
      ygoSets = await fetchAllYGOSets()
    } catch {
      return reply.status(502).send({ error: 'No se pudo conectar con YGOPRODeck' })
    }

    // Map set prefix (LOB) → set name from YGOPRODeck
    const setNameMap = new Map<string, string>()
    for (const prefix of setPrefixes) {
      const match =
        ygoSets.find(s => s.set_code === `${prefix}-EN`) ||
        ygoSets.find(s => s.set_code.startsWith(`${prefix}-EN`)) ||
        ygoSets.find(s => s.set_code.startsWith(`${prefix}-`)) ||
        ygoSets.find(s => s.set_code === prefix)
      if (match) setNameMap.set(prefix, match.set_name)
    }

    // Build card info map: normalized code → { name, passcode }
    const cardInfoMap = new Map<string, { name: string; passcode: number }>()
    for (const [prefix, setName] of setNameMap.entries()) {
      const ygoCards = await fetchCardsForSet(setName)
      for (const ygoCard of ygoCards) {
        if (!ygoCard.card_sets) continue
        for (const cs of ygoCard.card_sets) {
          const normalized = normalizeCode(cs.set_code)
          if (normalized.startsWith(prefix + '-')) {
            cardInfoMap.set(normalized, { name: ygoCard.name, passcode: ygoCard.id })
          }
        }
      }
      await delay(300)
    }

    // Get current max orderIndex for this collection
    const existingSets = await db.select().from(cardSets).where(eq(cardSets.collectionId, collectionId))
    let orderIndex = existingSets.length > 0 ? Math.max(...existingSets.map(s => s.orderIndex)) + 1 : 0

    const setCache = new Map<string, number>()
    let imported = 0
    const notFound: string[] = []

    for (const row of rows) {
      const cardInfo = cardInfoMap.get(row.card_code)
      if (!cardInfo) { notFound.push(row.card_code); continue }

      // Find or create card_set
      if (!setCache.has(row.set_code)) {
        const [existing] = await db.select().from(cardSets)
          .where(and(eq(cardSets.code, row.set_code), eq(cardSets.collectionId, collectionId)))
          .limit(1)
        if (existing) {
          setCache.set(row.set_code, existing.id)
        } else {
          const [created] = await db.insert(cardSets)
            .values({ code: row.set_code, name: setNameMap.get(row.set_code) || row.set_code, orderIndex: orderIndex++, collectionId })
            .returning()
          setCache.set(row.set_code, created.id)
        }
      }

      const setId = setCache.get(row.set_code)!

      // Find or create card
      let cardId: number
      const [existingCard] = await db.select().from(cards).where(eq(cards.cardCode, row.card_code)).limit(1)
      if (existingCard) {
        cardId = existingCard.id
      } else {
        const [created] = await db.insert(cards)
          .values({ name: cardInfo.name, cardCode: row.card_code, setId, passcode: cardInfo.passcode })
          .returning()
        cardId = created.id
      }

      // Upsert collection entry
      const [existingEntry] = await db.select().from(collection)
        .where(and(eq(collection.cardId, cardId), eq(collection.userId, userId)))
        .limit(1)
      if (existingEntry) {
        await db.update(collection).set({
          owned: row.owned, edition: row.edition, condition: row.condition,
          isUltimate: row.is_ultimate, language: row.language ?? null,
        }).where(and(eq(collection.cardId, cardId), eq(collection.userId, userId)))
      } else {
        await db.insert(collection).values({
          cardId, userId, owned: row.owned, edition: row.edition,
          condition: row.condition, isUltimate: row.is_ultimate, language: row.language ?? null,
        })
      }
      imported++
    }

    await db.update(userCollections)
      .set({ configured: true, viewMode: 'sets' })
      .where(eq(userCollections.id, collectionId))

    return { imported, notFound }
  })

  // POST /api/collections/:id/cards — add single card
  fastify.post<{
    Params: { id: string }
    Body: { cardCode: string; name: string; passcode: number; setCode: string; setName: string }
  }>('/api/collections/:id/cards', {
    preHandler: [fastify.authenticate],
  }, async (request, reply) => {
    const { id: userId } = request.user as { id: number; email: string }
    const collectionId = parseInt(request.params.id)
    const { cardCode, name, passcode, setCode, setName } = request.body

    const [col] = await db.select().from(userCollections).where(eq(userCollections.id, collectionId)).limit(1)
    if (!col || col.userId !== userId) return reply.status(404).send({ error: 'Colección no encontrada' })

    // Find or create set
    let setId: number
    const [existingSet] = await db.select().from(cardSets)
      .where(and(eq(cardSets.code, setCode), eq(cardSets.collectionId, collectionId)))
      .limit(1)
    if (existingSet) {
      setId = existingSet.id
    } else {
      const existingForOrder = await db.select().from(cardSets).where(eq(cardSets.collectionId, collectionId))
      const orderIndex = existingForOrder.length > 0 ? Math.max(...existingForOrder.map(s => s.orderIndex)) + 1 : 0
      const [created] = await db.insert(cardSets)
        .values({ code: setCode, name: setName, orderIndex, collectionId })
        .returning()
      setId = created.id
    }

    // Find or create card
    let cardId: number
    const [existingCard] = await db.select().from(cards).where(eq(cards.cardCode, cardCode)).limit(1)
    if (existingCard) {
      cardId = existingCard.id
    } else {
      const [created] = await db.insert(cards)
        .values({ name, cardCode, setId, passcode })
        .returning()
      cardId = created.id
    }

    // Create collection entry if not exists
    const [existingEntry] = await db.select().from(collection)
      .where(and(eq(collection.cardId, cardId), eq(collection.userId, userId)))
      .limit(1)
    if (!existingEntry) {
      await db.insert(collection).values({ cardId, userId, owned: false })
    }

    // Only set viewMode to 'cards' if collection hasn't been configured via Excel (keep 'sets' if already set)
    if (col.viewMode !== 'sets') {
      await db.update(userCollections).set({ configured: true, viewMode: 'cards' }).where(eq(userCollections.id, collectionId))
    } else {
      await db.update(userCollections).set({ configured: true }).where(eq(userCollections.id, collectionId))
    }

    return reply.status(201).send({ cardId, setId })
  })
}
