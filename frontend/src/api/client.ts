const BASE_URL = import.meta.env.VITE_API_URL || 'http://localhost:3000'

const TOKEN_KEY = 'yugioh_token'

export function getToken(): string | null {
  return localStorage.getItem(TOKEN_KEY)
}

export function setToken(token: string): void {
  localStorage.setItem(TOKEN_KEY, token)
}

export function removeToken(): void {
  localStorage.removeItem(TOKEN_KEY)
}

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
  language: number | null
  photos: CardPhoto[]
}

export interface CardDetail extends Card {
  setCode: string
  setName: string
  notes: string | null
}

export interface CollectionCard extends Card {
  setCode: string
}

export interface UserCollection {
  id: number
  name: string
  configured: boolean
  viewMode: string
  coverImageUrl: string | null
  createdAt: string
  totalCards: number
  ownedCards: number
  percentage: number
}

export interface Stats {
  total_cards: number
  owned_cards: number
  percentage: number
  sets: CardSet[]
}

export interface User {
  id: number
  email: string
  name: string
}

async function request<T>(path: string, options?: RequestInit): Promise<T> {
  const token = getToken()
  const headers: Record<string, string> = { 'Content-Type': 'application/json' }
  if (token) headers['Authorization'] = `Bearer ${token}`
  const res = await fetch(`${BASE_URL}${path}`, { headers, ...options })
  if (!res.ok) {
    const body = await res.json().catch(() => ({}))
    throw Object.assign(new Error(body.error || `HTTP ${res.status}`), { status: res.status })
  }
  return res.json()
}

export const api = {
  // Auth
  login: (email: string, password: string) =>
    request<{ user: User; token: string }>('/api/auth/login', {
      method: 'POST',
      body: JSON.stringify({ email, password }),
    }),
  register: (email: string, password: string, name: string) =>
    request<{ user: User; token: string }>('/api/auth/register', {
      method: 'POST',
      body: JSON.stringify({ email, password, name }),
    }),
  logout: () => request<{ ok: boolean }>('/api/auth/logout', { method: 'POST' }),
  me: () => request<{ user: User }>('/api/auth/me'),

  // Collections
  getCollections: () => request<UserCollection[]>('/api/collections'),
  getCollection: (id: number) => request<UserCollection>(`/api/collections/${id}`),
  getCollectionAllCards: (id: number) => request<CollectionCard[]>(`/api/collections/${id}/all-cards`),
  createCollection: (name: string) => request<UserCollection>('/api/collections', {
    method: 'POST',
    body: JSON.stringify({ name }),
  }),
  uploadCollectionCover: async (id: number, file: File): Promise<{ coverImageUrl: string }> => {
    const token = getToken()
    const formData = new FormData()
    formData.append('cover', file)
    const res = await fetch(`${BASE_URL}/api/collections/${id}/cover`, {
      method: 'POST',
      headers: token ? { Authorization: `Bearer ${token}` } : {},
      body: formData,
    })
    if (!res.ok) throw new Error(`HTTP ${res.status}`)
    return res.json()
  },
  deleteCollection: async (id: number, password: string): Promise<void> => {
    const token = getToken()
    const res = await fetch(`${BASE_URL}/api/collections/${id}`, {
      method: 'DELETE',
      headers: {
        'Content-Type': 'application/json',
        ...(token ? { Authorization: `Bearer ${token}` } : {}),
      },
      body: JSON.stringify({ password }),
    })
    if (!res.ok) {
      const body = await res.json().catch(() => ({}))
      throw Object.assign(new Error(body.error || `HTTP ${res.status}`), { status: res.status })
    }
  },

  // Collection
  getCard: (cardId: number) => request<CardDetail>(`/api/cards/${cardId}`),
  getSets: (collectionId?: number) => request<CardSet[]>(`/api/sets${collectionId ? `?collectionId=${collectionId}` : ''}`),
  getSetCards: (setCode: string) => request<Card[]>(`/api/sets/${setCode}/cards`),
  getStats: (collectionId?: number) => request<Stats>(`/api/stats${collectionId ? `?collectionId=${collectionId}` : ''}`),
  importExcel: async (collectionId: number, file: File): Promise<{ imported: number; notFound: string[] }> => {
    const token = getToken()
    const formData = new FormData()
    formData.append('file', file)
    const res = await fetch(`${BASE_URL}/api/collections/${collectionId}/import-excel`, {
      method: 'POST',
      headers: token ? { Authorization: `Bearer ${token}` } : {},
      body: formData,
    })
    if (!res.ok) {
      const body = await res.json().catch(() => ({}))
      throw new Error(body.error || `HTTP ${res.status}`)
    }
    return res.json()
  },
  addCard: (collectionId: number, data: { cardCode: string; name: string; passcode: number; setCode: string; setName: string }) =>
    request(`/api/collections/${collectionId}/cards`, { method: 'POST', body: JSON.stringify(data) }),
  downloadSampleExcel: () => {
    const token = getToken()
    const link = document.createElement('a')
    link.href = `${BASE_URL}/api/collections/sample-excel`
    // fetch with auth header, trigger download
    fetch(`${BASE_URL}/api/collections/sample-excel`, {
      headers: token ? { Authorization: `Bearer ${token}` } : {},
    }).then(res => res.blob()).then(blob => {
      link.href = URL.createObjectURL(blob)
      link.download = 'coleccion_ejemplo.xlsx'
      link.click()
      URL.revokeObjectURL(link.href)
    })
  },
  searchCards: (q: string) => request<Card[]>(`/api/cards/search?q=${encodeURIComponent(q)}`),
  updateCollection: (cardId: number, data: Partial<Pick<Card, 'owned' | 'edition' | 'condition' | 'isUltimate' | 'language'>> & { notes?: string | null }) =>
    request(`/api/cards/${cardId}/collection`, {
      method: 'PATCH',
      body: JSON.stringify({
        owned: data.owned,
        edition: data.edition,
        condition: data.condition,
        is_ultimate: data.isUltimate,
        language: data.language,
        notes: data.notes,
      }),
    }),
  uploadPhoto: async (cardId: number, file: File): Promise<CardPhoto> => {
    const token = getToken()
    const formData = new FormData()
    formData.append('photo', file)
    const res = await fetch(`${BASE_URL}/api/cards/${cardId}/photos`, {
      method: 'POST',
      headers: token ? { Authorization: `Bearer ${token}` } : {},
      body: formData,
    })
    if (!res.ok) throw new Error(`HTTP ${res.status}`)
    return res.json()
  },
  deletePhoto: async (cardId: number, photoId: number): Promise<void> => {
    const token = getToken()
    const res = await fetch(`${BASE_URL}/api/cards/${cardId}/photos/${photoId}`, {
      method: 'DELETE',
      headers: token ? { Authorization: `Bearer ${token}` } : {},
    })
    if (!res.ok) throw new Error(`HTTP ${res.status}`)
  },
}
