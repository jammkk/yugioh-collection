import postgres from 'postgres'
import { drizzle } from 'drizzle-orm/postgres-js'
import { cardSets, cards, collection, users } from '../db/schema'
import { parseExcel } from './parseExcel'
import { eq } from 'drizzle-orm'
import path from 'path'

const SETS = [
  { code: 'LOB', name: 'Legend of Blue Eyes White Dragon', orderIndex: 1 },
  { code: 'MRD', name: 'Metal Raiders', orderIndex: 2 },
  { code: 'SRL', name: 'Spell Ruler', orderIndex: 3 },
  { code: 'PSV', name: 'Pharaoh Servant', orderIndex: 4 },
  { code: 'LON', name: 'Labyrinth of Nightmare', orderIndex: 5 },
  { code: 'LOD', name: 'Legacy of Darkness', orderIndex: 6 },
  { code: 'PGD', name: 'Pharaonic Guardian', orderIndex: 7 },
  { code: 'MFC', name: 'Magician Force', orderIndex: 8 },
  { code: 'DCR', name: 'Dark Crisis', orderIndex: 9 },
  { code: 'IOC', name: 'Invasion of Chaos', orderIndex: 10 },
  { code: 'AST', name: 'Ancient Sanctuary', orderIndex: 11 },
  { code: 'SOD', name: 'Soul of the Duelist', orderIndex: 12 },
  { code: 'RDS', name: 'Rise of Destiny', orderIndex: 13 },
  { code: 'FET', name: 'Flaming Eternity', orderIndex: 14 },
  { code: 'TLM', name: 'The Lost Millennium', orderIndex: 15 },
]

async function seed() {
  const excelPath = process.argv[2]
  if (!excelPath) {
    console.error('Usage: npm run seed -- <path-to-excel>')
    process.exit(1)
  }

  const absolutePath = path.resolve(process.cwd(), excelPath)
  console.log(`Reading Excel from: ${absolutePath}`)

  const rows = parseExcel(absolutePath)
  console.log(`Parsed ${rows.length} card rows`)

  const connectionString = process.env.DATABASE_URL || 'postgresql://yugioh:yugioh@localhost:5434/collection'
  const sql = postgres(connectionString)
  const db = drizzle(sql)

  // Insert sets
  console.log('Seeding sets...')
  for (const set of SETS) {
    await db.insert(cardSets)
      .values(set)
      .onConflictDoUpdate({
        target: cardSets.code,
        set: { name: set.name, orderIndex: set.orderIndex }
      })
  }

  // Get default user for seeding
  const [defaultUser] = await db.select().from(users).where(eq(users.email, 'default@yugioh.local')).limit(1)
  const seedUserId = defaultUser?.id ?? 1

  // Get set map
  const setsInDb = await db.select().from(cardSets)
  const setMap = new Map(setsInDb.map(s => [s.code, s.id]))

  // Insert cards and collection
  console.log('Seeding cards...')
  let inserted = 0
  for (const row of rows) {
    const setId = setMap.get(row.set_code)
    if (!setId) {
      console.warn(`Unknown set code: ${row.set_code} for card ${row.card_code}`)
      continue
    }

    // Insert card
    const [card] = await db.insert(cards)
      .values({
        name: row.name,
        cardCode: row.card_code,
        setId,
        wikiUrl: row.wiki_url,
      })
      .onConflictDoUpdate({
        target: cards.cardCode,
        set: { name: row.name, wikiUrl: row.wiki_url }
      })
      .returning()

    // Insert collection entry
    await db.insert(collection)
      .values({
        cardId: card.id,
        userId: seedUserId,
        owned: row.owned,
        edition: row.edition,
        condition: row.condition,
        isUltimate: row.is_ultimate,
      })
      .onConflictDoUpdate({
        target: [collection.cardId, collection.userId],
        set: {
          owned: row.owned,
          edition: row.edition,
          condition: row.condition,
          isUltimate: row.is_ultimate,
        }
      })

    inserted++
  }

  console.log(`Seeded ${inserted} cards successfully!`)
  await sql.end()
  process.exit(0)
}

seed().catch((err) => {
  console.error('Seed failed:', err)
  process.exit(1)
})
