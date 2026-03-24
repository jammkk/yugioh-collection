import { FastifyInstance } from 'fastify'
import { drizzle } from 'drizzle-orm/postgres-js'
import postgres from 'postgres'
import { userCollections, collection, cards } from '../db/schema'
import { eq, sql, count } from 'drizzle-orm'

export async function collectionsRoutes(fastify: FastifyInstance) {
  const connectionString = process.env.DATABASE_URL || 'postgresql://yugioh:yugioh@localhost:5434/collection'
  const client = postgres(connectionString)
  const db = drizzle(client)

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

    const totalCards = await db
      .select({ total: count(cards.id) })
      .from(cards)

    const ownedCards = await db
      .select({
        owned: sql<number>`CAST(SUM(CASE WHEN ${collection.owned} = true THEN 1 ELSE 0 END) AS INTEGER)`,
      })
      .from(collection)
      .where(eq(collection.userId, userId))

    const total = totalCards[0]?.total ?? 0
    const owned = ownedCards[0]?.owned ?? 0
    const percentage = total > 0 ? Math.round((owned / total) * 1000) / 10 : 0

    return cols.map(c => ({
      id: c.id,
      name: c.name,
      createdAt: c.createdAt,
      totalCards: total,
      ownedCards: owned,
      percentage,
    }))
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

    return cols[0]
  })
}
