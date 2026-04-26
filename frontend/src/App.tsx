import { BrowserRouter, Routes, Route, Navigate } from 'react-router-dom'
import { AuthProvider } from './context/AuthContext'
import ProtectedRoute from './components/ProtectedRoute'
import Collections from './pages/Collections'
import Home from './pages/Home'
import ConfigureCollection from './pages/ConfigureCollection'
import SetView from './pages/SetView'
import CardDetail from './pages/CardDetail'
import Profile from './pages/Profile'
import Login from './pages/Login'
import Register from './pages/Register'

export default function App() {
  return (
    <AuthProvider>
      <BrowserRouter>
        <Routes>
          <Route path="/login" element={<Login />} />
          <Route path="/register" element={<Register />} />
          <Route path="/" element={<ProtectedRoute><Collections /></ProtectedRoute>} />
          <Route path="/collections/:collectionId" element={<ProtectedRoute><Home /></ProtectedRoute>} />
          <Route path="/collections/:collectionId/configure" element={<ProtectedRoute><ConfigureCollection /></ProtectedRoute>} />
          <Route path="/collections/:collectionId/sets/:setCode" element={<ProtectedRoute><SetView /></ProtectedRoute>} />
          <Route path="/collections/:collectionId/sets/:setCode/cards/:cardId" element={<ProtectedRoute><CardDetail /></ProtectedRoute>} />
          <Route path="/collections/:collectionId/cards/:cardId" element={<ProtectedRoute><CardDetail /></ProtectedRoute>} />
          <Route path="/profile" element={<ProtectedRoute><Profile /></ProtectedRoute>} />
          <Route path="*" element={<Navigate to="/" replace />} />
        </Routes>
      </BrowserRouter>
    </AuthProvider>
  )
}
