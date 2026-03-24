import { FastifyInstance } from 'fastify'
import { drizzle } from 'drizzle-orm/postgres-js'
import postgres from 'postgres'
import { cardPhotos } from '../db/schema'
import { eq, and } from 'drizzle-orm'
import * as fs from 'fs'
import * as path from 'path'
import { pipeline } from 'stream/promises'

const UPLOADS_DIR = path.join(process.cwd(), 'uploads')

export async function photosRoutes(fastify: FastifyInstance) {
  const connectionString = process.env.DATABASE_URL || 'postgresql://yugioh:yugioh@localhost:5434/collection'
  const client = postgres(connectionString)
  const db = drizzle(client)

  fs.mkdirSync(UPLOADS_DIR, { recursive: true })

  // POST /api/cards/:cardId/photos
  fastify.post<{ Params: { cardId: string } }>('/api/cards/:cardId/photos', {
    preHandler: [fastify.authenticate],
  }, async (request, reply) => {
    const cardId = parseInt(request.params.cardId)
    if (isNaN(cardId)) return reply.status(400).send({ error: 'Invalid card ID' })

    const { id: userId } = request.user as { id: number; email: string }

    const data = await request.file()
    if (!data) return reply.status(400).send({ error: 'No file uploaded' })

    let ext = 'jpg'
    if (data.mimetype === 'image/png') ext = 'png'
    else if (data.mimetype === 'image/webp') ext = 'webp'
    else if (data.mimetype === 'image/gif') ext = 'gif'

    const filename = `${cardId}_${Date.now()}.${ext}`
    const filePath = path.join(UPLOADS_DIR, filename)

    await pipeline(data.file, fs.createWriteStream(filePath))

    const [photo] = await db.insert(cardPhotos)
      .values({ cardId, userId, filename })
      .returning()

    return { id: photo.id, url: `/uploads/${filename}` }
  })

  // DELETE /api/cards/:cardId/photos/:photoId
  fastify.delete<{ Params: { cardId: string; photoId: string } }>(
    '/api/cards/:cardId/photos/:photoId', {
      preHandler: [fastify.authenticate],
    },
    async (request, reply) => {
      const cardId = parseInt(request.params.cardId)
      const photoId = parseInt(request.params.photoId)
      if (isNaN(cardId) || isNaN(photoId)) return reply.status(400).send({ error: 'Invalid ID' })

      const { id: userId } = request.user as { id: number; email: string }

      const [photo] = await db.select()
        .from(cardPhotos)
        .where(and(eq(cardPhotos.id, photoId), eq(cardPhotos.cardId, cardId), eq(cardPhotos.userId, userId)))
        .limit(1)

      if (!photo) return reply.status(404).send({ error: 'Photo not found' })

      const filePath = path.join(UPLOADS_DIR, photo.filename)
      if (fs.existsSync(filePath)) fs.unlinkSync(filePath)

      await db.delete(cardPhotos).where(eq(cardPhotos.id, photoId))

      reply.status(204).send()
    }
  )
}
