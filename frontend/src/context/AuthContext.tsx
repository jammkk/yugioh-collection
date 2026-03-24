import { createContext, useContext, useState, useEffect, ReactNode } from 'react'
import { api, User, getToken, setToken, removeToken } from '../api/client'

interface AuthContextValue {
  user: User | null
  isLoading: boolean
  login: (email: string, password: string) => Promise<void>
  register: (email: string, password: string, name: string) => Promise<void>
  logout: () => Promise<void>
}

const AuthContext = createContext<AuthContextValue | null>(null)

export function AuthProvider({ children }: { children: ReactNode }) {
  const [user, setUser] = useState<User | null>(null)
  const [isLoading, setIsLoading] = useState(true)

  useEffect(() => {
    if (!getToken()) {
      setIsLoading(false)
      return
    }
    api.me()
      .then(({ user }) => setUser(user))
      .catch(() => { removeToken(); setUser(null) })
      .finally(() => setIsLoading(false))
  }, [])

  const login = async (email: string, password: string) => {
    const { user, token } = await api.login(email, password)
    setToken(token)
    setUser(user)
  }

  const register = async (email: string, password: string, name: string) => {
    const { user, token } = await api.register(email, password, name)
    setToken(token)
    setUser(user)
  }

  const logout = async () => {
    api.logout().catch(() => {})
    removeToken()
    setUser(null)
  }

  return (
    <AuthContext.Provider value={{ user, isLoading, login, register, logout }}>
      {children}
    </AuthContext.Provider>
  )
}

export function useAuth() {
  const ctx = useContext(AuthContext)
  if (!ctx) throw new Error('useAuth must be used within AuthProvider')
  return ctx
}
