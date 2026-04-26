import { useState, useMemo } from 'react'
import { useParams, useNavigate } from 'react-router-dom'
import { useCollectionAllCards, useCollection } from '../hooks/useCards'
import CardCard from '../components/CardCard'

const OWNED_OPTS = [
  { value: null,  label: 'Todas' },
  { value: true,  label: 'Tengo' },
  { value: false, label: 'No tengo' },
]

const EDITION_OPTS = [
  { value: null, label: 'Todas' },
  { value: 1,    label: '1ra Ed.' },
  { value: 2,    label: 'Ilimitada' },
  { value: 3,    label: 'No sé' },
]

const CONDITION_OPTS = [
  { value: null, label: 'Todas' },
  { value: 1,    label: 'NM / LP' },
  { value: 2,    label: 'MP / HP' },
  { value: 3,    label: 'No sé' },
]

const LANGUAGE_OPTS = [
  { value: null, label: 'Todas' },
  { value: 1,    label: 'Español' },
  { value: 2,    label: 'English' },
  { value: 3,    label: 'Italiano' },
  { value: 4,    label: 'Français' },
  { value: 5,    label: 'Português' },
  { value: 6,    label: 'Deutsch' },
]

const RARITY_OPTS = [
  { value: null,  label: 'Todas' },
  { value: true,  label: 'Ultimate' },
  { value: false, label: 'Normal' },
]

function FilterRow<T>({
  label, opts, value, onChange,
}: {
  label: string
  opts: { value: T; label: string }[]
  value: T
  onChange: (v: T) => void
}) {
  return (
    <div>
      <div className="text-xs font-semibold uppercase tracking-widest mb-2" style={{ color: 'rgba(255,255,255,0.25)' }}>
        {label}
      </div>
      <div className="flex flex-wrap gap-1.5">
        {opts.map(opt => {
          const active = opt.value === value
          return (
            <button
              key={String(opt.value)}
              onClick={() => onChange(opt.value)}
              className="text-xs px-3 py-1.5 rounded-lg font-medium transition-all"
              style={active
                ? { background: 'rgba(232,166,19,0.15)', color: '#e8a613', border: '1px solid rgba(232,166,19,0.3)' }
                : { background: 'rgba(255,255,255,0.04)', color: 'rgba(255,255,255,0.4)', border: '1px solid rgba(255,255,255,0.07)' }
              }
            >
              {opt.label}
            </button>
          )
        })}
      </div>
    </div>
  )
}

