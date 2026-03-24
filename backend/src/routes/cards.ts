import { FastifyInstance } from 'fastify'
import { drizzle } from 'drizzle-orm/postgres-js'
import postgres from 'postgres'
import { cardSets, cards, collection, cardPhotos } from '../db/schema'
import { eq, sql, ilike, count, and } from 'drizzle-orm'

export async function cardsRoutes(fastify: FastifyInstance) {
  const connectionString = process.env.DATABASE_URL || 'postgresql://yugioh:yugioh@localhost:5434/collection'
  const client = postgres(connectionString)
  const db = drizzle(client)

  // PATCH /api/cards/:cardId/collection
  fastify.patch<{
    Params: { cardId: string }
    Body: { owned?: boolean; edition?: number | null; condition?: number | null; is_ultimate?: boolean; notes?: string | null }
  }>('/api/cards/:cardId/collection', {
    preHandler: [fastify.authenticate],
  }, async (request, reply) => {
    const cardId = parseInt(request.params.cardId)
    if (isNaN(cardId)) return reply.status(400).send({ error: 'Invalid card ID' })

    const { id: userId } = request.user as { id: number; email: string }
    const { owned, edition, condition, is_ultimate, notes } = request.body

    const existing = await db.select().from(collection)
      .where(and(eq(collection.cardId, cardId), eq(collection.userId, userId)))
      .limit(1)

    if (existing.length) {
      await db.update(collection)
        .set({
          ...(owned !== undefined && { owned }),
          ...(edition !== undefined && { edition }),
          ...(condition !== undefined && { condition }),
          ...(is_ultimate !== undefined && { isUltimate: is_ultimate }),
          ...(notes !== undefined && { notes }),
        })
        .where(and(eq(collection.cardId, cardId), eq(collection.userId, userId)))
    } else {
      await db.insert(collection).values({
        cardId,
        userId,
        owned: owned ?? false,
        edition: edition ?? null,
        condition: condition ?? null,
        isUltimate: is_ultimate ?? false,
        notes: notes ?? null,
      })
    }

    const [updated] = await db.select().from(collection)
      .where(and(eq(collection.cardId, cardId), eq(collection.userId, userId)))
      .limit(1)
    return updated
  })

  // GET /api/cards/search?q=
  fastify.get<{ Querystring: { q?: string } }>('/api/cards/search', {
    preHandler: [fastify.authenticate],
  }, async (request, _reply) => {
    const q = request.query.q || ''
    if (!q.trim()) return []

    const { id: userId } = request.user as { id: number; email: string }

    const result = await db
      .select({
        id: cards.id,
        name: cards.name,
        cardCode: cards.cardCode,
        wikiUrl: cards.wikiUrl,
        passcode: cards.passcode,
        setCode: cardSets.code,
        setName: cardSets.name,
        owned: collection.owned,
        edition: collection.edition,
        condition: collection.condition,
        isUltimate: collection.isUltimate,
      })
      .from(cards)
      .leftJoin(cardSets, eq(cards.setId, cardSets.id))
      .leftJoin(collection, and(eq(collection.cardId, cards.id), eq(collection.userId, userId)))
      .where(ilike(cards.name, `%${q}%`))
      .limit(50)

    return result
  })

  // GET /api/cards/:cardId
  fastify.get<{ Params: { cardId: string } }>('/api/cards/:cardId', {
    preHandler: [fastify.authenticate],
  }, async (request, reply) => {
    const cardId = parseInt(request.params.cardId)
    if (isNaN(cardId)) return reply.status(400).send({ error: 'Invalid card ID' })

    const { id: userId } = request.user as { id: number; email: string }

    const [card] = await db
      .select({
        id: cards.id,
        name: cards.name,
        cardCode: cards.cardCode,
        wikiUrl: cards.wikiUrl,
        passcode: cards.passcode,
        setCode: cardSets.code,
        setName: cardSets.name,
        owned: collection.owned,
        edition: collection.edition,
        condition: collection.condition,
        isUltimate: collection.isUltimate,
        notes: collection.notes,
      })
      .from(cards)
      .leftJoin(cardSets, eq(cards.setId, cardSets.id))
      .leftJoin(collection, and(eq(collection.cardId, cards.id), eq(collection.userId, userId)))
      .where(eq(cards.id, cardId))
      .limit(1)

    if (!card) return reply.status(404).send({ error: 'Card not found' })

    const photos = await db.select().from(cardPhotos)
      .where(and(eq(cardPhotos.cardId, cardId), eq(cardPhotos.userId, userId)))

    return {
      ...card,
      owned: card.owned ?? false,
      isUltimate: card.isUltimate ?? false,
      photos: photos.map(p => ({ id: p.id, url: `/uploads/${p.filename}` })),
    }
  })

  // GET /api/stats
  fastify.get('/api/stats', {
    preHandler: [fastify.authenticate],
  }, async (request, _reply) => {
    const { id: userId } = request.user as { id: number; email: string }

    const totalResult = await db.select({ total: count(cards.id) }).from(cards)
    const ownedResult = await db
      .select({ owned: sql<number>`CAST(COUNT(*) AS INTEGER)` })
      .from(collection)
      .where(and(eq(collection.owned, true), eq(collection.userId, userId)))

    const total = totalResult[0]?.total ?? 0
    const owned = ownedResult[0]?.owned ?? 0

    const setsResult = await db
      .select({
        id: cardSets.id,
        code: cardSets.code,
        name: cardSets.name,
        totalCards: count(cards.id),
        ownedCards: sql<number>`CAST(SUM(CASE WHEN ${collection.owned} = true THEN 1 ELSE 0 END) AS INTEGER)`,
      })
      .from(cardSets)
      .leftJoin(cards, eq(cards.setId, cardSets.id))
      .leftJoin(collection, and(eq(collection.cardId, cards.id), eq(collection.userId, userId)))
      .groupBy(cardSets.id)
      .orderBy(cardSets.orderIndex)

    return {
      total_cards: total,
      owned_cards: owned,
      percentage: total > 0 ? Math.round((owned / total) * 1000) / 10 : 0,
      sets: setsResult.map(s => ({
        ...s,
        ownedCards: s.ownedCards || 0,
        percentage: s.totalCards > 0 ? Math.round(((s.ownedCards || 0) / s.totalCards) * 1000) / 10 : 0,
      })),
    }
  })
}
