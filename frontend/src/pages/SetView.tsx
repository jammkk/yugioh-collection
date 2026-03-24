import { useState, useMemo } from 'react'
import { useParams, Link } from 'react-router-dom'
import { useSetCards, useUpdateCollection, useSets, useUploadPhoto, useDeletePhoto } from '../hooks/useCards'
import CardGrid from '../components/CardGrid'
import SearchBar from '../components/SearchBar'
import ProgressBar from '../components/ProgressBar'

type Filter = 'all' | 'owned' | 'missing'
type EditionFilter = 'all' | '1' | '2'
type ConditionFilter = 'all' | '1' | '2'

const FILTER_LABELS: Record<Filter, string> = { all: 'Todas', owned: 'Tengo', missing: 'Faltan' }

export default function SetView() {
  const { setCode = '' } = useParams()
  const [search, setSearch] = useState('')
  const [filter, setFilter] = useState<Filter>('all')
  const [editionFilter, setEditionFilter] = useState<EditionFilter>('all')
  const [conditionFilter, setConditionFilter] = useState<ConditionFilter>('all')

  const { data: cards, isLoading } = useSetCards(setCode)
  const { data: sets } = useSets()
  const updateCollection = useUpdateCollection(setCode)
  const uploadPhoto = useUploadPhoto(setCode)
  const deletePhoto = useDeletePhoto(setCode)

  const currentSet = sets?.find(s => s.code === setCode.toUpperCase())

  const filtered = useMemo(() => {
    if (!cards) return []
    return cards.filter(c => {
      const matchesSearch = search === '' ||
        c.name.toLowerCase().includes(search.toLowerCase()) ||
        c.cardCode.toLowerCase().includes(search.toLowerCase())
      const matchesFilter = filter === 'all' || (filter === 'owned' && c.owned) || (filter === 'missing' && !c.owned)
      const matchesEdition = editionFilter === 'all' || c.edition === parseInt(editionFilter)
      const matchesCondition = conditionFilter === 'all' || c.condition === parseInt(conditionFilter)
      return matchesSearch && matchesFilter && matchesEdition && matchesCondition
    })
  }, [cards, search, filter, editionFilter, conditionFilter])

  const ownedCount = cards?.filter(c => c.owned).length ?? 0
  const totalCount = cards?.length ?? 0
  const percentage = totalCount > 0 ? Math.round((ownedCount / totalCount) * 1000) / 10 : 0

  return (
    <div className="min-h-screen page-enter" style={{ background: '#080d1a' }}>
      {/* Header */}
      <header className="sticky top-0 z-20 glass-dark">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 py-3">
          <div className="flex items-center gap-3 mb-3">
            <Link
              to="/"
              className="flex items-center gap-1.5 text-sm font-medium transition-colors shrink-0"
              style={{ color: 'rgba(255,255,255,0.4)' }}
              onMouseEnter={e => (e.currentTarget as HTMLElement).style.color = '#e8a613'}
              onMouseLeave={e => (e.currentTarget as HTMLElement).style.color = 'rgba(255,255,255,0.4)'}
            >
              <svg className="w-4 h-4" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M15 19l-7-7 7-7" />
              </svg>
              Inicio
            </Link>
            <span style={{ color: 'rgba(255,255,255,0.15)' }}>/</span>
            <div className="flex items-center gap-2 min-w-0">
              <span className="text-xs font-bold font-mono text-gold-400 bg-gold-500/10 px-1.5 py-0.5 rounded-md shrink-0">
                {setCode.toUpperCase()}
              </span>
              <h1 className="text-sm font-semibold text-white/70 truncate">{currentSet?.name ?? '...'}</h1>
            </div>
          </div>
          <ProgressBar owned={ownedCount} total={totalCount} percentage={percentage} size="sm" />
        </div>
      </header>

      {/* Controls */}
      <div className="max-w-7xl mx-auto px-4 sm:px-6 pt-4 pb-3 flex flex-col gap-3">
        <div className="flex flex-col sm:flex-row gap-3">
          <div className="flex-1">
            <SearchBar value={search} onChange={setSearch} />
          </div>
          <div className="flex gap-1.5 p-1 rounded-xl" style={{ background: 'rgba(255,255,255,0.04)', border: '1px solid rgba(255,255,255,0.06)' }}>
            {(Object.keys(FILTER_LABELS) as Filter[]).map(f => (
              <button
                key={f}
                onClick={() => setFilter(f)}
                className="flex-1 sm:flex-none px-4 py-1.5 rounded-lg text-xs font-semibold transition-all"
                style={filter === f
                  ? { background: 'linear-gradient(135deg, #f5c842, #e8a613)', color: '#080d1a' }
                  : { color: 'rgba(255,255,255,0.45)' }
                }
              >
                {FILTER_LABELS[f]}
                {f !== 'all' && cards && (
                  <span className="ml-1 opacity-60">
                    {f === 'owned' ? ownedCount : totalCount - ownedCount}
                  </span>
                )}
              </button>
            ))}
          </div>
        </div>

        {/* Secondary filters */}
        <div className="flex flex-wrap gap-2 items-center">
          <span className="text-xs font-semibold uppercase tracking-widest" style={{ color: 'rgba(255,255,255,0.2)' }}>Edición</span>
          {([['all', 'Todas'], ['1', '1ra Ed.'], ['2', 'Ilimitada']] as [EditionFilter, string][]).map(([val, label]) => (
            <button
              key={val}
              onClick={() => setEditionFilter(val)}
              className="px-3 py-1 rounded-lg text-xs font-semibold transition-all"
              style={editionFilter === val
                ? { background: 'rgba(245,200,66,0.15)', color: '#f5c842', border: '1px solid rgba(245,200,66,0.3)' }
                : { background: 'rgba(255,255,255,0.03)', color: 'rgba(255,255,255,0.35)', border: '1px solid rgba(255,255,255,0.06)' }
              }
            >
              {label}
            </button>
          ))}
          <span className="text-xs font-semibold uppercase tracking-widest ml-2" style={{ color: 'rgba(255,255,255,0.2)' }}>Estado</span>
          {([['all', 'Todos'], ['1', 'Bien'], ['2', 'Usado']] as [ConditionFilter, string][]).map(([val, label]) => (
            <button
              key={val}
              onClick={() => setConditionFilter(val)}
              className="px-3 py-1 rounded-lg text-xs font-semibold transition-all"
              style={conditionFilter === val
                ? { background: 'rgba(245,200,66,0.15)', color: '#f5c842', border: '1px solid rgba(245,200,66,0.3)' }
                : { background: 'rgba(255,255,255,0.03)', color: 'rgba(255,255,255,0.35)', border: '1px solid rgba(255,255,255,0.06)' }
              }
            >
              {label}
            </button>
          ))}
        </div>
      </div>

      {/* Cards */}
      <main className="max-w-7xl mx-auto px-4 sm:px-6 pb-10">
        {isLoading ? (
          <div className="flex flex-col items-center gap-3 py-20">
            <div className="w-7 h-7 rounded-full border-2 border-gold-500 border-t-transparent animate-spin" />
            <span className="text-sm" style={{ color: 'rgba(255,255,255,0.3)' }}>Cargando cartas...</span>
          </div>
        ) : (
          <>
            <p className="text-xs mb-4" style={{ color: 'rgba(255,255,255,0.25)' }}>
              {filtered.length} {filtered.length === 1 ? 'carta' : 'cartas'}
            </p>
            <CardGrid
              cards={filtered}
              setCode={setCode}
              onUpdateCollection={(data) => updateCollection.mutate(data)}
              onUploadPhoto={(cardId, file) => uploadPhoto.mutate({ cardId, file })}
              onDeletePhoto={(cardId, photoId) => deletePhoto.mutate({ cardId, photoId })}
            />
          </>
        )}
      </main>
    </div>
  )
}
