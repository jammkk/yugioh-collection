import Fastify, { FastifyRequest, FastifyReply } from 'fastify'
import cors from '@fastify/cors'
import sensible from '@fastify/sensible'
import multipart from '@fastify/multipart'
import fastifyStatic from '@fastify/static'
import fastifyCookie from '@fastify/cookie'
import fastifyJwt from '@fastify/jwt'
import * as path from 'path'
import { setsRoutes } from './routes/sets'
import { cardsRoutes } from './routes/cards'
import { photosRoutes } from './routes/photos'
import { authRoutes } from './routes/auth'

declare module '@fastify/jwt' {
  interface FastifyJWT {
    payload: { id: number; email: string }
    user: { id: number; email: string }
  }
}

declare module 'fastify' {
  interface FastifyInstance {
    authenticate: (request: FastifyRequest, reply: FastifyReply) => Promise<void>
  }
}

const fastify = Fastify({ logger: true })

async function main() {
  const allowedOrigins = process.env.ALLOWED_ORIGINS
    ? process.env.ALLOWED_ORIGINS.split(',')
    : ['http://localhost:5173', 'http://127.0.0.1:5173', 'http://localhost:5174']

  await fastify.register(cors, {
    origin: allowedOrigins,
    credentials: true,
  })
  await fastify.register(sensible)
  await fastify.register(multipart)
  await fastify.register(fastifyCookie)
  await fastify.register(fastifyJwt, {
    secret: process.env.JWT_SECRET || 'yugioh-jwt-dev-secret-2024',
  })

  fastify.decorate('authenticate', async (request: FastifyRequest, reply: FastifyReply) => {
    try {
      await request.jwtVerify()
    } catch {
      reply.status(401).send({ error: 'No autorizado' })
    }
  })

  await fastify.register(fastifyStatic, {
    root: path.join(process.cwd(), 'uploads'),
    prefix: '/uploads/',
  })

  await fastify.register(authRoutes)
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
