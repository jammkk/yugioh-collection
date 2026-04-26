import { describe, it, expect, beforeEach } from 'vitest'
import { getToken, setToken, removeToken } from '../api/client'

describe('token helpers', () => {
  beforeEach(() => {
    localStorage.clear()
  })

  it('getToken devuelve null si no hay token', () => {
    expect(getToken()).toBeNull()
  })

  it('setToken guarda el token en localStorage', () => {
    setToken('abc123')
    expect(getToken()).toBe('abc123')
  })

  it('removeToken elimina el token', () => {
    setToken('abc123')
    removeToken()
    expect(getToken()).toBeNull()
  })
})
