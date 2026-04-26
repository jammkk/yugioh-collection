import { FastifyInstance } from 'fastify'
import { drizzle } from 'drizzle-orm/postgres-js'
import postgres from 'postgres'
import { userCollections, collection, cards, cardSets, cardPhotos, users } from '../db/schema'
import { eq, sql, count, and, inArray, isNull, isNotNull, not } from 'drizzle-orm'
import bcrypt from 'bcryptjs'
import * as fs from 'fs'
import * as path from 'path'
import { pipeline } from 'stream/promises'
import * as XLSX from 'xlsx'

const UPLOADS_DIR = path.join(process.cwd(), 'uploads')

export async function collectionsRoutes(fastify: FastifyInstance) {
  const connectionString = process.env.DATABASE_URL || 'postgresql://yugioh:yugioh@localhost:5434/collection'
  const client = postgres(connectionString)
  const db = drizzle(client)
  fs.mkdirSync(UPLOADS_DIR, { recursive: true })

  // GET /api/collections
  fastify.get('/api/collections', {
    preHandler: [fastify.authenticate],
  }, async (request, _reply) => {
    const { id: userId } = request.user as { id: number; email: string }

    const cols = await db
      .select()
      .from(userCollections)
      .where(eq(userCollections.userId, userId))
      .orderBy(userCollections.createdAt)

    // Stats per collection: total cards via card_sets.collection_id
    const totalPerCollection = await db
      .select({ collectionId: cardSets.collectionId, total: count(cards.id) })
      .from(cards)
      .innerJoin(cardSets, eq(cards.setId, cardSets.id))
      .groupBy(cardSets.collectionId)

    // Owned cards per collection (user-scoped)
    const ownedPerCollection = await db
      .select({
        collectionId: cardSets.collectionId,
        owned: sql<number>`CAST(SUM(CASE WHEN ${collection.owned} = true THEN 1 ELSE 0 END) AS INTEGER)`,
      })
      .from(collection)
      .innerJoin(cards, eq(collection.cardId, cards.id))
      .innerJoin(cardSets, eq(cards.setId, cardSets.id))
      .where(eq(collection.userId, userId))
      .groupBy(cardSets.collectionId)

    // Direct cards (no set, collectionId on cards table)
    const directTotalPerCollection = await db
      .select({ collectionId: cards.collectionId, total: count(cards.id) })
      .from(cards)
      .where(and(isNotNull(cards.collectionId), isNull(cards.setId)))
      .groupBy(cards.collectionId)

    const directOwnedPerCollection = await db
      .select({
        collectionId: cards.collectionId,
        owned: sql<number>`CAST(SUM(CASE WHEN ${collection.owned} = true THEN 1 ELSE 0 END) AS INTEGER)`,
      })
      .from(collection)
      .innerJoin(cards, and(eq(collection.cardId, cards.id), isNotNull(cards.collectionId), isNull(cards.setId)))
      .where(eq(collection.userId, userId))
      .groupBy(cards.collectionId)

    const totalMap = new Map(totalPerCollection.map(r => [r.collectionId, r.total]))
    const ownedMap = new Map(ownedPerCollection.map(r => [r.collectionId, r.owned]))

    for (const r of directTotalPerCollection) {
      if (r.collectionId !== null) totalMap.set(r.collectionId, (totalMap.get(r.collectionId) ?? 0) + r.total)
    }
    for (const r of directOwnedPerCollection) {
      if (r.collectionId !== null) ownedMap.set(r.collectionId, (ownedMap.get(r.collectionId) ?? 0) + (r.owned ?? 0))
    }

    return cols.map(c => {
      const total = totalMap.get(c.id) ?? 0
      const owned = ownedMap.get(c.id) ?? 0
      const percentage = total > 0 ? Math.round((owned / total) * 1000) / 10 : 0
      return {
        id: c.id,
        name: c.name,
        configured: c.configured,
        coverImageUrl: c.coverImage ? `/uploads/${c.coverImage}` : null,
        createdAt: c.createdAt,
        totalCards: c.configured ? total : 0,
        ownedCards: c.configured ? owned : 0,
        percentage: c.configured ? percentage : 0,
      }
    })
  })

  // POST /api/collections
  fastify.post<{ Body: { name: string } }>('/api/collections', {
    preHandler: [fastify.authenticate],
  }, async (request, reply) => {
    const { id: userId } = request.user as { id: number; email: string }
    const { name } = request.body

    if (!name?.trim()) {
      return reply.status(400).send({ error: 'El nombre es requerido' })
    }

    const result = await db
      .insert(userCollections)
      .values({ userId, name: name.trim() })
      .returning()

    return reply.status(201).send(result[0])
  })

  // GET /api/collections/sample-excel
  fastify.get('/api/collections/sample-excel', {
    preHandler: [fastify.authenticate],
  }, async (_request, reply) => {
    // language: 1=Español, 2=English, 3=Italiano, 4=Français, 5=Português, 6=Deutsch (opcional)
    const rows = [
      { code: 'LOB-001', 'own it': 1, first: 1, status: 1, ulti: 0, language: 1 },
      { code: 'LOB-002', 'own it': 0, first: null, status: null, ulti: 0, language: null },
      { code: 'LOB-003', 'own it': 1, first: 2, status: 2, ulti: 0, language: 2 },
      { code: 'MRD-001', 'own it': 0, first: null, status: null, ulti: 0, language: null },
    ]

    const ws = XLSX.utils.json_to_sheet(rows)
    ws['!cols'] = [{ wch: 10 }, { wch: 8 }, { wch: 7 }, { wch: 8 }, { wch: 6 }, { wch: 10 }]

    const wsRef = XLSX.utils.aoa_to_sheet([
      ['language', 'Idioma'],
      [1, 'Español'],
      [2, 'English'],
      [3, 'Italiano'],
      [4, 'Français'],
      [5, 'Português'],
      [6, 'Deutsch'],
      ['(vacío)', 'No especificado'],
    ])
    wsRef['!cols'] = [{ wch: 10 }, { wch: 12 }]

    const wb = XLSX.utils.book_new()
    XLSX.utils.book_append_sheet(wb, ws, 'Sheet1')
    XLSX.utils.book_append_sheet(wb, wsRef, 'Referencia')

    const buf = XLSX.write(wb, { type: 'buffer', bookType: 'xlsx' })
    reply
      .header('Content-Type', 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet')
      .header('Content-Disposition', 'attachment; filename="coleccion_ejemplo.xlsx"')
      .send(buf)
  })

  // GET /api/collections/:id
  fastify.get<{ Params: { id: string } }>('/api/collections/:id', {
    preHandler: [fastify.authenticate],
  }, async (request, reply) => {
    const { id: userId } = request.user as { id: number; email: string }
    const collectionId = parseInt(request.params.id)

    const cols = await db
      .select()
      .from(userCollections)
      .where(eq(userCollections.id, collectionId))
      .limit(1)

    if (!cols.length || cols[0].userId !== userId) {
      return reply.status(404).send({ error: 'Collection not found' })
    }

    return { ...cols[0], coverImageUrl: cols[0].coverImage ? `/uploads/${cols[0].coverImage}` : null }
  })

  // PATCH /api/collections/:id — update viewMode or name
  fastify.patch<{ Params: { id: string }; Body: { viewMode?: string } }>('/api/collections/:id', {
    preHandler: [fastify.authenticate],
  }, async (request, reply) => {
    const { id: userId } = request.user as { id: number; email: string }
    const collectionId = parseInt(request.params.id)
    const { viewMode } = request.body

    const [col] = await db.select().from(userCollections).where(eq(userCollections.id, collectionId)).limit(1)
    if (!col || col.userId !== userId) return reply.status(404).send({ error: 'Colección no encontrada' })

    const updates: Partial<typeof col> = {}
    if (viewMode === 'sets' || viewMode === 'cards') updates.viewMode = viewMode

    if (Object.keys(updates).length === 0) return reply.status(400).send({ error: 'Nada que actualizar' })

    await db.update(userCollections).set(updates).where(eq(userCollections.id, collectionId))
    return { ok: true }
  })

  // POST /api/collections/:id/cover
  fastify.post<{ Params: { id: string } }>('/api/collections/:id/cover', {
    preHandler: [fastify.authenticate],
  }, async (request, reply) => {
    const { id: userId } = request.user as { id: number; email: string }
    const collectionId = parseInt(request.params.id)

    const [col] = await db.select().from(userCollections).where(eq(userCollections.id, collectionId)).limit(1)
    if (!col || col.userId !== userId) return reply.status(404).send({ error: 'Colección no encontrada' })

    const data = await request.file()
    if (!data) return reply.status(400).send({ error: 'No se recibió archivo' })

    let ext = 'jpg'
    if (data.mimetype === 'image/png') ext = 'png'
    else if (data.mimetype === 'image/webp') ext = 'webp'

    // Eliminar imagen anterior si existe
    if (col.coverImage) {
      const oldPath = path.join(UPLOADS_DIR, col.coverImage)
      if (fs.existsSync(oldPath)) fs.unlinkSync(oldPath)
    }

    const filename = `col_${collectionId}_${Date.now()}.${ext}`
    await pipeline(data.file, fs.createWriteStream(path.join(UPLOADS_DIR, filename)))

    await db.update(userCollections).set({ coverImage: filename }).where(eq(userCollections.id, collectionId))

    return { coverImageUrl: `/uploads/${filename}` }
  })

  // GET /api/collections/:id/all-cards — flat card list for 'cards' viewMode
  fastify.get<{ Params: { id: string } }>('/api/collections/:id/all-cards', {
    preHandler: [fastify.authenticate],
  }, async (request, reply) => {
    const { id: userId } = request.user as { id: number; email: string }
    const collectionId = parseInt(request.params.id)

    const [col] = await db.select().from(userCollections).where(eq(userCollections.id, collectionId)).limit(1)
    if (!col || col.userId !== userId) return reply.status(404).send({ error: 'Colección no encontrada' })

    const setRows = await db
      .select({
        id: cards.id,
        name: cards.name,
        nameEn: cards.nameEn,
        cardCode: cards.cardCode,
        wikiUrl: cards.wikiUrl,
        passcode: cards.passcode,
        setCode: cardSets.code,
        owned: sql<boolean>`COALESCE(${collection.owned}, false)`,
        edition: collection.edition,
        condition: collection.condition,
        isUltimate: sql<boolean>`COALESCE(${collection.isUltimate}, false)`,
        language: collection.language,
      })
      .from(cards)
      .innerJoin(cardSets, eq(cards.setId, cardSets.id))
      .leftJoin(collection, and(eq(collection.cardId, cards.id), eq(collection.userId, userId)))
      .where(eq(cardSets.collectionId, collectionId))
      .orderBy(cardSets.orderIndex, cards.cardCode)

    const directRows = await db
      .select({
        id: cards.id,
        name: cards.name,
        nameEn: cards.nameEn,
        cardCode: cards.cardCode,
        wikiUrl: cards.wikiUrl,
        passcode: cards.passcode,
        owned: sql<boolean>`COALESCE(${collection.owned}, false)`,
        edition: collection.edition,
        condition: collection.condition,
        isUltimate: sql<boolean>`COALESCE(${collection.isUltimate}, false)`,
        language: collection.language,
      })
      .from(cards)
      .leftJoin(collection, and(eq(collection.cardId, cards.id), eq(collection.userId, userId)))
      .where(and(eq(cards.collectionId, collectionId), isNull(cards.setId)))
      .orderBy(cards.name)

    const rows = [
      ...setRows,
      ...directRows.map(r => ({ ...r, setCode: null as string | null })),
    ]

    const cardIds = rows.map(r => r.id)
    const photosMap = new Map<number, { id: number; url: string }[]>()
    if (cardIds.length > 0) {
      const photos = await db
        .select()
        .from(cardPhotos)
        .where(and(inArray(cardPhotos.cardId, cardIds), eq(cardPhotos.userId, userId)))
      for (const p of photos) {
        const arr = photosMap.get(p.cardId) ?? []
        arr.push({ id: p.id, url: `/uploads/${p.filename}` })
        photosMap.set(p.cardId, arr)
      }
    }

    return rows.map(r => ({ ...r, photos: photosMap.get(r.id) ?? [] }))
  })

  // DELETE /api/collections/:id/sets/:setCode
  fastify.delete<{ Params: { id: string; setCode: string } }>('/api/collections/:id/sets/:setCode', {
    preHandler: [fastify.authenticate],
  }, async (request, reply) => {
    const { id: userId } = request.user as { id: number; email: string }
    const collectionId = parseInt(request.params.id)
    const setCode = request.params.setCode.toUpperCase()

    const [col] = await db.select().from(userCollections).where(eq(userCollections.id, collectionId)).limit(1)
    if (!col || col.userId !== userId) return reply.status(404).send({ error: 'Colección no encontrada' })

    const [set] = await db.select().from(cardSets)
      .where(and(eq(cardSets.code, setCode), eq(cardSets.collectionId, collectionId)))
      .limit(1)
    if (!set) return reply.status(404).send({ error: 'Set no encontrado en esta colección' })

    const cardsInSet = await db.select({ id: cards.id }).from(cards).where(eq(cards.setId, set.id))
    const cardIds = cardsInSet.map(c => c.id)

    if (cardIds.length > 0) {
      await db.delete(collection).where(and(inArray(collection.cardId, cardIds), eq(collection.userId, userId)))
      await db.delete(cardPhotos).where(and(inArray(cardPhotos.cardId, cardIds), eq(cardPhotos.userId, userId)))
      // Orphan cards (set setId to null) so the FK allows deleting the set
      await db.update(cards).set({ setId: null }).where(inArray(cards.id, cardIds))
    }

    await db.delete(cardSets).where(eq(cardSets.id, set.id))
    return { ok: true }
  })

  // DELETE /api/collections/:id/cards/:cardId
  fastify.delete<{ Params: { id: string; cardId: string } }>('/api/collections/:id/cards/:cardId', {
    preHandler: [fastify.authenticate],
  }, async (request, reply) => {
    const { id: userId } = request.user as { id: number; email: string }
    const collectionId = parseInt(request.params.id)
    const cardId = parseInt(request.params.cardId)

    const [col] = await db.select().from(userCollections).where(eq(userCollections.id, collectionId)).limit(1)
    if (!col || col.userId !== userId) return reply.status(404).send({ error: 'Colección no encontrada' })

    const [card] = await db.select().from(cards).where(eq(cards.id, cardId)).limit(1)
    if (!card) return reply.status(404).send({ error: 'Carta no encontrada' })

    await db.delete(collection).where(and(eq(collection.cardId, cardId), eq(collection.userId, userId)))
    await db.delete(cardPhotos).where(and(eq(cardPhotos.cardId, cardId), eq(cardPhotos.userId, userId)))

    // Check if any other user still tracks this card
    const [otherEntry] = await db.select({ id: collection.id }).from(collection)
      .where(and(eq(collection.cardId, cardId), not(eq(collection.userId, userId))))
      .limit(1)

    if (!otherEntry) {
      // No other users reference this card — safe to delete it
      await db.delete(cards).where(eq(cards.id, cardId))
    } else if (card.setId !== null) {
      // Other users have this card — orphan it from the set so it disappears from this set's view
      await db.update(cards).set({ setId: null }).where(eq(cards.id, cardId))
    }

    return { ok: true }
  })

  // DELETE /api/collections/:id
  fastify.delete<{ Params: { id: string }; Body: { password: string } }>('/api/collections/:id', {
    preHandler: [fastify.authenticate],
  }, async (request, reply) => {
    const { id: userId } = request.user as { id: number; email: string }
    const collectionId = parseInt(request.params.id)
    const { password } = request.body

    if (!password) {
      return reply.status(400).send({ error: 'La contraseña es requerida' })
    }

    const [user] = await db.select().from(users).where(eq(users.id, userId)).limit(1)
    if (!user || !(await bcrypt.compare(password, user.passwordHash))) {
      return reply.status(401).send({ error: 'Contraseña incorrecta' })
    }

    const [col] = await db.select().from(userCollections).where(eq(userCollections.id, collectionId)).limit(1)
    if (!col || col.userId !== userId) {
      return reply.status(404).send({ error: 'Colección no encontrada' })
    }

    await db.delete(userCollections).where(eq(userCollections.id, collectionId))
    return reply.status(204).send()
  })
}
