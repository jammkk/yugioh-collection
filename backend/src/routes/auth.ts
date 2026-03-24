import { FastifyInstance } from 'fastify'
import { drizzle } from 'drizzle-orm/postgres-js'
import postgres from 'postgres'
import { users } from '../db/schema'
import { eq } from 'drizzle-orm'
import bcrypt from 'bcryptjs'

export async function authRoutes(fastify: FastifyInstance) {
  const connectionString = process.env.DATABASE_URL || 'postgresql://yugioh:yugioh@localhost:5434/collection'
  const client = postgres(connectionString)
  const db = drizzle(client)

  // POST /api/auth/register
  fastify.post<{
    Body: { email: string; password: string; name: string }
  }>('/api/auth/register', async (request, reply) => {
    const { email, password, name } = request.body

    if (!email || !password || !name) {
      return reply.status(400).send({ error: 'Email, contraseña y nombre son requeridos' })
    }
    if (password.length < 6) {
      return reply.status(400).send({ error: 'La contraseña debe tener al menos 6 caracteres' })
    }

    const existing = await db.select().from(users).where(eq(users.email, email.toLowerCase())).limit(1)
    if (existing.length) {
      return reply.status(409).send({ error: 'Este email ya está registrado' })
    }

    const passwordHash = await bcrypt.hash(password, 12)
    const [user] = await db.insert(users).values({
      email: email.toLowerCase(),
      passwordHash,
      name: name.trim(),
    }).returning({ id: users.id, email: users.email, name: users.name })

    const token = fastify.jwt.sign({ id: user.id, email: user.email })
    return { user: { id: user.id, email: user.email, name: user.name }, token }
  })

  // POST /api/auth/login
  fastify.post<{
    Body: { email: string; password: string }
  }>('/api/auth/login', async (request, reply) => {
    const { email, password } = request.body

    if (!email || !password) {
      return reply.status(400).send({ error: 'Email y contraseña son requeridos' })
    }

    const [user] = await db.select().from(users).where(eq(users.email, email.toLowerCase())).limit(1)

    if (!user || !(await bcrypt.compare(password, user.passwordHash))) {
      return reply.status(401).send({ error: 'Credenciales inválidas' })
    }

    const token = fastify.jwt.sign({ id: user.id, email: user.email })
    return { user: { id: user.id, email: user.email, name: user.name }, token }
  })

  // POST /api/auth/logout
  fastify.post('/api/auth/logout', async () => {
    return { ok: true }
  })

  // GET /api/auth/me
  fastify.get('/api/auth/me', {
    preHandler: [fastify.authenticate],
  }, async (request, reply) => {
    const { id } = request.user as { id: number; email: string }
    const [user] = await db.select({
      id: users.id,
      email: users.email,
      name: users.name,
    }).from(users).where(eq(users.id, id)).limit(1)

    if (!user) return reply.status(404).send({ error: 'Usuario no encontrado' })
    return { user }
  })
}