export default function CollectionFilter() {
  const { collectionId } = useParams<{ collectionId: string }>()
  const navigate = useNavigate()
  const { data: collection } = useCollection(Number(collectionId))
  const { data: allCards, isLoading } = useCollectionAllCards(Number(collectionId))

  const [search, setSearch]       = useState('')
  const [owned, setOwned]         = useState<boolean | null>(null)
  const [edition, setEdition]     = useState<number | null>(null)
  const [condition, setCondition] = useState<number | null>(null)
  const [language, setLanguage]   = useState<number | null>(null)
  const [ultimate, setUltimate]   = useState<boolean | null>(null)

  const activeFilters = [owned, edition, condition, language, ultimate].filter(v => v !== null).length
    + (search.trim() ? 1 : 0)

  const filtered = useMemo(() => {
    if (!allCards) return []
    const q = search.trim().toLowerCase()
    return allCards.filter(card => {
      if (owned !== null && card.owned !== owned) return false
      if (edition !== null && card.edition !== edition) return false
      if (condition !== null && card.condition !== condition) return false
      if (language !== null && card.language !== language) return false
      if (ultimate !== null && Boolean(card.isUltimate) !== ultimate) return false
      if (q && !card.name.toLowerCase().includes(q) && !card.cardCode.toLowerCase().includes(q)) return false
      return true
    })
  }, [allCards, owned, edition, condition, language, ultimate, search])

  const notOwned = allCards?.filter(c => !c.owned).length ?? 0

  function resetFilters() {
    setSearch(''); setOwned(null); setEdition(null)
    setCondition(null); setLanguage(null); setUltimate(null)
  }

  return (
    <div className="min-h-screen page-enter" style={{ background: '#080d1a' }}>
      <header className="sticky top-0 z-20 glass-dark">
        <div className="max-w-7xl mx-auto px-4 sm:px-6">
          <div className="flex items-center gap-3 py-4">
            <button
              onClick={() => navigate(`/collections/${collectionId}`)}
              className="text-xs px-2 py-1.5 rounded-lg transition-all shrink-0"
              style={{ color: 'rgba(255,255,255,0.3)', border: '1px solid rgba(255,255,255,0.06)' }}
              onMouseEnter={e => (e.currentTarget as HTMLElement).style.color = 'rgba(255,255,255,0.7)'}
              onMouseLeave={e => (e.currentTarget as HTMLElement).style.color = 'rgba(255,255,255,0.3)'}
            >
              ← Volver
            </button>
            <div className="flex-1 min-w-0">
              <h1 className="text-base font-bold text-white truncate">Filtros · {collection?.name}</h1>
              <p className="text-xs mt-0.5" style={{ color: 'rgba(255,255,255,0.3)' }}>
                {isLoading ? 'Cargando...' : `${filtered.length} carta${filtered.length !== 1 ? 's' : ''} · ${notOwned} pendientes`}
              </p>
            </div>
            {activeFilters > 0 && (
              <button
                onClick={resetFilters}
                className="text-xs px-3 py-1.5 rounded-lg shrink-0 transition-all"
                style={{ color: 'rgba(255,100,100,0.7)', border: '1px solid rgba(255,60,60,0.15)' }}
              >
                Limpiar ({activeFilters})
              </button>
            )}
          </div>
        </div>
      </header>

      <main className="max-w-7xl mx-auto px-4 sm:px-6 py-5 space-y-5">

        {/* Quick shortcut */}
        {owned === null && notOwned > 0 && (
          <button
            onClick={() => setOwned(false)}
            className="w-full flex items-center justify-between rounded-2xl px-5 py-4 transition-all"
            style={{ background: 'rgba(220,38,38,0.08)', border: '1px solid rgba(220,38,38,0.15)' }}
            onMouseEnter={e => (e.currentTarget as HTMLElement).style.borderColor = 'rgba(220,38,38,0.3)'}
            onMouseLeave={e => (e.currentTarget as HTMLElement).style.borderColor = 'rgba(220,38,38,0.15)'}
          >
            <div>
              <div className="text-sm font-semibold" style={{ color: 'rgba(255,120,120,0.9)' }}>Cartas que me faltan</div>
              <div className="text-xs mt-0.5" style={{ color: 'rgba(255,255,255,0.3)' }}>Ver solo las que no tienes</div>
            </div>
            <span className="text-lg font-bold" style={{ color: 'rgba(255,100,100,0.8)' }}>{notOwned}</span>
          </button>
        )}

        {/* Filters */}
        <div className="rounded-2xl p-5 space-y-4" style={{ background: 'rgba(17,28,50,0.6)', border: '1px solid rgba(255,255,255,0.06)' }}>

          {/* Search */}
          <div>
            <input
              type="text"
              value={search}
              onChange={e => setSearch(e.target.value)}
              placeholder="Buscar por nombre o código..."
              className="w-full text-sm bg-transparent outline-none rounded-xl px-3.5 py-2.5"
              style={{ background: 'rgba(255,255,255,0.04)', border: '1px solid rgba(255,255,255,0.08)', color: 'rgba(255,255,255,0.85)' }}
              onFocus={e => (e.currentTarget.style.borderColor = 'rgba(232,166,19,0.3)')}
              onBlur={e => (e.currentTarget.style.borderColor = 'rgba(255,255,255,0.08)')}
            />
          </div>

          <FilterRow label="Tengo" opts={OWNED_OPTS} value={owned} onChange={setOwned} />
          <FilterRow label="Edición" opts={EDITION_OPTS} value={edition} onChange={setEdition} />
          <FilterRow label="Estado" opts={CONDITION_OPTS} value={condition} onChange={setCondition} />
          <FilterRow label="Idioma" opts={LANGUAGE_OPTS} value={language} onChange={setLanguage} />
          <FilterRow label="Rareza" opts={RARITY_OPTS} value={ultimate} onChange={setUltimate} />
        </div>

        {/* Results */}
        {isLoading ? (
          <div className="flex justify-center py-16">
            <div className="w-7 h-7 rounded-full border-2 border-gold-500 border-t-transparent animate-spin" />
          </div>
        ) : filtered.length === 0 ? (
          <div className="text-center py-16">
            <div className="text-4xl mb-3 opacity-20">&#128269;</div>
            <div className="text-sm font-medium text-white">Sin resultados</div>
            <div className="text-xs mt-1" style={{ color: 'rgba(255,255,255,0.3)' }}>
              Prueba cambiando los filtros
            </div>
          </div>
        ) : (
          <>
            <div className="text-xs font-semibold uppercase tracking-widest" style={{ color: 'rgba(255,255,255,0.25)' }}>
              Resultados · {filtered.length}
            </div>
            <div className="grid grid-cols-2 sm:grid-cols-3 md:grid-cols-4 lg:grid-cols-5 xl:grid-cols-6 gap-3">
              {filtered.map(card => (
                <CardCard
                  key={card.id}
                  card={card}
                  setCode={card.setCode}
                  collectionId={Number(collectionId)}
                  onUpdateCollection={() => {}}
                />
              ))}
            </div>
          </>
        )}
      </main>
    </div>
  )
}
