import { useState, useEffect, useRef } from 'react'
import { useParams, Link } from 'react-router-dom'
import {
  useCardDetail,
  useUpdateCardDetail,
  useUploadPhotoForCard,
  useDeletePhotoForCard,
} from '../hooks/useCards'

const BASE_URL = 'http://localhost:3000'

const EDITION_OPTIONS = [
  { value: 1, label: '1ra Edición' },
  { value: 2, label: 'Ilimitada' },
  { value: null, label: 'No sé' },
]
const CONDITION_OPTIONS = [
  { value: 1, label: 'NM / LP', sub: 'Bien conservada' },
  { value: 2, label: 'MP / HP', sub: 'Con desgaste' },
  { value: null, label: 'No sé', sub: '' },
]

export default function CardDetail() {
  const { setCode = '', cardId = '' } = useParams()
  const fileInputRef = useRef<HTMLInputElement>(null)
  const id = parseInt(cardId)

  const { data: card, isLoading } = useCardDetail(id)
  const updateCollection = useUpdateCardDetail(id)
  const uploadPhoto = useUploadPhotoForCard(id)
  const deletePhoto = useDeletePhotoForCard(id)

  const [owned, setOwned] = useState(false)
  const [edition, setEdition] = useState<number | null>(null)
  const [condition, setCondition] = useState<number | null>(null)
  const [isUltimate, setIsUltimate] = useState(false)
  const [notes, setNotes] = useState('')
  const [photoIndex, setPhotoIndex] = useState(0)
  const [imgError, setImgError] = useState(false)
  const [saved, setSaved] = useState(false)

  useEffect(() => {
    if (card) {
      setOwned(card.owned)
      setEdition(card.edition)
      setCondition(card.condition)
      setIsUltimate(card.isUltimate)
      setNotes(card.notes ?? '')
    }
  }, [card])

  const handleSave = () => {
    updateCollection.mutate(
      { owned, edition, condition, isUltimate, notes: notes || null },
      {
        onSuccess: () => {
          setSaved(true)
          setTimeout(() => setSaved(false), 2000)
        },
      }
    )
  }

  const handleFileChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const file = e.target.files?.[0]
    if (file) uploadPhoto.mutate(file)
    e.target.value = ''
  }

  const handleDeletePhoto = (photoId: number) => {
    deletePhoto.mutate(photoId)
    setPhotoIndex(0)
  }

  if (isLoading || !card) {
    return (
      <div className="min-h-screen bg-dark-800 flex items-center justify-center">
        <div className="text-gold-500 animate-pulse">Cargando...</div>
      </div>
    )
  }

  const photos = card.photos ?? []
  const safeIndex = photos.length > 0 ? Math.min(photoIndex, photos.length - 1) : 0
  const currentPhoto = photos[safeIndex] ?? null

  const mainImageSrc = currentPhoto
    ? `${BASE_URL}${currentPhoto.url}`
    : card.passcode && !imgError
      ? `https://images.ygoprodeck.com/images/cards_small/${card.passcode}.jpg`
      : null

  return (
    <div className="min-h-screen bg-dark-800">
      {/* Header */}
      <header className="bg-dark-900 border-b border-dark-600 sticky top-0 z-10">
        <div className="max-w-2xl mx-auto px-4 py-3 flex items-center gap-3">
          <Link
            to={`/sets/${setCode}`}
            className="text-gold-500 hover:text-gold-400 transition-colors flex items-center gap-1 shrink-0"
          >
            <svg className="w-4 h-4" fill="none" viewBox="0 0 24 24" stroke="currentColor">
              <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M15 19l-7-7 7-7" />
            </svg>
            {setCode}
          </Link>
          <span className="text-dark-600">/</span>
          <span className="text-gray-400 text-sm truncate">{card.name}</span>
        </div>
      </header>

      <main className="max-w-2xl mx-auto px-4 py-6 space-y-6">

        {/* Card image + photos */}
        <div className="flex gap-4">
          {/* Main image */}
          <div className="relative w-36 shrink-0 rounded-xl overflow-hidden border-2 border-dark-600 bg-dark-900 aspect-[3/4]">
            {mainImageSrc ? (
              <img
                src={mainImageSrc}
                alt={card.name}
                className="w-full h-full object-cover"
                onError={() => setImgError(true)}
              />
            ) : (
              <div className="w-full h-full flex items-center justify-center">
                <span className="text-3xl">&#127183;</span>
              </div>
            )}
            {photos.length > 1 && (
              <div className="absolute bottom-1 left-0 right-0 flex justify-center gap-1">
                {photos.map((_, i) => (
                  <button
                    key={i}
                    onClick={() => setPhotoIndex(i)}
                    className={`w-1.5 h-1.5 rounded-full ${i === safeIndex ? 'bg-gold-500' : 'bg-gray-600'}`}
                  />
                ))}
              </div>
            )}
          </div>

          {/* Card info + photo actions */}
          <div className="flex-1 min-w-0">
            <div className="text-xs text-gold-500 font-mono mb-1">{card.cardCode}</div>
            <h1 className="text-lg font-bold text-gray-100 leading-tight mb-1">{card.name}</h1>
            <div className="text-xs text-gray-500 mb-3">{card.setName}</div>

            {card.wikiUrl && (
              <a
                href={card.wikiUrl}
                target="_blank"
                rel="noopener noreferrer"
                className="inline-flex items-center gap-1.5 text-xs text-gray-500 hover:text-gold-500 transition-colors mb-4"
              >
                <svg className="w-3.5 h-3.5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                  <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M10 6H6a2 2 0 00-2 2v10a2 2 0 002 2h10a2 2 0 002-2v-4M14 4h6m0 0v6m0-6L10 14" />
                </svg>
                Yugipedia
              </a>
            )}

            {/* Photo navigation buttons */}
            {photos.length > 1 && (
              <div className="flex items-center gap-2 mb-2">
                <button
                  onClick={() => setPhotoIndex(i => Math.max(0, i - 1))}
                  disabled={safeIndex === 0}
                  className="text-gray-400 hover:text-white disabled:opacity-30 text-lg leading-none"
                >&#8249;</button>
                <span className="text-xs text-gray-500">{safeIndex + 1} / {photos.length}</span>
                <button
                  onClick={() => setPhotoIndex(i => Math.min(photos.length - 1, i + 1))}
                  disabled={safeIndex === photos.length - 1}
                  className="text-gray-400 hover:text-white disabled:opacity-30 text-lg leading-none"
                >&#8250;</button>
              </div>
            )}

            {/* Photo actions */}
            <div className="flex gap-2">
              <button
                onClick={() => fileInputRef.current?.click()}
                className="flex items-center gap-1.5 text-xs bg-dark-700 border border-dark-600 hover:border-gold-500/50 text-gray-400 hover:text-gray-200 px-3 py-1.5 rounded-lg transition-all"
              >
                &#128247; {photos.length > 0 ? `Añadir foto (${photos.length})` : 'Subir foto'}
              </button>
              {currentPhoto && (
                <button
                  onClick={() => handleDeletePhoto(currentPhoto.id)}
                  className="flex items-center gap-1.5 text-xs bg-dark-700 border border-dark-600 hover:border-red-500/50 text-gray-500 hover:text-red-400 px-3 py-1.5 rounded-lg transition-all"
                >
                  &#128465; Eliminar
                </button>
              )}
            </div>
            <input ref={fileInputRef} type="file" accept="image/*" capture="environment" className="hidden" onChange={handleFileChange} />
          </div>
        </div>

        {/* Photo thumbnails strip */}
        {photos.length > 1 && (
          <div className="flex gap-2 overflow-x-auto pb-1">
            {photos.map((p, i) => (
              <button
                key={p.id}
                onClick={() => setPhotoIndex(i)}
                className={`shrink-0 w-14 h-14 rounded-lg overflow-hidden border-2 transition-all ${i === safeIndex ? 'border-gold-500' : 'border-dark-600 opacity-60 hover:opacity-100'}`}
              >
                <img src={`${BASE_URL}${p.url}`} alt="" className="w-full h-full object-cover" />
              </button>
            ))}
          </div>
        )}

        {/* Collection form */}
        <div className="bg-dark-700 rounded-2xl p-5 space-y-5">
          {/* Owned toggle */}
          <div className="flex items-center justify-between">
            <span className="text-sm font-semibold text-gray-200">Tengo esta carta</span>
            <button
              onClick={() => setOwned(o => !o)}
              className={`relative w-12 h-6 rounded-full overflow-hidden transition-colors ${owned ? 'bg-gold-500' : 'bg-dark-600'}`}
            >
              <span className={`absolute top-0.5 w-5 h-5 bg-white rounded-full shadow transition-transform ${owned ? 'translate-x-6' : 'translate-x-0.5'}`} />
            </button>
          </div>

          {owned && (
            <>
              {/* Edition */}
              <div>
                <label className="text-xs text-gray-400 uppercase tracking-wide mb-2 block">Edición</label>
                <div className="grid grid-cols-3 gap-2">
                  {EDITION_OPTIONS.map(opt => (
                    <button
                      key={String(opt.value)}
                      onClick={() => setEdition(opt.value)}
                      className={`py-2.5 rounded-xl text-sm font-medium transition-all border ${
                        edition === opt.value
                          ? 'bg-gold-500 text-dark-900 border-gold-500'
                          : 'bg-dark-800 text-gray-400 border-dark-600 hover:border-gold-500/40 hover:text-gray-200'
                      }`}
                    >
                      {opt.label}
                    </button>
                  ))}
                </div>
              </div>

              {/* Condition */}
              <div>
                <label className="text-xs text-gray-400 uppercase tracking-wide mb-2 block">Estado</label>
                <div className="grid grid-cols-3 gap-2">
                  {CONDITION_OPTIONS.map(opt => (
                    <button
                      key={String(opt.value)}
                      onClick={() => setCondition(opt.value)}
                      className={`py-2.5 rounded-xl text-sm font-medium transition-all border ${
                        condition === opt.value
                          ? 'bg-gold-500 text-dark-900 border-gold-500'
                          : 'bg-dark-800 text-gray-400 border-dark-600 hover:border-gold-500/40 hover:text-gray-200'
                      }`}
                    >
                      <div>{opt.label}</div>
                      {opt.sub && <div className="text-xs opacity-60">{opt.sub}</div>}
                    </button>
                  ))}
                </div>
              </div>

              {/* Ultimate */}
              <div>
                <label className="text-xs text-gray-400 uppercase tracking-wide mb-2 block">Rareza especial</label>
                <div className="grid grid-cols-2 gap-2">
                  {[
                    { value: true, label: '✦ Ultimate Rare' },
                    { value: false, label: 'Normal' },
                  ].map(opt => (
                    <button
                      key={String(opt.value)}
                      onClick={() => setIsUltimate(opt.value)}
                      className={`py-2.5 rounded-xl text-sm font-medium transition-all border ${
                        isUltimate === opt.value
                          ? 'bg-gold-500 text-dark-900 border-gold-500'
                          : 'bg-dark-800 text-gray-400 border-dark-600 hover:border-gold-500/40 hover:text-gray-200'
                      }`}
                    >
                      {opt.label}
                    </button>
                  ))}
                </div>
              </div>

              {/* Notes */}
              <div>
                <label className="text-xs text-gray-400 uppercase tracking-wide mb-2 block">Notas</label>
                <textarea
                  value={notes}
                  onChange={e => setNotes(e.target.value)}
                  placeholder="Ej: comprada en feria, firmada, sin holo..."
                  rows={3}
                  className="w-full bg-dark-800 border border-dark-600 focus:border-gold-500/60 text-gray-200 placeholder-gray-600 rounded-xl px-3 py-2.5 text-sm resize-none outline-none transition-colors"
                />
              </div>
            </>
          )}

          {/* Save button */}
          <button
            onClick={handleSave}
            disabled={updateCollection.isPending}
            className={`w-full py-3 rounded-xl font-semibold text-sm transition-all ${
              saved
                ? 'bg-green-600 text-white'
                : 'bg-gold-500 hover:bg-gold-400 text-dark-900'
            } disabled:opacity-60`}
          >
            {saved ? '✓ Guardado' : updateCollection.isPending ? 'Guardando...' : 'Guardar'}
          </button>
        </div>
      </main>
    </div>
  )
}
