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
  const [ygoprodImgError, setYgoprodImgError] = useState(false)
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
      className={`
        relative rounded-xl overflow-hidden border-2 transition-all duration-200 bg-dark-700
        ${card.owned
          ? 'border-gold-500 shadow-gold-500/20 shadow-md'
          : 'border-dark-600 opacity-60 grayscale hover:opacity-80 hover:grayscale-0'
        }
      `}
    >
      {/* Clickable image area → detail page */}
      <div
        className="aspect-[3/4] bg-dark-900 relative overflow-hidden cursor-pointer"
        onClick={goToDetail}
      >
        {currentPhoto ? (
          <img
            src={`${BASE_URL}${currentPhoto.url}`}
            alt={card.name}
            className="w-full h-full object-cover"
            loading="lazy"
          />
        ) : card.passcode && !ygoprodImgError ? (
          <img
            src={`https://images.ygoprodeck.com/images/cards_small/${card.passcode}.jpg`}
            alt={card.name}
            className="w-full h-full object-cover"
            loading="lazy"
            onError={() => setYgoprodImgError(true)}
          />
        ) : (
          <div className="w-full h-full flex items-center justify-center bg-dark-800">
            <div className="text-center p-2">
              <div className="text-gold-500 text-2xl mb-1">&#127183;</div>
              <div className="text-xs text-gray-500 leading-tight">{card.name}</div>
            </div>
          </div>
        )}

        {card.isUltimate && (
          <div className="absolute top-1 left-1 bg-gold-500 text-dark-900 text-xs font-bold px-1.5 py-0.5 rounded">
            &#10022;
          </div>
        )}

        {/* Photo nav arrows */}
        {hasPhotos && card.photos.length > 1 && (
          <>
            {safeIndex > 0 && (
              <button onClick={e => { e.stopPropagation(); setPhotoIndex(i => Math.max(0, i - 1)) }}
                className="absolute left-1 top-1/2 -translate-y-1/2 bg-dark-900/80 text-white rounded-full w-6 h-6 flex items-center justify-center text-xs">
                &#8249;
              </button>
            )}
            {safeIndex < card.photos.length - 1 && (
              <button onClick={e => { e.stopPropagation(); setPhotoIndex(i => Math.min(card.photos.length - 1, i + 1)) }}
                className="absolute right-1 top-1/2 -translate-y-1/2 bg-dark-900/80 text-white rounded-full w-6 h-6 flex items-center justify-center text-xs">
                &#8250;
              </button>
            )}
            <div className="absolute bottom-7 left-0 right-0 flex justify-center gap-1">
              {card.photos.map((_, i) => (
                <button key={i} onClick={e => { e.stopPropagation(); setPhotoIndex(i) }}
                  className={`w-1.5 h-1.5 rounded-full ${i === safeIndex ? 'bg-gold-500' : 'bg-gray-600'}`} />
              ))}
            </div>
          </>
        )}

        {/* Photo count */}
        {hasPhotos && card.photos.length > 1 && (
          <div className="absolute top-1 right-1 bg-dark-900/80 text-gray-300 text-xs px-1.5 py-0.5 rounded-full">
            {safeIndex + 1}/{card.photos.length}
          </div>
        )}

        {/* Camera / delete buttons */}
        {card.owned && (
          <div className="absolute bottom-1 right-1 flex gap-1">
            {currentPhoto && onDeletePhoto && (
              <button onClick={e => { e.stopPropagation(); onDeletePhoto(card.id, currentPhoto.id); setPhotoIndex(0) }}
                className="bg-dark-900/80 text-red-400 hover:text-red-300 p-1 rounded text-xs" title="Eliminar foto">
                &#128465;
              </button>
            )}
            {onUploadPhoto && (
              <button onClick={e => { e.stopPropagation(); fileInputRef.current?.click() }}
                className="bg-dark-900/80 text-gray-300 hover:text-white p-1 rounded text-xs" title="Subir foto">
                &#128247;
              </button>
            )}
          </div>
        )}

        <input ref={fileInputRef} type="file" accept="image/*" capture="environment" className="hidden" onChange={handleFileChange} />
      </div>

      {/* Card info */}
      <div className="p-2">
        <div className="text-xs text-gold-500 font-mono mb-0.5">{card.cardCode}</div>
        <div className="text-xs text-gray-300 leading-tight line-clamp-2 mb-2">{card.name}</div>

        {card.owned && (
          <div className="flex flex-wrap gap-1 mb-2">
            {card.edition != null && (
              <span className="text-xs bg-dark-600 text-gray-300 px-1.5 py-0.5 rounded">{EDITION_LABELS[card.edition]}</span>
            )}
            {card.condition != null && (
              <span className="text-xs bg-dark-600 text-gray-300 px-1.5 py-0.5 rounded">{CONDITION_LABELS[card.condition]}</span>
            )}
          </div>
        )}

        <div className="flex items-center justify-between">
          {/* "Tengo" / "Añadir" → navigates to detail */}
          <button
            onClick={goToDetail}
            className={`
              flex items-center gap-1.5 text-xs px-2 py-1 rounded-lg transition-all
              ${card.owned
                ? 'bg-gold-500 text-dark-900 font-semibold hover:bg-gold-400'
                : 'bg-dark-600 text-gray-400 hover:bg-dark-500 hover:text-gray-200'
              }
            `}
          >
            <span>{card.owned ? '✓' : '+'}</span>
            <span>{card.owned ? 'Tengo' : 'Añadir'}</span>
          </button>

          {card.wikiUrl && (
            <a href={card.wikiUrl} target="_blank" rel="noopener noreferrer"
              className="text-gray-500 hover:text-gold-500 transition-colors" title="Ver en Yugipedia">
              <svg className="w-4 h-4" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M10 6H6a2 2 0 00-2 2v10a2 2 0 002 2h10a2 2 0 002-2v-4M14 4h6m0 0v6m0-6L10 14" />
              </svg>
            </a>
          )}
        </div>
      </div>
    </div>
  )
}
