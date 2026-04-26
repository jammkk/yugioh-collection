import { useState } from 'react'
import { useNavigate } from 'react-router-dom'
import { useCollections, useCreateCollection } from '../hooks/useCards'
import { useAuth } from '../context/AuthContext'
import ProgressBar from '../components/ProgressBar'

export default function Collections() {
  const { user, logout } = useAuth()
  const { data: collections, isLoading, error } = useCollections()
  const createCollection = useCreateCollection()
  const navigate = useNavigate()
  const [showForm, setShowForm] = useState(false)
  const [newName, setNewName] = useState('')

  const handleCreate = () => {
    if (!newName.trim()) return
    createCollection.mutate(newName.trim(), {
      onSuccess: (col) => {
        setNewName('')
        setShowForm(false)
        navigate(`/collections/${col.id}`)
      },
    })
  }

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
            <div className="flex items-center gap-2">
              <button
                onClick={() => navigate('/profile')}
                className="text-xs px-3 py-1.5 rounded-lg transition-all"
                style={{ color: 'rgba(255,255,255,0.3)', border: '1px solid rgba(255,255,255,0.06)' }}
                onMouseEnter={e => (e.currentTarget as HTMLElement).style.color = 'rgba(255,255,255,0.7)'}
                onMouseLeave={e => (e.currentTarget as HTMLElement).style.color = 'rgba(255,255,255,0.3)'}
              >
                Perfil
              </button>
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
        </div>
      </header>

      <main className="max-w-7xl mx-auto px-4 sm:px-6 py-8">
        <div className="flex items-center justify-between mb-6">
          <h2 className="text-sm font-semibold" style={{ color: 'rgba(255,255,255,0.5)' }}>
            MIS COLECCIONES · {collections?.length ?? 0}
          </h2>
          <button
            onClick={() => setShowForm(v => !v)}
            className="text-xs px-3 py-1.5 rounded-lg font-semibold transition-all"
            style={{ background: 'linear-gradient(135deg,#f5c842,#e8a613)', color: '#080d1a' }}
          >
            + Nueva
          </button>
        </div>

        {showForm && (
          <div className="glass rounded-2xl p-4 mb-4 flex gap-2" style={{ border: '1px solid rgba(232,166,19,0.2)' }}>
            <input
              autoFocus
              type="text"
              value={newName}
              onChange={e => setNewName(e.target.value)}
              onKeyDown={e => { if (e.key === 'Enter') handleCreate(); if (e.key === 'Escape') setShowForm(false) }}
              placeholder="Nombre de la colección"
              className="flex-1 text-sm bg-transparent outline-none text-white placeholder-white/25"
            />
            <button
              onClick={handleCreate}
              disabled={!newName.trim() || createCollection.isPending}
              className="text-xs px-4 py-1.5 rounded-lg font-semibold transition-all disabled:opacity-40"
              style={{ background: 'linear-gradient(135deg,#f5c842,#e8a613)', color: '#080d1a' }}
            >
              {createCollection.isPending ? '...' : 'Crear'}
            </button>
            <button
              onClick={() => { setShowForm(false); setNewName('') }}
              className="text-xs px-3 py-1.5 rounded-lg transition-all"
              style={{ color: 'rgba(255,255,255,0.3)', border: '1px solid rgba(255,255,255,0.06)' }}
            >
              Cancelar
            </button>
          </div>
        )}

        <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-4">
          {collections?.map(col => (
            <button
              key={col.id}
              onClick={() => navigate(`/collections/${col.id}`)}
              className="group relative overflow-hidden rounded-2xl text-left transition-all hover:scale-[1.02] active:scale-[0.98]"
              style={{ border: '1px solid rgba(255,255,255,0.06)', background: '#0d1425', minHeight: '325px' }}
            >
              {/* Cover image */}
              {col.coverImageUrl && (
                <>
                  <img
                    src={`http://localhost:3000${col.coverImageUrl}`}
                    alt=""
                    className="absolute inset-0 w-full h-full object-cover transition-transform duration-300 group-hover:scale-105"
                    style={{ opacity: 0.25 }}
                  />
                  <div className="absolute inset-0" style={{ background: 'linear-gradient(to top, #0d1425 30%, transparent)' }} />
                </>
              )}

              {/* Content */}
              <div className="relative z-10 p-5 flex flex-col justify-end h-full" style={{ minHeight: '325px' }}>
                <div className="flex items-start justify-between mb-3">
                  <h3 className="text-base font-bold text-white leading-tight">{col.name}</h3>
                  <span className="text-lg font-bold text-gold-400 ml-2 shrink-0">
                    {col.configured ? `${Math.round(col.percentage)}%` : '—'}
                  </span>
                </div>

                {col.configured ? (
                  <>
                    <div className="mb-3">
                      <ProgressBar owned={col.ownedCards} total={col.totalCards} percentage={col.percentage} size="sm" />
                    </div>
                    <div className="flex items-center justify-between">
                      <span className="text-xs" style={{ color: 'rgba(255,255,255,0.35)' }}>
                        {col.ownedCards} / {col.totalCards} cartas
                      </span>
                      <span className="text-xs text-gold-400/60">Ver colección →</span>
                    </div>
                  </>
                ) : (
                  <div className="text-xs" style={{ color: 'rgba(255,255,255,0.3)' }}>Sin configurar</div>
                )}
              </div>
            </button>
          ))}
        </div>
      </main>
    </div>
  )
}
