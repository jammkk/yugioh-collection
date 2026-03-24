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
    CREATE TABLE IF NOT EXISTS "users" (
      "id" serial PRIMARY KEY NOT NULL,
      "email" varchar(255) NOT NULL UNIQUE,
      "password_hash" varchar(255) NOT NULL,
      "name" varchar(100) NOT NULL,
      "created_at" timestamp NOT NULL DEFAULT now()
    )
  `

  await sql`
    CREATE TABLE IF NOT EXISTS "collection" (
      "id" serial PRIMARY KEY NOT NULL,
      "card_id" integer NOT NULL REFERENCES "cards"("id"),
      "owned" boolean NOT NULL DEFAULT false,
      "edition" smallint,
      "condition" smallint,
      "is_ultimate" boolean NOT NULL DEFAULT false
    )
  `

  await sql`ALTER TABLE cards ADD COLUMN IF NOT EXISTS passcode INTEGER`
  await sql`ALTER TABLE collection ADD COLUMN IF NOT EXISTS notes VARCHAR(1000)`
  await sql`ALTER TABLE collection ADD COLUMN IF NOT EXISTS language SMALLINT`
  await sql`ALTER TABLE collection DROP COLUMN IF EXISTS photo_url`

  await sql`
    CREATE TABLE IF NOT EXISTS "card_photos" (
      "id" serial PRIMARY KEY NOT NULL,
      "card_id" integer NOT NULL REFERENCES "cards"("id"),
      "filename" varchar(255) NOT NULL,
      "created_at" timestamp NOT NULL DEFAULT now()
    )
  `

  // Auth migration: add user_id to collection and card_photos
  // Insert a default user to own existing data
  await sql`
    INSERT INTO users (email, password_hash, name)
    VALUES ('default@yugioh.local', 'PLACEHOLDER_NOT_USABLE', 'Default User')
    ON CONFLICT (email) DO NOTHING
  `

  await sql`ALTER TABLE collection ADD COLUMN IF NOT EXISTS user_id INTEGER REFERENCES users(id)`
  await sql`
    UPDATE collection
    SET user_id = (SELECT id FROM users WHERE email = 'default@yugioh.local')
    WHERE user_id IS NULL
  `

  // Drop old unique constraint on card_id and add composite unique (card_id, user_id)
  await sql`ALTER TABLE collection DROP CONSTRAINT IF EXISTS collection_card_id_key`
  await sql`
    DO $$
    BEGIN
      IF NOT EXISTS (
        SELECT 1 FROM pg_constraint WHERE conname = 'collection_card_user_unique'
      ) THEN
        ALTER TABLE collection ADD CONSTRAINT collection_card_user_unique UNIQUE (card_id, user_id);
      END IF;
    END $$
  `

  await sql`ALTER TABLE card_photos ADD COLUMN IF NOT EXISTS user_id INTEGER REFERENCES users(id)`
  await sql`
    UPDATE card_photos
    SET user_id = (SELECT id FROM users WHERE email = 'default@yugioh.local')
    WHERE user_id IS NULL
  `

  console.log('Migrations complete!')
  await sql.end()
  process.exit(0)
}

runMigrations().catch((err) => {
  console.error('Migration failed:', err)
  process.exit(1)
})
