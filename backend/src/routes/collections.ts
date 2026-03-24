import { FastifyInstance } from 'fastify'
import { drizzle } from 'drizzle-orm/postgres-js'
import postgres from 'postgres'
import { userCollections, collection, cards, cardSets, users } from '../db/schema'
import { eq, sql, count } from 'drizzle-orm'
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

    const totalMap = new Map(totalPerCollection.map(r => [r.collectionId, r.total]))
    const ownedMap = new Map(ownedPerCollection.map(r => [r.collectionId, r.owned]))

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
