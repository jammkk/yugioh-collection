import { useState, useEffect } from 'react'
import { useNavigate } from 'react-router-dom'
import { useAuth } from '../context/AuthContext'
import { api } from '../api/client'

export default function Profile() {
  const { user, setUser } = useAuth()
  const navigate = useNavigate()

  const [name, setName] = useState('')
  const [konamiId, setKonamiId] = useState('')
  const [duelingbookUsername, setDuelingbookUsername] = useState('')
  const [saving, setSaving] = useState(false)
  const [saved, setSaved] = useState(false)
  const [error, setError] = useState('')

  useEffect(() => {
    if (user) {
      setName(user.name)
      setKonamiId(user.konamiId ?? '')
      setDuelingbookUsername(user.duelingbookUsername ?? '')
    }
  }, [user])

  const handleSave = async () => {
    setError('')
    setSaving(true)
    try {
      const { user: updated } = await api.updateProfile({
        name: name || undefined,
        konamiId: konamiId || null,
        duelingbookUsername: duelingbookUsername || null,
      })
      setUser(updated)
      setSaved(true)
      setTimeout(() => setSaved(false), 2500)
    } catch (e: unknown) {
      setError((e as Error).message)
    } finally {
      setSaving(false)
    }
  }

  return (
    <div className="min-h-screen page-enter" style={{ background: '#080d1a' }}>
      {/* Header */}
      <header className="sticky top-0 z-20 glass-dark">
        <div className="max-w-2xl mx-auto px-4 sm:px-6">
          <div className="flex items-center gap-3 py-4">
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
              <h1 className="text-base font-bold text-white">Perfil</h1>
              <p className="text-xs mt-0.5" style={{ color: 'rgba(255,255,255,0.35)' }}>{user?.email}</p>
            </div>
          </div>
        </div>
      </header>

      <main className="max-w-2xl mx-auto px-4 sm:px-6 py-6 space-y-4">

        {/* Avatar / nombre */}
        <section className="rounded-2xl p-5 flex items-center gap-4" style={{ background: 'rgba(17,28,50,0.6)', border: '1px solid rgba(255,255,255,0.06)' }}>
          <div className="w-14 h-14 rounded-2xl flex items-center justify-center shrink-0 text-2xl font-bold text-gold-400"
            style={{ background: 'rgba(232,166,19,0.1)', border: '1px solid rgba(232,166,19,0.15)' }}>
            {user?.name?.[0]?.toUpperCase() ?? '?'}
          </div>
          <div>
            <div className="font-semibold text-white">{user?.name}</div>
            <div className="text-xs mt-0.5" style={{ color: 'rgba(255,255,255,0.35)' }}>{user?.email}</div>
          </div>
        </section>

        {/* Datos de perfil */}
        <section className="rounded-2xl p-5 space-y-4" style={{ background: 'rgba(17,28,50,0.6)', border: '1px solid rgba(255,255,255,0.06)' }}>
          <h2 className="text-xs font-semibold uppercase tracking-widest" style={{ color: 'rgba(255,255,255,0.3)' }}>Información</h2>

          <div className="space-y-3">
            {/* Nombre */}
            <div>
              <label className="text-xs font-medium mb-1.5 block" style={{ color: 'rgba(255,255,255,0.45)' }}>
                Nombre
              </label>
              <input
                type="text"
                value={name}
                onChange={e => setName(e.target.value)}
                placeholder="Tu nombre"
                className="w-full text-sm bg-transparent outline-none rounded-xl px-3.5 py-2.5"
                style={{ background: 'rgba(255,255,255,0.04)', border: '1px solid rgba(255,255,255,0.08)', color: 'rgba(255,255,255,0.85)' }}
                onFocus={e => (e.currentTarget.style.borderColor = 'rgba(232,166,19,0.3)')}
                onBlur={e => (e.currentTarget.style.borderColor = 'rgba(255,255,255,0.08)')}
              />
            </div>

            {/* Konami ID */}
            <div>
              <label className="text-xs font-medium mb-1.5 flex items-center gap-2" style={{ color: 'rgba(255,255,255,0.45)' }}>
                Konami ID
                <span className="text-xs px-1.5 py-0.5 rounded-md" style={{ background: 'rgba(255,255,255,0.05)', color: 'rgba(255,255,255,0.25)' }}>
                  Master Duel / YGO
                </span>
              </label>
              <input
                type="text"
                value={konamiId}
                onChange={e => setKonamiId(e.target.value)}
                placeholder="Ej: 1234567890"
                className="w-full text-sm bg-transparent outline-none rounded-xl px-3.5 py-2.5 font-mono"
                style={{ background: 'rgba(255,255,255,0.04)', border: '1px solid rgba(255,255,255,0.08)', color: 'rgba(255,255,255,0.85)' }}
                onFocus={e => (e.currentTarget.style.borderColor = 'rgba(232,166,19,0.3)')}
                onBlur={e => (e.currentTarget.style.borderColor = 'rgba(255,255,255,0.08)')}
              />
            </div>

            {/* Duelingbook */}
            <div>
              <label className="text-xs font-medium mb-1.5 flex items-center gap-2" style={{ color: 'rgba(255,255,255,0.45)' }}>
                Duelingbook
                <span className="text-xs px-1.5 py-0.5 rounded-md" style={{ background: 'rgba(255,255,255,0.05)', color: 'rgba(255,255,255,0.25)' }}>
                  usuario
                </span>
              </label>
              <input
                type="text"
                value={duelingbookUsername}
                onChange={e => setDuelingbookUsername(e.target.value)}
                placeholder="Ej: duelist123"
                className="w-full text-sm bg-transparent outline-none rounded-xl px-3.5 py-2.5 font-mono"
                style={{ background: 'rgba(255,255,255,0.04)', border: '1px solid rgba(255,255,255,0.08)', color: 'rgba(255,255,255,0.85)' }}
                onFocus={e => (e.currentTarget.style.borderColor = 'rgba(232,166,19,0.3)')}
                onBlur={e => (e.currentTarget.style.borderColor = 'rgba(255,255,255,0.08)')}
              />
            </div>
          </div>

          {error && <p className="text-xs" style={{ color: 'rgba(255,100,100,0.8)' }}>{error}</p>}

          <button
            onClick={handleSave}
            disabled={saving}
            className="w-full py-3 rounded-xl font-semibold text-sm transition-all disabled:opacity-50"
            style={saved
              ? { background: 'rgba(34,197,94,0.15)', color: '#4ade80', border: '1px solid rgba(34,197,94,0.2)' }
              : { background: 'linear-gradient(135deg,#f5c842,#e8a613)', color: '#080d1a' }
            }
          >
            {saved ? '✓ Guardado' : saving ? 'Guardando...' : 'Guardar cambios'}
          </button>
        </section>

        {/* Info de cuenta */}
        <section className="rounded-2xl p-5 space-y-3" style={{ background: 'rgba(17,28,50,0.6)', border: '1px solid rgba(255,255,255,0.06)' }}>
          <h2 className="text-xs font-semibold uppercase tracking-widest" style={{ color: 'rgba(255,255,255,0.3)' }}>Cuenta</h2>
          <div className="flex items-center justify-between py-1">
            <span className="text-xs" style={{ color: 'rgba(255,255,255,0.4)' }}>Email</span>
            <span className="text-xs font-mono" style={{ color: 'rgba(255,255,255,0.6)' }}>{user?.email}</span>
          </div>
          {user?.konamiId && (
            <div className="flex items-center justify-between py-1">
              <span className="text-xs" style={{ color: 'rgba(255,255,255,0.4)' }}>Konami ID</span>
              <span className="text-xs font-mono font-bold text-gold-400">{user.konamiId}</span>
            </div>
          )}
          {user?.duelingbookUsername && (
            <div className="flex items-center justify-between py-1">
              <span className="text-xs" style={{ color: 'rgba(255,255,255,0.4)' }}>Duelingbook</span>
              <span className="text-xs font-mono font-bold" style={{ color: 'rgba(255,255,255,0.7)' }}>@{user.duelingbookUsername}</span>
            </div>
          )}
        </section>

      </main>
    </div>
  )
}
