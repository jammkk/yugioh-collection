import { useState, FormEvent } from 'react'
import { Link, useNavigate } from 'react-router-dom'
import { useAuth } from '../context/AuthContext'

export default function Register() {
  const { register } = useAuth()
  const navigate = useNavigate()
  const [name, setName] = useState('')
  const [email, setEmail] = useState('')
  const [password, setPassword] = useState('')
  const [error, setError] = useState('')
  const [loading, setLoading] = useState(false)

  const handleSubmit = async (e: FormEvent) => {
    e.preventDefault()
    setError('')
    setLoading(true)
    try {
      await register(email, password, name)
      navigate('/', { replace: true })
    } catch (err: unknown) {
      setError(err instanceof Error ? err.message : 'Error al registrarse')
    } finally {
      setLoading(false)
    }
  }

  const inputStyle = {
    background: 'rgba(255,255,255,0.04)',
    border: '1px solid rgba(255,255,255,0.08)',
    color: 'rgba(255,255,255,0.85)',
  }

  return (
    <div className="min-h-screen flex items-center justify-center px-4" style={{ background: '#080d1a' }}>
      <div className="w-full max-w-sm">
        <div className="text-center mb-8">
          <div className="text-3xl mb-2">&#127183;</div>
          <h1 className="text-xl font-bold text-white">YGO Collection</h1>
          <p className="text-sm mt-1" style={{ color: 'rgba(255,255,255,0.35)' }}>Crea tu cuenta</p>
        </div>

        <form onSubmit={handleSubmit}
          className="rounded-2xl p-6 space-y-4"
          style={{ background: 'rgba(17,28,50,0.8)', border: '1px solid rgba(255,255,255,0.07)' }}
        >
          {error && (
            <div className="text-sm px-3 py-2 rounded-xl"
              style={{ background: 'rgba(255,60,60,0.1)', border: '1px solid rgba(255,60,60,0.2)', color: 'rgba(255,120,120,0.9)' }}>
              {error}
            </div>
          )}

          <div className="space-y-1">
            <label className="text-xs font-semibold uppercase tracking-widest"
              style={{ color: 'rgba(255,255,255,0.35)' }}>Nombre</label>
            <input
              type="text"
              value={name}
              onChange={e => setName(e.target.value)}
              required
              autoComplete="name"
              placeholder="Tu nombre"
              className="w-full px-3.5 py-2.5 rounded-xl text-sm outline-none transition-all"
              style={inputStyle}
              onFocus={e => (e.currentTarget.style.borderColor = 'rgba(232,166,19,0.4)')}
              onBlur={e => (e.currentTarget.style.borderColor = 'rgba(255,255,255,0.08)')}
            />
          </div>

          <div className="space-y-1">
            <label className="text-xs font-semibold uppercase tracking-widest"
              style={{ color: 'rgba(255,255,255,0.35)' }}>Email</label>
            <input
              type="email"
              value={email}
              onChange={e => setEmail(e.target.value)}
              required
              autoComplete="email"
              placeholder="tu@email.com"
              className="w-full px-3.5 py-2.5 rounded-xl text-sm outline-none transition-all"
              style={inputStyle}
              onFocus={e => (e.currentTarget.style.borderColor = 'rgba(232,166,19,0.4)')}
              onBlur={e => (e.currentTarget.style.borderColor = 'rgba(255,255,255,0.08)')}
            />
          </div>

          <div className="space-y-1">
            <label className="text-xs font-semibold uppercase tracking-widest"
              style={{ color: 'rgba(255,255,255,0.35)' }}>Contraseña</label>
            <input
              type="password"
              value={password}
              onChange={e => setPassword(e.target.value)}
              required
              minLength={6}
              autoComplete="new-password"
              placeholder="Mínimo 6 caracteres"
              className="w-full px-3.5 py-2.5 rounded-xl text-sm outline-none transition-all"
              style={inputStyle}
              onFocus={e => (e.currentTarget.style.borderColor = 'rgba(232,166,19,0.4)')}
              onBlur={e => (e.currentTarget.style.borderColor = 'rgba(255,255,255,0.08)')}
            />
          </div>

          <button
            type="submit"
            disabled={loading}
            className="w-full py-3 rounded-xl font-semibold text-sm transition-all disabled:opacity-50 mt-2"
            style={{ background: 'linear-gradient(135deg,#f5c842,#e8a613)', color: '#080d1a' }}
          >
            {loading ? 'Creando cuenta...' : 'Crear cuenta'}
          </button>
        </form>

        <p className="text-center text-sm mt-4" style={{ color: 'rgba(255,255,255,0.3)' }}>
          ¿Ya tienes cuenta?{' '}
          <Link to="/login"
            className="font-medium transition-colors"
            style={{ color: '#e8a613' }}>
            Inicia sesión
          </Link>
        </p>
      </div>
    </div>
  )
}
