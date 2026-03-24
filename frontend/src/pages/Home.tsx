import { useNavigate, useParams } from 'react-router-dom'
import { useStats, useCollection } from '../hooks/useCards'
import { useAuth } from '../context/AuthContext'
import SetSelector from '../components/SetSelector'
import ProgressBar from '../components/ProgressBar'

export default function Home() {
  const { collectionId } = useParams<{ collectionId: string }>()
  const { user, logout } = useAuth()
  const { data: stats, isLoading, error } = useStats(Number(collectionId))
  const { data: collection } = useCollection(Number(collectionId))
  const navigate = useNavigate()

  if (isLoading) {
    return (
      <div className="min-h-screen flex items-center justify-center" style={{ background: '#080d1a' }}>
        <div className="flex flex-col items-center gap-3">
          <div className="w-8 h-8 rounded-full border-2 border-gold-500 border-t-transparent animate-spin" />
          <span className="text-sm" style={{ color: 'rgba(255,255,255,0.4)' }}>Cargando colección...</span>
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

  const complete = stats?.sets?.filter(s => s.percentage === 100).length ?? 0

  return (
    <div className="min-h-screen page-enter" style={{ background: '#080d1a' }}>
      {/* Header */}
      <header className="sticky top-0 z-20 glass-dark">
        <div className="max-w-7xl mx-auto px-4 sm:px-6">
          <div className="flex items-center justify-between py-4">
            <div className="flex items-center gap-3">
              <button
                onClick={() => navigate('/')}
                className="text-xs px-2 py-1.5 rounded-lg transition-all"
                style={{ color: 'rgba(255,255,255,0.3)', border: '1px solid rgba(255,255,255,0.06)' }}
                onMouseEnter={e => (e.currentTarget as HTMLElement).style.color = 'rgba(255,255,255,0.7)'}
                onMouseLeave={e => (e.currentTarget as HTMLElement).style.color = 'rgba(255,255,255,0.3)'}
              >
                ← Volver
              </button>
              <div>
                <h1 className="text-xl font-bold tracking-tight text-white">
                  {collection?.name ?? <span className="text-gold-400">Tracker</span>}
                </h1>
                <p className="text-xs mt-0.5" style={{ color: 'rgba(255,255,255,0.35)' }}>{user?.name}</p>
              </div>
            </div>

            {stats && (
              <div className="flex items-center gap-3">
                <div className="hidden sm:block text-right">
                  <div className="text-xs font-medium text-gold-400">{stats.owned_cards} cartas</div>
                  <div className="text-xs" style={{ color: 'rgba(255,255,255,0.3)' }}>de {stats.total_cards}</div>
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
                <div className="relative w-11 h-11">
                  <svg className="w-full h-full -rotate-90" viewBox="0 0 36 36">
                    <circle cx="18" cy="18" r="15" fill="none" stroke="rgba(255,255,255,0.06)" strokeWidth="3" />
                    <circle
                      cx="18" cy="18" r="15" fill="none"
                      stroke="#e8a613" strokeWidth="3"
                      strokeLinecap="round"
                      strokeDasharray={`${2 * Math.PI * 15}`}
                      strokeDashoffset={`${2 * Math.PI * 15 * (1 - (stats.percentage || 0) / 100)}`}
                      style={{ transition: 'stroke-dashoffset 1s ease' }}
                    />
                  </svg>
                  <span className="absolute inset-0 flex items-center justify-center text-xs font-bold text-gold-400">
                    {Math.round(stats.percentage)}%
                  </span>
                </div>
              </div>
            )}
          </div>
        </div>
      </header>

      <main className="max-w-7xl mx-auto px-4 sm:px-6 py-8">
        {collection && !collection.configured ? (
          <div className="flex flex-col items-center justify-center py-24 text-center">
            <div className="text-5xl mb-4 opacity-20">&#128218;</div>
            <div className="text-white font-semibold mb-1">Colección vacía</div>
            <div className="text-sm mb-6" style={{ color: 'rgba(255,255,255,0.35)' }}>
              Esta colección aún no tiene sets configurados
            </div>
            <button
              onClick={() => navigate(`/collections/${collectionId}/configure`)}
              className="text-sm px-5 py-2.5 rounded-xl font-semibold transition-all"
              style={{ background: 'linear-gradient(135deg,#f5c842,#e8a613)', color: '#080d1a' }}
            >
              Configurar colección
            </button>
          </div>
        ) : (
          <>
            {stats && (
              <div className="grid grid-cols-3 gap-3 mb-8">
                {[
                  { label: 'Cartas', value: stats.owned_cards, total: stats.total_cards },
                  { label: 'Sets', value: complete, total: stats.sets?.length ?? 0 },
                  { label: 'Progreso', value: `${stats.percentage}%`, total: null },
                ].map(s => (
                  <div key={s.label} className="glass rounded-2xl p-4 text-center">
                    <div className="text-lg font-bold text-gold-400">{s.value}</div>
                    {s.total ? <div className="text-xs" style={{ color: 'rgba(255,255,255,0.3)' }}>de {s.total}</div> : null}
                    <div className="text-xs font-medium mt-0.5" style={{ color: 'rgba(255,255,255,0.5)' }}>{s.label}</div>
                  </div>
                ))}
              </div>
            )}

            {stats && (
              <div className="mb-8">
                <ProgressBar owned={stats.owned_cards} total={stats.total_cards} percentage={stats.percentage} />
              </div>
            )}

            <div className="flex items-center justify-between mb-4">
              <h2 className="text-sm font-semibold" style={{ color: 'rgba(255,255,255,0.5)' }}>
                SETS · {stats?.sets?.length ?? 0}
              </h2>
              {complete > 0 && (
                <span className="text-xs text-gold-400 font-medium">{complete} completo{complete !== 1 ? 's' : ''} ✦</span>
              )}
            </div>

            {stats?.sets && <SetSelector sets={stats.sets} collectionId={Number(collectionId)} />}

            <div className="mt-10 flex justify-center">
              <button
                onClick={() => navigate(`/collections/${collectionId}/configure`)}
                className="text-xs px-4 py-2 rounded-xl transition-all"
                style={{ color: 'rgba(255,255,255,0.25)', border: '1px solid rgba(255,255,255,0.06)' }}
                onMouseEnter={e => (e.currentTarget as HTMLElement).style.color = 'rgba(255,255,255,0.6)'}
                onMouseLeave={e => (e.currentTarget as HTMLElement).style.color = 'rgba(255,255,255,0.25)'}
              >
                &#9881; Configurar colección
              </button>
            </div>
          </>
        )}
      </main>
    </div>
  )
}
