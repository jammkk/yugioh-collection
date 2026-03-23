const BASE_URL = 'http://localhost:3000'

export interface CardSet {
  id: number
  code: string
  name: string
  orderIndex: number
  totalCards: number
  ownedCards: number
  percentage: number
}

export interface CardPhoto {
  id: number
  url: string
}

export interface Card {
  id: number
  name: string
  cardCode: string
  wikiUrl: string | null
  passcode?: number | null
  owned: boolean
  edition: number | null
  condition: number | null
  isUltimate: boolean
  photos: CardPhoto[]
}

export interface CardDetail extends Card {
  setCode: string
  setName: string
  notes: string | null
}

export interface Stats {
  total_cards: number
  owned_cards: number
  percentage: number
  sets: CardSet[]
}

async function request<T>(path: string, options?: RequestInit): Promise<T> {
  const res = await fetch(`${BASE_URL}${path}`, {
    headers: { 'Content-Type': 'application/json' },
    ...options,
  })
  if (!res.ok) throw new Error(`HTTP ${res.status}`)
  return res.json()
}

export const api = {
  getCard: (cardId: number) => request<CardDetail>(`/api/cards/${cardId}`),
  getSets: () => request<CardSet[]>('/api/sets'),
  getSetCards: (setCode: string) => request<Card[]>(`/api/sets/${setCode}/cards`),
  getStats: () => request<Stats>('/api/stats'),
  searchCards: (q: string) => request<Card[]>(`/api/cards/search?q=${encodeURIComponent(q)}`),
  updateCollection: (cardId: number, data: Partial<Pick<Card, 'owned' | 'edition' | 'condition' | 'isUltimate'>> & { notes?: string | null }) =>
    request(`/api/cards/${cardId}/collection`, {
      method: 'PATCH',
      body: JSON.stringify({
        owned: data.owned,
        edition: data.edition,
        condition: data.condition,
        is_ultimate: data.isUltimate,
        notes: data.notes,
      }),
    }),
  uploadPhoto: async (cardId: number, file: File): Promise<CardPhoto> => {
    const formData = new FormData()
    formData.append('photo', file)
    const res = await fetch(`${BASE_URL}/api/cards/${cardId}/photos`, {
      method: 'POST',
      body: formData,
    })
    if (!res.ok) throw new Error(`HTTP ${res.status}`)
    return res.json()
  },
  deletePhoto: async (cardId: number, photoId: number): Promise<void> => {
    const res = await fetch(`${BASE_URL}/api/cards/${cardId}/photos/${photoId}`, {
      method: 'DELETE',
    })
    if (!res.ok) throw new Error(`HTTP ${res.status}`)
  },
}
