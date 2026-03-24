import { useState, useRef } from 'react'
import { useNavigate, useParams } from 'react-router-dom'
import { useCollection, useDeleteCollection, useUploadCollectionCover } from '../hooks/useCards'
import { useMutation, useQueryClient } from '@tanstack/react-query'
import { api } from '../api/client'

const BASE_URL = import.meta.env.VITE_API_URL || 'http://localhost:3000'

type Tab = 'general' | 'import' | 'danger'

interface YGOCard {
  id: number
  name: string
  card_sets?: Array<{ set_code: string; set_name: string; set_rarity: string }>
}

function normalizeCode(code: string): string {
  const m = code.match(/^([A-Z0-9]+)-(?:[A-Z]{0,2})?(\d+[A-Z]?)$/)
  return m ? `${m[1]}-${m[2]}` : code
}

export default function ConfigureCollection() {
  const { collectionId = '' } = useParams()
  const navigate = useNavigate()
  const queryClient = useQueryClient()
  const { data: collection } = useCollection(Number(collectionId))
  const deleteCollection = useDeleteCollection()
  const uploadCover = useUploadCollectionCover(Number(collectionId))
  const coverInputRef = useRef<HTMLInputElement>(null)
  const excelInputRef = useRef<HTMLInputElement>(null)

  const [tab, setTab] = useState<Tab>('general')

  // Delete
  const [password, setPassword] = useState('')
  const [deleteError, setDeleteError] = useState('')

  // Excel import
  const [importResult, setImportResult] = useState<{ imported: number; notFound: string[] } | null>(null)
  const [importError, setImportError] = useState('')
  const importMutation = useMutation({
    mutationFn: (file: File) => api.importExcel(Number(collectionId), file),
    onSuccess: (result) => {
      setImportResult(result)
      queryClient.invalidateQueries({ queryKey: ['collections'] })
      queryClient.invalidateQueries({ queryKey: ['collections', Number(collectionId)] })
      queryClient.invalidateQueries({ queryKey: ['sets', Number(collectionId)] })
      queryClient.invalidateQueries({ queryKey: ['stats', Number(collectionId)] })
    },
    onError: (e: unknown) => setImportError((e as Error).message),
  })

  // Single card search
  const [searchQuery, setSearchQuery] = useState('')
  const [searchResults, setSearchResults] = useState<YGOCard[]>([])
  const [searching, setSearching] = useState(false)
  const [expandedCard, setExpandedCard] = useState<number | null>(null)
  const [addedCards, setAddedCards] = useState<Set<string>>(new Set())
  const addCardMutation = useMutation({
    mutationFn: (data: { cardCode: string; name: string; passcode: number; setCode: string; setName: string }) =>
      api.addCard(Number(collectionId), data),
    onSuccess: (_data, vars) => {
      setAddedCards(prev => new Set([...prev, vars.cardCode]))
      queryClient.invalidateQueries({ queryKey: ['sets', Number(collectionId)] })
      queryClient.invalidateQueries({ queryKey: ['stats', Number(collectionId)] })
    },
  })

  const handleSearch = async () => {
    if (!searchQuery.trim()) return
    setSearching(true)
    setSearchResults([])
    setExpandedCard(null)
    try {
      const res = await fetch(`https://db.ygoprodeck.com/api/v7/cardinfo.php?fname=${encodeURIComponent(searchQuery)}&num=20&offset=0`)
      const data = await res.json()
      setSearchResults(data.data || [])
    } catch {
      setSearchResults([])
    }
    setSearching(false)
  }

  const TABS: { id: Tab; label: string }[] = [
    { id: 'general', label: 'General' },
    { id: 'import', label: 'Importar' },
    { id: 'danger', label: 'Peligroso' },
  ]

  return (
    <div className="min-h-screen page-enter" style={{ background: '#080d1a' }}>
      {/* Header */}
      <header className="sticky top-0 z-20 glass-dark">
        <div className="max-w-2xl mx-auto px-4 sm:px-6">
          <div className="flex items-center gap-3 py-4">
            <button
              onClick={() => navigate(`/collections/${collectionId}`)}
              className="text-xs px-2 py-1.5 rounded-lg transition-all"
              style={{ color: 'rgba(255,255,255,0.3)', border: '1px solid rgba(255,255,255,0.06)' }}
              onMouseEnter={e => (e.currentTarget as HTMLElement).style.color = 'rgba(255,255,255,0.7)'}
              onMouseLeave={e => (e.currentTarget as HTMLElement).style.color = 'rgba(255,255,255,0.3)'}
            >
              ← Volver
            </button>
            <div>
              <h1 className="text-base font-bold text-white">Configurar colección</h1>
              <p className="text-xs mt-0.5" style={{ color: 'rgba(255,255,255,0.35)' }}>{collection?.name}</p>
            </div>
          </div>
          {/* Tabs */}
          <div className="flex gap-1 pb-3">
            {TABS.map(t => (
              <button
                key={t.id}
                onClick={() => setTab(t.id)}
                className="px-4 py-1.5 rounded-lg text-xs font-semibold transition-all"
                style={tab === t.id
                  ? { background: 'linear-gradient(135deg,#f5c842,#e8a613)', color: '#080d1a' }
                  : { color: 'rgba(255,255,255,0.4)' }}
              >
                {t.label}
              </button>
            ))}
          </div>
        </div>
      </header>

      <main className="max-w-2xl mx-auto px-4 sm:px-6 py-6 space-y-4">

        {/* ── GENERAL ── */}
        {tab === 'general' && (
          <>
            {/* Imagen de portada */}
            <section className="rounded-2xl p-5 space-y-4" style={{ background: 'rgba(17,28,50,0.6)', border: '1px solid rgba(255,255,255,0.06)' }}>
              <h2 className="text-xs font-semibold uppercase tracking-widest" style={{ color: 'rgba(255,255,255,0.3)' }}>Imagen de portada</h2>
              <div className="flex items-center gap-4">
                {collection?.coverImageUrl ? (
                  <div className="w-20 h-20 rounded-xl overflow-hidden shrink-0" style={{ border: '1px solid rgba(255,255,255,0.1)' }}>
                    <img src={`${BASE_URL}${collection.coverImageUrl}`} alt="" className="w-full h-full object-cover" />
                  </div>
                ) : (
                  <div className="w-20 h-20 rounded-xl flex items-center justify-center shrink-0 text-3xl"
                    style={{ background: 'rgba(255,255,255,0.04)', border: '1px solid rgba(255,255,255,0.06)' }}>
                    &#128247;
                  </div>
                )}
                <button
                  onClick={() => coverInputRef.current?.click()}
                  disabled={uploadCover.isPending}
                  className="flex-1 py-3 rounded-xl text-sm font-medium transition-all disabled:opacity-50"
                  style={{ background: 'rgba(255,255,255,0.06)', border: '1px solid rgba(255,255,255,0.08)', color: 'rgba(255,255,255,0.7)' }}
                >
                  {uploadCover.isPending ? 'Subiendo...' : collection?.coverImageUrl ? 'Cambiar imagen' : 'Subir imagen'}
                </button>
                <input ref={coverInputRef} type="file" accept="image/*" className="hidden"
                  onChange={e => { const f = e.target.files?.[0]; if (f) uploadCover.mutate(f); e.target.value = '' }} />
              </div>
            </section>

            {/* Descargar Excel de ejemplo */}
            <section className="rounded-2xl p-5" style={{ background: 'rgba(17,28,50,0.6)', border: '1px solid rgba(255,255,255,0.06)' }}>
              <h2 className="text-xs font-semibold uppercase tracking-widest mb-3" style={{ color: 'rgba(255,255,255,0.3)' }}>Archivo de ejemplo</h2>
              <p className="text-xs mb-3" style={{ color: 'rgba(255,255,255,0.4)' }}>
                Descarga un Excel de ejemplo con la estructura correcta para importar cartas.
              </p>
              <button
                onClick={() => api.downloadSampleExcel()}
                className="w-full py-2.5 rounded-xl text-sm font-medium transition-all"
                style={{ background: 'rgba(255,255,255,0.04)', border: '1px solid rgba(255,255,255,0.08)', color: 'rgba(255,255,255,0.6)' }}
              >
                &#8615; Descargar Excel de ejemplo
              </button>
            </section>
          </>
        )}

        {/* ── IMPORTAR ── */}
        {tab === 'import' && (
          <>
            {/* Excel */}
            <section className="rounded-2xl p-5 space-y-4" style={{ background: 'rgba(17,28,50,0.6)', border: '1px solid rgba(255,255,255,0.06)' }}>
              <h2 className="text-xs font-semibold uppercase tracking-widest" style={{ color: 'rgba(255,255,255,0.3)' }}>Importar desde Excel</h2>
              <p className="text-xs" style={{ color: 'rgba(255,255,255,0.4)' }}>
                Sube un archivo Excel con los códigos de las cartas. Los nombres e imágenes se obtienen automáticamente de YGOPRODeck.
              </p>

              {importMutation.isPending && (
                <div className="flex items-center gap-3 py-2">
                  <div className="w-5 h-5 rounded-full border-2 border-gold-500 border-t-transparent animate-spin shrink-0" />
                  <span className="text-sm" style={{ color: 'rgba(255,255,255,0.5)' }}>Importando cartas desde YGOPRODeck...</span>
                </div>
              )}

              {importResult && (
                <div className="rounded-xl p-3 space-y-1" style={{ background: 'rgba(34,197,94,0.08)', border: '1px solid rgba(34,197,94,0.15)' }}>
                  <p className="text-sm font-semibold" style={{ color: '#4ade80' }}>&#10003; {importResult.imported} cartas importadas</p>
                  {importResult.notFound.length > 0 && (
                    <p className="text-xs" style={{ color: 'rgba(255,255,255,0.4)' }}>
                      No encontradas en YGOPRODeck: {importResult.notFound.slice(0, 5).join(', ')}{importResult.notFound.length > 5 ? ` y ${importResult.notFound.length - 5} más` : ''}
                    </p>
                  )}
                </div>
              )}

              {importError && (
                <p className="text-xs" style={{ color: 'rgba(255,100,100,0.8)' }}>{importError}</p>
              )}

              <button
                onClick={() => { setImportResult(null); setImportError(''); excelInputRef.current?.click() }}
                disabled={importMutation.isPending}
                className="w-full py-3 rounded-xl text-sm font-semibold transition-all disabled:opacity-50"
                style={{ background: 'linear-gradient(135deg,#f5c842,#e8a613)', color: '#080d1a' }}
              >
                {importMutation.isPending ? 'Importando...' : '&#8679; Subir Excel'}
              </button>
              <input ref={excelInputRef} type="file" accept=".xlsx,.xls" className="hidden"
                onChange={e => { const f = e.target.files?.[0]; if (f) importMutation.mutate(f); e.target.value = '' }} />
            </section>

            {/* Agregar carta individual */}
            <section className="rounded-2xl p-5 space-y-4" style={{ background: 'rgba(17,28,50,0.6)', border: '1px solid rgba(255,255,255,0.06)' }}>
              <h2 className="text-xs font-semibold uppercase tracking-widest" style={{ color: 'rgba(255,255,255,0.3)' }}>Agregar carta individual</h2>

              <div className="flex gap-2">
                <input
                  type="text"
                  value={searchQuery}
                  onChange={e => setSearchQuery(e.target.value)}
                  onKeyDown={e => e.key === 'Enter' && handleSearch()}
                  placeholder="Buscar por nombre..."
                  className="flex-1 text-sm bg-transparent outline-none rounded-xl px-3.5 py-2.5"
                  style={{ background: 'rgba(255,255,255,0.04)', border: '1px solid rgba(255,255,255,0.08)', color: 'rgba(255,255,255,0.8)' }}
                />
                <button
                  onClick={handleSearch}
                  disabled={searching || !searchQuery.trim()}
                  className="px-4 py-2.5 rounded-xl text-sm font-semibold transition-all disabled:opacity-40"
                  style={{ background: 'linear-gradient(135deg,#f5c842,#e8a613)', color: '#080d1a' }}
                >
                  {searching ? '...' : 'Buscar'}
                </button>
              </div>

              {searching && (
                <div className="flex items-center gap-2 py-2">
                  <div className="w-4 h-4 rounded-full border-2 border-gold-500 border-t-transparent animate-spin" />
                  <span className="text-xs" style={{ color: 'rgba(255,255,255,0.4)' }}>Buscando en YGOPRODeck...</span>
                </div>
              )}

              {searchResults.length > 0 && (
                <div className="space-y-2 max-h-96 overflow-y-auto pr-1">
                  {searchResults.map(card => (
                    <div key={card.id} className="rounded-xl overflow-hidden" style={{ border: '1px solid rgba(255,255,255,0.06)' }}>
                      {/* Card header */}
                      <button
                        className="w-full flex items-center gap-3 p-3 text-left transition-all"
                        style={{ background: 'rgba(255,255,255,0.03)' }}
                        onClick={() => setExpandedCard(expandedCard === card.id ? null : card.id)}
                      >
                        <img
                          src={`https://images.ygoprodeck.com/images/cards_small/${card.id}.jpg`}
                          alt={card.name}
                          className="w-8 h-11 object-cover rounded-md shrink-0"
                        />
                        <div className="flex-1 min-w-0">
                          <div className="text-sm font-medium text-white truncate">{card.name}</div>
                          <div className="text-xs mt-0.5" style={{ color: 'rgba(255,255,255,0.3)' }}>
                            {card.card_sets?.length ?? 0} ediciones disponibles
                          </div>
                        </div>
                        <span className="text-xs shrink-0" style={{ color: 'rgba(255,255,255,0.3)' }}>
                          {expandedCard === card.id ? '▲' : '▼'}
                        </span>
                      </button>

                      {/* Printings */}
                      {expandedCard === card.id && card.card_sets && (
                        <div className="divide-y" style={{ borderTop: '1px solid rgba(255,255,255,0.04)' }}>
                          {card.card_sets.map(cs => {
                            const normalized = normalizeCode(cs.set_code)
                            const setCode = normalized.split('-')[0]
                            const isAdded = addedCards.has(normalized)
                            return (
                              <div key={cs.set_code} className="flex items-center justify-between px-3 py-2.5">
                                <div>
                                  <span className="text-xs font-mono font-bold text-gold-400">{normalized}</span>
                                  <span className="text-xs ml-2" style={{ color: 'rgba(255,255,255,0.4)' }}>{cs.set_rarity}</span>
                                </div>
                                <button
                                  onClick={() => addCardMutation.mutate({
                                    cardCode: normalized,
                                    name: card.name,
                                    passcode: card.id,
                                    setCode,
                                    setName: cs.set_name,
                                  })}
                                  disabled={isAdded || addCardMutation.isPending}
                                  className="text-xs px-3 py-1 rounded-lg font-semibold transition-all disabled:opacity-40"
                                  style={isAdded
                                    ? { background: 'rgba(34,197,94,0.12)', color: '#4ade80', border: '1px solid rgba(34,197,94,0.2)' }
                                    : { background: 'rgba(232,166,19,0.12)', color: '#e8a613', border: '1px solid rgba(232,166,19,0.2)' }
                                  }
                                >
                                  {isAdded ? '✓ Agregada' : '+ Agregar'}
                                </button>
                              </div>
                            )
                          })}
                        </div>
                      )}
                    </div>
                  ))}
                </div>
              )}

              {!searching && searchQuery && searchResults.length === 0 && (
                <p className="text-xs text-center py-4" style={{ color: 'rgba(255,255,255,0.3)' }}>Sin resultados para "{searchQuery}"</p>
              )}
            </section>
          </>
        )}

        {/* ── PELIGROSO ── */}
        {tab === 'danger' && (
          <section className="rounded-2xl p-5 space-y-4" style={{ background: 'rgba(255,60,60,0.05)', border: '1px solid rgba(255,60,60,0.12)' }}>
            <h2 className="text-xs font-semibold uppercase tracking-widest" style={{ color: 'rgba(255,100,100,0.7)' }}>Zona de peligro</h2>

            <div>
              <div className="text-sm font-semibold mb-0.5" style={{ color: 'rgba(255,100,100,0.85)' }}>Eliminar colección</div>
              <div className="text-xs" style={{ color: 'rgba(255,255,255,0.3)' }}>Esta acción no se puede deshacer</div>
            </div>

            <input
              type="password"
              value={password}
              onChange={e => { setPassword(e.target.value); setDeleteError('') }}
              onKeyDown={e => e.key === 'Enter' && password && deleteCollection.mutate(
                { id: Number(collectionId), password },
                { onSuccess: () => navigate('/'), onError: (err: unknown) => setDeleteError((err as Error).message) }
              )}
              placeholder="Confirma tu contraseña"
              className="w-full text-sm bg-transparent outline-none rounded-xl px-3.5 py-2.5"
              style={{
                background: 'rgba(255,255,255,0.04)',
                border: `1px solid ${deleteError ? 'rgba(255,80,80,0.5)' : 'rgba(255,255,255,0.08)'}`,
                color: 'rgba(255,255,255,0.8)',
              }}
            />
            {deleteError && <p className="text-xs" style={{ color: 'rgba(255,100,100,0.8)' }}>{deleteError}</p>}

            <button
              onClick={() => deleteCollection.mutate(
                { id: Number(collectionId), password },
                { onSuccess: () => navigate('/'), onError: (err: unknown) => setDeleteError((err as Error).message) }
              )}
              disabled={!password || deleteCollection.isPending}
              className="w-full py-2.5 rounded-xl text-sm font-semibold transition-all disabled:opacity-40"
              style={{ background: 'rgba(220,38,38,0.15)', color: 'rgba(255,100,100,0.9)', border: '1px solid rgba(220,38,38,0.2)' }}
            >
              {deleteCollection.isPending ? 'Eliminando...' : 'Eliminar colección'}
            </button>
          </section>
        )}
      </main>
    </div>
  )
}
