import Fastify from 'fastify'
import cors from '@fastify/cors'
import sensible from '@fastify/sensible'
import multipart from '@fastify/multipart'
import fastifyStatic from '@fastify/static'
import * as path from 'path'
import { setsRoutes } from './routes/sets'
import { cardsRoutes } from './routes/cards'
import { photosRoutes } from './routes/photos'

const fastify = Fastify({ logger: true })

async function main() {
  await fastify.register(cors, {
    origin: ['http://localhost:5173', 'http://127.0.0.1:5173'],
  })
  await fastify.register(sensible)
  await fastify.register(multipart)
  await fastify.register(fastifyStatic, {
    root: path.join(process.cwd(), 'uploads'),
    prefix: '/uploads/',
  })

  await fastify.register(setsRoutes)
  await fastify.register(cardsRoutes)
  await fastify.register(photosRoutes)

  fastify.get('/health', async () => ({ status: 'ok' }))

  await fastify.listen({ port: 3000, host: '0.0.0.0' })
  console.log('Server running on http://localhost:3000')
}

main().catch((err) => {
  fastify.log.error(err)
  process.exit(1)
})
