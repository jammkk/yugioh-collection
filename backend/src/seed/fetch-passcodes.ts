import postgres from 'postgres'

const connectionString = process.env.DATABASE_URL || 'postgresql://yugioh:yugioh@localhost:5434/collection'

const SETS_API = [
  { code: 'LOB', apiName: 'Legend of Blue Eyes White Dragon' },
  { code: 'MRD', apiName: 'Metal Raiders' },
  { code: 'SRL', apiName: 'Spell Ruler' },
  { code: 'PSV', apiName: "Pharaoh's Servant" },
  { code: 'LON', apiName: 'Labyrinth of Nightmare' },
  { code: 'LOD', apiName: 'Legacy of Darkness' },
  { code: 'PGD', apiName: 'Pharaonic Guardian' },
  { code: 'MFC', apiName: "Magician's Force" },
  { code: 'DCR', apiName: 'Dark Crisis' },
  { code: 'IOC', apiName: 'Invasion of Chaos' },
  { code: 'AST', apiName: 'Ancient Sanctuary' },
  { code: 'SOD', apiName: 'Soul of the Duelist' },
  { code: 'RDS', apiName: 'Rise of Destiny' },
  { code: 'FET', apiName: 'Flaming Eternity' },
  { code: 'TLM', apiName: 'The Lost Millennium' },
]

interface YGOCard {
  id: number
  name: string
  card_sets?: Array<{ set_code: string }>
}

interface YGOAPIResponse {
  data: YGOCard[]
}

function delay(ms: number): Promise<void> {
  return new Promise(resolve => setTimeout(resolve, ms))
}

async function fetchPasscodes() {
  const sql = postgres(connectionString, { max: 1 })

  console.log('Fetching passcodes from YGOPRODeck API...')

  let totalUpdated = 0

  for (const set of SETS_API) {
    console.log(`\nFetching set: ${set.apiName} (${set.code})`)

    try {
      const url = `https://db.ygoprodeck.com/api/v7/cardinfo.php?cardset=${encodeURIComponent(set.apiName)}`
      const response = await fetch(url)

      if (!response.ok) {
        console.error(`  Failed to fetch ${set.apiName}: HTTP ${response.status}`)
        await delay(500)
        continue
      }

      const data: YGOAPIResponse = await response.json()

      if (!data.data || !Array.isArray(data.data)) {
        console.error(`  No data returned for ${set.apiName}`)
        await delay(500)
        continue
      }

      console.log(`  Got ${data.data.length} cards from API`)

      let setUpdated = 0
      for (const apiCard of data.data) {
        if (!apiCard.card_sets) continue

        for (const cardSet of apiCard.card_sets) {
          const cardCode = cardSet.set_code
          // Check if this card_code belongs to our set
          if (!cardCode.toUpperCase().startsWith(set.code + '-')) continue

          const result = await sql`
            UPDATE cards SET passcode = ${apiCard.id}
            WHERE card_code = ${cardCode}
            RETURNING id, card_code
          `

          if (result.length > 0) {
            setUpdated++
            totalUpdated++
          }
        }
      }

      console.log(`  Updated ${setUpdated} cards for ${set.code}`)
    } catch (err) {
      console.error(`  Error fetching ${set.apiName}:`, err)
    }

    await delay(500)
  }

  console.log(`\nDone! Total cards updated: ${totalUpdated}`)
  await sql.end()
  process.exit(0)
}

fetchPasscodes().catch((err) => {
  console.error('fetch-passcodes failed:', err)
  process.exit(1)
})
