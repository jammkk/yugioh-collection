import { FastifyInstance } from 'fastify'
import { drizzle } from 'drizzle-orm/postgres-js'
import postgres from 'postgres'
import { cardSets, cards, collection, cardPhotos } from '../db/schema'
import { eq, sql, count, inArray, and } from 'drizzle-orm'

export async function setsRoutes(fastify: FastifyInstance) {
  const connectionString = process.env.DATABASE_URL || 'postgresql://yugioh:yugioh@localhost:5434/collection'
  const client = postgres(connectionString)
  const db = drizzle(client)

  // GET /api/sets?collectionId=X
  fastify.get<{ Querystring: { collectionId?: string } }>('/api/sets', {
    preHandler: [fastify.authenticate],
  }, async (request, _reply) => {
    const { id: userId } = request.user as { id: number; email: string }
    const collectionId = request.query.collectionId ? parseInt(request.query.collectionId) : null

    const result = await db
      .select({
        id: cardSets.id,
        code: cardSets.code,
        name: cardSets.name,
        orderIndex: cardSets.orderIndex,
        totalCards: count(cards.id),
        ownedCards: sql<number>`CAST(SUM(CASE WHEN ${collection.owned} = true THEN 1 ELSE 0 END) AS INTEGER)`,
      })
      .from(cardSets)
      .leftJoin(cards, eq(cards.setId, cardSets.id))
      .leftJoin(collection, and(eq(collection.cardId, cards.id), eq(collection.userId, userId)))
      .where(collectionId ? eq(cardSets.collectionId, collectionId) : undefined)
      .groupBy(cardSets.id)
      .orderBy(cardSets.orderIndex)

    return result.map(s => ({
      ...s,
      ownedCards: s.ownedCards || 0,
      percentage: s.totalCards > 0 ? Math.round((s.ownedCards / s.totalCards) * 1000) / 10 : 0,
    }))
  })

  // GET /api/sets/:setCode/cards
  fastify.get<{ Params: { setCode: string } }>('/api/sets/:setCode/cards', {
    preHandler: [fastify.authenticate],
  }, async (request, reply) => {
    const { setCode } = request.params
    const { id: userId } = request.user as { id: number; email: string }

    const set = await db
      .select()
      .from(cardSets)
      .where(eq(cardSets.code, setCode.toUpperCase()))
      .limit(1)

    if (!set.length) {
      return reply.status(404).send({ error: 'Set not found' })
    }

    const result = await db
      .select({
        id: cards.id,
        name: cards.name,
        cardCode: cards.cardCode,
        wikiUrl: cards.wikiUrl,
        passcode: cards.passcode,
        owned: collection.owned,
        edition: collection.edition,
        condition: collection.condition,
        isUltimate: collection.isUltimate,
        language: collection.language,
      })
      .from(cards)
      .leftJoin(collection, and(eq(collection.cardId, cards.id), eq(collection.userId, userId)))
      .where(eq(cards.setId, set[0].id))
      .orderBy(cards.cardCode)

    const cardIds = result.map(c => c.id)
    const photos = cardIds.length > 0
      ? await db.select().from(cardPhotos).where(
          and(inArray(cardPhotos.cardId, cardIds), eq(cardPhotos.userId, userId))
        )
      : []

    const photosByCard = new Map<number, { id: number; url: string }[]>()
    for (const p of photos) {
      if (!photosByCard.has(p.cardId)) photosByCard.set(p.cardId, [])
      photosByCard.get(p.cardId)!.push({ id: p.id, url: `/uploads/${p.filename}` })
    }

    return result.map(c => ({
      ...c,
      owned: c.owned ?? false,
      isUltimate: c.isUltimate ?? false,
      photos: photosByCard.get(c.id) ?? [],
    }))
  })
}
