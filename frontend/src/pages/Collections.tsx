import { useNavigate } from 'react-router-dom'
import { useCollections } from '../hooks/useCards'
import { useAuth } from '../context/AuthContext'
import ProgressBar from '../components/ProgressBar'

export default function Collections() {
  const { user, logout } = useAuth()
  const { data: collections, isLoading, error } = useCollections()
  const navigate = useNavigate()

  if (isLoading) {
    return (
      <div className="min-h-screen flex items-center justify-center" style={{ background: '#080d1a' }}>
        <div className="flex flex-col items-center gap-3">
          <div className="w-8 h-8 rounded-full border-2 border-gold-500 border-t-transparent animate-spin" />
          <span className="text-sm" style={{ color: 'rgba(255,255,255,0.4)' }}>Cargando colecciones...</span>
        </div>
      </div>
    )
  }

  if (error) {
    return (
      <div className="min-h-screen flex items-center justify-center" style={{ background: '#080d1a' }}>
        <div className="text-center px-4">
          <div className="text-5xl mb-4">&#9888;</div>
          <div className="text-white font-medium mb-1">Sin conexión al servidor</div>
          <div className="text-sm" style={{ color: 'rgba(255,255,255,0.35)' }}>Asegúrate de que el backend esté corriendo en puerto 3000</div>
        </div>
      </div>
    )
  }

  return (
    <div className="min-h-screen page-enter" style={{ background: '#080d1a' }}>
      {/* Header */}
      <header className="sticky top-0 z-20 glass-dark">
        <div className="max-w-7xl mx-auto px-4 sm:px-6">
          <div className="flex items-center justify-between py-4">
            <div>
              <h1 className="text-xl font-bold tracking-tight text-white">
                Collector <span className="text-gold-400">App</span>
              </h1>
              <p className="text-xs mt-0.5" style={{ color: 'rgba(255,255,255,0.35)' }}>
                {user?.name}
              </p>
            </div>
            <button
              onClick={logout}
              className="text-xs px-3 py-1.5 rounded-lg transition-all"
              style={{ color: 'rgba(255,255,255,0.3)', border: '1px solid rgba(255,255,255,0.06)' }}
              onMouseEnter={e => (e.currentTarget as HTMLElement).style.color = 'rgba(255,255,255,0.7)'}
              onMouseLeave={e => (e.currentTarget as HTMLElement).style.color = 'rgba(255,255,255,0.3)'}
            >
              Salir
            </button>
          </div>
        </div>
      </header>

      <main className="max-w-7xl mx-auto px-4 sm:px-6 py-8">
        <div className="flex items-center justify-between mb-6">
          <h2 className="text-sm font-semibold" style={{ color: 'rgba(255,255,255,0.5)' }}>
            MIS COLECCIONES · {collections?.length ?? 0}
          </h2>
        </div>

        <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-4">
          {collections?.map(col => (
            <button
              key={col.id}
              onClick={() => navigate(`/collections/${col.id}`)}
              className="glass rounded-2xl p-5 text-left transition-all hover:scale-[1.02] active:scale-[0.98]"
              style={{ border: '1px solid rgba(255,255,255,0.06)' }}
            >
              <div className="flex items-start justify-between mb-3">
                <h3 className="text-base font-bold text-white leading-tight">{col.name}</h3>
                <span className="text-lg font-bold text-gold-400 ml-2 shrink-0">
                  {Math.round(col.percentage)}%
                </span>
              </div>

              <div className="mb-3">
                <ProgressBar owned={col.ownedCards} total={col.totalCards} percentage={col.percentage} size="sm" />
              </div>

              <div className="flex items-center justify-between">
                <span className="text-xs" style={{ color: 'rgba(255,255,255,0.35)' }}>
                  {col.ownedCards} / {col.totalCards} cartas
                </span>
                <span className="text-xs text-gold-400/60">Ver colección →</span>
              </div>
            </button>
          ))}
        </div>
      </main>
    </div>
  )
}
