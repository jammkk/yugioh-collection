import { describe, it, expect, vi, beforeEach } from 'vitest'
import { render, screen, waitFor } from '@testing-library/react'
import userEvent from '@testing-library/user-event'
import { AuthProvider, useAuth } from '../context/AuthContext'
import { removeToken } from '../api/client'

vi.mock('../api/client', async (importOriginal) => {
  const actual = await importOriginal<typeof import('../api/client')>()
  return {
    ...actual,
    api: {
      me: vi.fn().mockRejectedValue(new Error('no token')),
      login: vi.fn().mockResolvedValue({ user: { id: 1, email: 'test@test.com', name: 'Test' }, token: 'fake-token' }),
      logout: vi.fn().mockResolvedValue({ ok: true }),
      register: vi.fn().mockResolvedValue({ user: { id: 2, email: 'new@test.com', name: 'New' }, token: 'fake-token-2' }),
    },
  }
})

function TestComponent() {
  const { user, login, logout } = useAuth()
  return (
    <div>
      <span data-testid="user">{user ? user.email : 'sin sesión'}</span>
      <button onClick={() => login('test@test.com', '123456')}>Login</button>
      <button onClick={() => logout()}>Logout</button>
    </div>
  )
}

describe('AuthContext', () => {
  beforeEach(() => {
    localStorage.clear()
    removeToken()
  })

  it('empieza sin usuario', async () => {
    render(<AuthProvider><TestComponent /></AuthProvider>)
    await waitFor(() => {
      expect(screen.getByTestId('user').textContent).toBe('sin sesión')
    })
  })

  it('setea el usuario al hacer login', async () => {
    render(<AuthProvider><TestComponent /></AuthProvider>)
    await waitFor(() => screen.getByTestId('user'))
    await userEvent.click(screen.getByText('Login'))
    await waitFor(() => {
      expect(screen.getByTestId('user').textContent).toBe('test@test.com')
    })
  })

  it('limpia el usuario al hacer logout', async () => {
    render(<AuthProvider><TestComponent /></AuthProvider>)
    await userEvent.click(screen.getByText('Login'))
    await waitFor(() => expect(screen.getByTestId('user').textContent).toBe('test@test.com'))
    await userEvent.click(screen.getByText('Logout'))
    await waitFor(() => expect(screen.getByTestId('user').textContent).toBe('sin sesión'))
  })
})
