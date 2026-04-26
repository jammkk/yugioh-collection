# yugioh-collection

App de seguimiento de colección de cartas Yu-Gi-Oh formato GOAT (LOB → TLM).

## Stack

- **Frontend**: React 18, Vite, TypeScript, Tailwind, TanStack Query
- **Backend**: Fastify 4, TypeScript, Drizzle ORM, PostgreSQL
- **Auth**: JWT via Authorization header + localStorage
- **Deploy**: Vercel (frontend) + Render (backend) + Railway (PostgreSQL)

## Tests

Los tests están en `frontend/src/test/` y se corren con Vitest.

```bash
cd frontend && npm test          # correr tests una vez
cd frontend && npm run test:watch # modo watch
```

**Regla importante**: Antes de hacer cualquier commit, revisar y correr los tests. Si se agrega una feature nueva o se modifica lógica existente, agregar o actualizar los tests correspondientes. Husky corre los tests automáticamente en cada pre-commit.

## Flujo de trabajo

- Siempre crear una rama descriptiva antes de empezar cambios
- Abrir PR para revisión antes de mergear a `main`
- Para cambios de estructura en BD: correr `npm run migrate` apuntando a Railway

## Variables de entorno

Ver `backend/.env.example` y `frontend/.env.example`.
