import { useState, useMemo } from 'react'
import { useParams, Link } from 'react-router-dom'
import { useSetCards, useUpdateCollection, useSets, useUploadPhoto, useDeletePhoto } from '../hooks/useCards'
import CardGrid from '../components/CardGrid'
import SearchBar from '../components/SearchBar'
import ProgressBar from '../components/ProgressBar'

type Filter = 'all' | 'owned' | 'missing'

export default function SetView() {
  const { setCode = '' } = useParams()
  const [search, setSearch] = useState('')
  const [filter, setFilter] = useState<Filter>('all')

  const { data: cards, isLoading } = useSetCards(setCode)
  const { data: sets } = useSets()
  const updateCollection = useUpdateCollection(setCode)
  const uploadPhoto = useUploadPhoto(setCode)
  const deletePhoto = useDeletePhoto(setCode)

  const currentSet = sets?.find(s => s.code === setCode.toUpperCase())

  const filtered = useMemo(() => {
    if (!cards) return []
    return cards.filter(c => {
      const matchesSearch = search === '' || c.name.toLowerCase().includes(search.toLowerCase()) || c.cardCode.toLowerCase().includes(search.toLowerCase())
      const matchesFilter = filter === 'all' || (filter === 'owned' && c.owned) || (filter === 'missing' && !c.owned)
      return matchesSearch && matchesFilter
    })
  }, [cards, search, filter])

  const ownedCount = cards?.filter(c => c.owned).length ?? 0
  const totalCount = cards?.length ?? 0
  const percentage = totalCount > 0 ? Math.round((ownedCount / totalCount) * 1000) / 10 : 0

  return (
    <div className="min-h-screen bg-dark-800">
      {/* Header */}
      <header className="bg-dark-900 border-b border-dark-600 sticky top-0 z-10">
        <div className="max-w-7xl mx-auto px-4 py-4">
          <div className="flex items-center gap-4 mb-3">
            <Link
              to="/"
              className="text-gold-500 hover:text-gold-400 transition-colors flex items-center gap-1"
            >
              <svg className="w-4 h-4" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M15 19l-7-7 7-7" />
              </svg>
              Inicio
            </Link>
            <div>
              <h1 className="text-xl font-bold text-gold-500">
                {setCode.toUpperCase()} — {currentSet?.name ?? '...'}
              </h1>
            </div>
          </div>
          <ProgressBar owned={ownedCount} total={totalCount} percentage={percentage} />
        </div>
      </header>

      {/* Controls */}
      <div className="max-w-7xl mx-auto px-4 py-4 flex flex-col sm:flex-row gap-3">
        <div className="flex-1">
          <SearchBar value={search} onChange={setSearch} />
        </div>
        <div className="flex gap-2">
          {(['all', 'owned', 'missing'] as Filter[]).map(f => (
            <button
              key={f}
              onClick={() => setFilter(f)}
              className={`
                px-3 py-2 rounded-lg text-sm font-medium transition-all
                ${filter === f
                  ? 'bg-gold-500 text-dark-900'
                  : 'bg-dark-700 text-gray-400 hover:text-gray-200'
                }
              `}
            >
              {f === 'all' ? 'Todas' : f === 'owned' ? 'Tengo' : 'Falta'}
            </button>
          ))}
        </div>
      </div>

      {/* Cards */}
      <main className="max-w-7xl mx-auto px-4 pb-8">
        {isLoading ? (
          <div className="text-center py-16 text-gold-500 animate-pulse">Cargando cartas...</div>
        ) : (
          <>
            <div className="text-sm text-gray-500 mb-4">{filtered.length} cartas</div>
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
