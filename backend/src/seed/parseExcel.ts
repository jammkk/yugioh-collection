import * as XLSX from 'xlsx'

export interface CardRow {
  name: string
  card_code: string
  set_code: string
  wiki_url: string | null
  owned: boolean
  edition: number | null
  condition: number | null
  is_ultimate: boolean
  language: number | null
}

export function parseExcel(filePath: string): CardRow[] {
  const workbook = XLSX.readFile(filePath)
  const sheet = workbook.Sheets['Sheet1']
  const rows = XLSX.utils.sheet_to_json<Record<string, unknown>>(sheet, { defval: null })

  return rows
    .filter((row) => row['code'] && row['name'])
    .map((row) => {
      const code: string = String(row['code']).trim()
      const setCode = code.split('-')[0]

      return {
        name: String(row['name']).trim(),
        card_code: code,
        set_code: setCode,
        wiki_url: row['Wiki'] ? String(row['Wiki']).trim() : null,
        owned: row['own it'] === 1,
        edition: row['first'] === 1 ? 1 : row['first'] === 2 ? 2 : null,
        condition: row['status'] === 1 ? 1 : row['status'] === 2 ? 2 : null,
        is_ultimate: row['ulti'] === 1,
        language: typeof row['language'] === 'number' && row['language'] >= 1 && row['language'] <= 6 ? row['language'] : null,
      }
    })
}
