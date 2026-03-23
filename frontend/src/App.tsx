import { BrowserRouter, Routes, Route } from 'react-router-dom'
import Home from './pages/Home'
import SetView from './pages/SetView'
import CardDetail from './pages/CardDetail'

export default function App() {
  return (
    <BrowserRouter>
      <Routes>
        <Route path="/" element={<Home />} />
        <Route path="/sets/:setCode" element={<SetView />} />
        <Route path="/sets/:setCode/cards/:cardId" element={<CardDetail />} />
      </Routes>
    </BrowserRouter>
  )
}
