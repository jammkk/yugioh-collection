import postgres from 'postgres'

const connectionString = process.env.DATABASE_URL || 'postgresql://yugioh:yugioh@localhost:5434/collection'

async function runMigrations() {
  const sql = postgres(connectionString, { max: 1 })

  console.log('Running migrations...')

  await sql`
    CREATE TABLE IF NOT EXISTS "card_sets" (
      "id" serial PRIMARY KEY NOT NULL,
      "code" varchar(10) NOT NULL UNIQUE,
      "name" varchar(255) NOT NULL,
      "order_index" integer NOT NULL
    )
  `

  await sql`
    CREATE TABLE IF NOT EXISTS "cards" (
      "id" serial PRIMARY KEY NOT NULL,
      "name" varchar(255) NOT NULL,
      "card_code" varchar(20) NOT NULL UNIQUE,
      "set_id" integer NOT NULL REFERENCES "card_sets"("id"),
      "wiki_url" varchar(500)
    )
  `

  await sql`
    CREATE TABLE IF NOT EXISTS "collection" (
      "id" serial PRIMARY KEY NOT NULL,
      "card_id" integer NOT NULL UNIQUE REFERENCES "cards"("id"),
      "owned" boolean NOT NULL DEFAULT false,
      "edition" smallint,
      "condition" smallint,
      "is_ultimate" boolean NOT NULL DEFAULT false
    )
  `

  await sql`ALTER TABLE cards ADD COLUMN IF NOT EXISTS passcode INTEGER`
  await sql`ALTER TABLE collection ADD COLUMN IF NOT EXISTS notes VARCHAR(1000)`
  await sql`ALTER TABLE collection DROP COLUMN IF EXISTS photo_url`

  await sql`
    CREATE TABLE IF NOT EXISTS "card_photos" (
      "id" serial PRIMARY KEY NOT NULL,
      "card_id" integer NOT NULL REFERENCES "cards"("id"),
      "filename" varchar(255) NOT NULL,
      "created_at" timestamp NOT NULL DEFAULT now()
    )
  `

  console.log('Migrations complete!')
  await sql.end()
  process.exit(0)
}

runMigrations().catch((err) => {
  console.error('Migration failed:', err)
  process.exit(1)
})
