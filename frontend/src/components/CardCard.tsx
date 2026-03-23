import { useState, useRef } from 'react'
import { useNavigate } from 'react-router-dom'
import { Card } from '../api/client'

const BASE_URL = 'http://localhost:3000'

interface CardCardProps {
  card: Card
  setCode: string
  onUpdateCollection: (data: { cardId: number; owned: boolean; edition: number | null; condition: number | null; isUltimate: boolean }) => void
  onUploadPhoto?: (cardId: number, file: File) => void
  onDeletePhoto?: (cardId: number, photoId: number) => void
}

const EDITION_LABELS: Record<number, string> = { 1: '1ra Ed.', 2: 'Ilimitada' }
const CONDITION_LABELS: Record<number, string> = { 1: 'NM/LP', 2: 'MP/HP' }

export default function CardCard({ card, setCode, onUploadPhoto, onDeletePhoto }: CardCardProps) {
  const navigate = useNavigate()
  const [imgError, setImgError] = useState(false)
  const [photoIndex, setPhotoIndex] = useState(0)
  const fileInputRef = useRef<HTMLInputElement>(null)

  const hasPhotos = card.photos && card.photos.length > 0
  const safeIndex = hasPhotos ? Math.min(photoIndex, card.photos.length - 1) : 0
  const currentPhoto = hasPhotos ? card.photos[safeIndex] : null

  const handleFileChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const file = e.target.files?.[0]
    if (file && onUploadPhoto) onUploadPhoto(card.id, file)
    e.target.value = ''
  }

  const goToDetail = () => navigate(`/sets/${setCode}/cards/${card.id}`)

  return (
    <div
      className="group relative rounded-2xl overflow-hidden transition-all duration-200 hover:-translate-y-0.5"
      style={{
        background: 'rgba(17,28,50,0.7)',
        border: `1px solid ${card.owned ? 'rgba(232,166,19,0.3)' : 'rgba(255,255,255,0.06)'}`,
        boxShadow: card.owned ? '0 0 16px rgba(232,166,19,0.08)' : undefined,
      }}
    >
      {/* Image */}
      <div
        className="aspect-[3/4] relative overflow-hidden cursor-pointer"
        style={{ background: '#05080f' }}
        onClick={goToDetail}
      >
        {currentPhoto ? (
          <img src={`${BASE_URL}${currentPhoto.url}`} alt={card.name}
            className="w-full h-full object-cover" loading="lazy" />
        ) : card.passcode && !imgError ? (
          <img src={`https://images.ygoprodeck.com/images/cards_small/${card.passcode}.jpg`}
            alt={card.name} className="w-full h-full object-cover transition-transform duration-300 group-hover:scale-105"
            loading="lazy" onError={() => setImgError(true)} />
        ) : (
          <div className="w-full h-full flex flex-col items-center justify-center gap-2 p-3">
            <div className="text-2xl opacity-20">&#127183;</div>
            <div className="text-xs text-center leading-tight opacity-20">{card.name}</div>
          </div>
        )}

        {/* Overlay on hover */}
        <div className="absolute inset-0 bg-gradient-to-t from-black/60 via-transparent to-transparent opacity-0 group-hover:opacity-100 transition-opacity duration-200" />

        {/* Ultimate badge */}
        {card.isUltimate && (
          <div className="absolute top-2 left-2 text-xs font-bold px-1.5 py-0.5 rounded-md"
            style={{ background: 'linear-gradient(135deg,#f5c842,#e8a613)', color: '#080d1a' }}>
            ✦ Ulti
          </div>
        )}

        {/* Photo count */}
        {hasPhotos && card.photos.length > 1 && (
          <div className="absolute top-2 right-2 text-xs font-medium px-1.5 py-0.5 rounded-md"
            style={{ background: 'rgba(0,0,0,0.6)', color: 'rgba(255,255,255,0.7)' }}>
            {safeIndex + 1}/{card.photos.length}
          </div>
        )}

        {/* Photo nav arrows */}
        {hasPhotos && card.photos.length > 1 && (
          <>
            {safeIndex > 0 && (
              <button onClick={e => { e.stopPropagation(); setPhotoIndex(i => Math.max(0, i - 1)) }}
                className="absolute left-1 top-1/2 -translate-y-1/2 w-6 h-6 rounded-full flex items-center justify-center text-xs transition-opacity"
                style={{ background: 'rgba(0,0,0,0.6)', color: 'white' }}>
                &#8249;
              </button>
            )}
            {safeIndex < card.photos.length - 1 && (
              <button onClick={e => { e.stopPropagation(); setPhotoIndex(i => Math.min(card.photos.length - 1, i + 1)) }}
                className="absolute right-1 top-1/2 -translate-y-1/2 w-6 h-6 rounded-full flex items-center justify-center text-xs transition-opacity"
                style={{ background: 'rgba(0,0,0,0.6)', color: 'white' }}>
                &#8250;
              </button>
            )}
          </>
        )}

        {/* Photo controls */}
        {card.owned && (
          <div className="absolute bottom-2 right-2 flex gap-1 opacity-0 group-hover:opacity-100 transition-opacity">
            {currentPhoto && onDeletePhoto && (
              <button onClick={e => { e.stopPropagation(); onDeletePhoto(card.id, currentPhoto.id); setPhotoIndex(0) }}
                className="w-6 h-6 rounded-lg flex items-center justify-center text-xs transition-colors"
                style={{ background: 'rgba(0,0,0,0.7)', color: 'rgba(255,100,100,0.8)' }}>
                &#128465;
              </button>
            )}
            {onUploadPhoto && (
              <button onClick={e => { e.stopPropagation(); fileInputRef.current?.click() }}
                className="w-6 h-6 rounded-lg flex items-center justify-center text-xs transition-colors"
                style={{ background: 'rgba(0,0,0,0.7)', color: 'rgba(255,255,255,0.7)' }}>
                &#128247;
              </button>
            )}
          </div>
        )}

        {/* Not owned dim overlay */}
        {!card.owned && (
          <div className="absolute inset-0 bg-surface-950/50 group-hover:bg-transparent transition-colors duration-200" />
        )}

        <input ref={fileInputRef} type="file" accept="image/*" capture="environment"
          className="hidden" onChange={handleFileChange} />
      </div>

      {/* Info */}
      <div className="p-2.5">
        <div className="font-mono text-xs mb-0.5 text-gold-500/70">{card.cardCode}</div>
        <div className="text-xs font-medium leading-tight line-clamp-2 mb-2"
          style={{ color: card.owned ? 'rgba(255,255,255,0.85)' : 'rgba(255,255,255,0.4)' }}>
          {card.name}
        </div>

        {card.owned && (card.edition != null || card.condition != null) && (
          <div className="flex flex-wrap gap-1 mb-2">
            {card.edition != null && (
              <span className="chip">{EDITION_LABELS[card.edition]}</span>
            )}
            {card.condition != null && (
              <span className="chip">{CONDITION_LABELS[card.condition]}</span>
            )}
          </div>
        )}

        <div className="flex items-center justify-between gap-1">
          <button
            onClick={goToDetail}
            className="flex items-center gap-1 text-xs px-2.5 py-1 rounded-lg font-semibold transition-all"
            style={card.owned
              ? { background: 'linear-gradient(135deg,#f5c842,#e8a613)', color: '#080d1a' }
              : { background: 'rgba(255,255,255,0.05)', color: 'rgba(255,255,255,0.4)', border: '1px solid rgba(255,255,255,0.08)' }
            }
          >
            {card.owned ? '✓ Tengo' : '+ Añadir'}
          </button>

          {card.wikiUrl && (
            <a href={card.wikiUrl} target="_blank" rel="noopener noreferrer"
              className="w-6 h-6 flex items-center justify-center rounded-lg transition-colors"
              style={{ color: 'rgba(255,255,255,0.2)' }}
              onMouseEnter={e => (e.currentTarget as HTMLElement).style.color = '#e8a613'}
              onMouseLeave={e => (e.currentTarget as HTMLElement).style.color = 'rgba(255,255,255,0.2)'}
              onClick={e => e.stopPropagation()}>
              <svg className="w-3.5 h-3.5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M10 6H6a2 2 0 00-2 2v10a2 2 0 002 2h10a2 2 0 002-2v-4M14 4h6m0 0v6m0-6L10 14" />
              </svg>
            </a>
          )}
        </div>
      </div>
    </div>
  )
}
