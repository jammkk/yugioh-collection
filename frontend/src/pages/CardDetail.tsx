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
  { value: 1, label: '1ra Ed.' },
  { value: 2, label: 'Ilimitada' },
  { value: null, label: 'No sé' },
]
const CONDITION_OPTIONS = [
  { value: 1, label: 'NM / LP', sub: 'Bien' },
  { value: 2, label: 'MP / HP', sub: 'Usado' },
  { value: null, label: 'No sé', sub: '' },
]
const LANGUAGE_OPTIONS = [
  { value: 1, label: 'Español' },
  { value: 2, label: 'English' },
  { value: 3, label: 'Italiano' },
  { value: 4, label: 'Français' },
  { value: 5, label: 'Português' },
  { value: 6, label: 'Deutsch' },
  { value: null, label: 'No sé' },
]

function OptionButton({ selected, onClick, children }: { selected: boolean; onClick: () => void; children: React.ReactNode }) {
  return (
    <button
      onClick={onClick}
      className="py-2.5 rounded-xl text-sm font-medium transition-all"
      style={selected
        ? { background: 'linear-gradient(135deg,#f5c842,#e8a613)', color: '#080d1a', border: '1px solid transparent' }
        : { background: 'rgba(255,255,255,0.04)', color: 'rgba(255,255,255,0.45)', border: '1px solid rgba(255,255,255,0.08)' }
      }
    >
      {children}
    </button>
  )
}

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
  const [language, setLanguage] = useState<number | null>(null)
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
      setLanguage(card.language)
      setNotes(card.notes ?? '')
    }
  }, [card])

  const handleSave = () => {
    updateCollection.mutate(
      { owned, edition, condition, isUltimate, language, notes: notes || null },
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
      <div className="min-h-screen flex items-center justify-center" style={{ background: '#080d1a' }}>
        <div className="w-7 h-7 rounded-full border-2 border-gold-500 border-t-transparent animate-spin" />
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
    <div className="min-h-screen page-enter" style={{ background: '#080d1a' }}>
      {/* Header */}
      <header className="sticky top-0 z-20 glass-dark">
        <div className="max-w-2xl mx-auto px-4 py-3 flex items-center gap-2">
          <Link
            to={`/sets/${setCode}`}
            className="flex items-center gap-1 text-sm font-medium shrink-0 transition-colors"
            style={{ color: 'rgba(255,255,255,0.35)' }}
            onMouseEnter={e => (e.currentTarget as HTMLElement).style.color = '#e8a613'}
            onMouseLeave={e => (e.currentTarget as HTMLElement).style.color = 'rgba(255,255,255,0.35)'}
          >
            <svg className="w-4 h-4" fill="none" viewBox="0 0 24 24" stroke="currentColor">
              <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M15 19l-7-7 7-7" />
            </svg>
            {setCode}
          </Link>
          <span style={{ color: 'rgba(255,255,255,0.12)' }}>/</span>
          <span className="text-sm font-medium truncate" style={{ color: 'rgba(255,255,255,0.5)' }}>{card.name}</span>
        </div>
      </header>

      <main className="max-w-2xl mx-auto px-4 py-6 space-y-5">

        {/* Hero: image + info */}
        <div className="rounded-2xl overflow-hidden" style={{ background: 'rgba(17,28,50,0.6)', border: '1px solid rgba(255,255,255,0.06)' }}>
          <div className="flex gap-0">
            {/* Image column */}
            <div className="relative w-36 shrink-0" style={{ background: '#05080f' }}>
              <div className="aspect-[3/4]">
                {mainImageSrc ? (
                  <img src={mainImageSrc} alt={card.name} className="w-full h-full object-cover" onError={() => setImgError(true)} />
                ) : (
                  <div className="w-full h-full flex items-center justify-center">
                    <span className="text-3xl opacity-20">&#127183;</span>
                  </div>
                )}
              </div>
              {/* Photo dots */}
              {photos.length > 1 && (
                <div className="absolute bottom-2 left-0 right-0 flex justify-center gap-1">
                  {photos.map((_, i) => (
                    <button key={i} onClick={() => setPhotoIndex(i)}
                      className="w-1.5 h-1.5 rounded-full transition-colors"
                      style={{ background: i === safeIndex ? '#e8a613' : 'rgba(255,255,255,0.3)' }} />
                  ))}
                </div>
              )}
            </div>

            {/* Info column */}
            <div className="flex-1 p-4 flex flex-col justify-between min-w-0">
              <div>
                <div className="flex items-center gap-2 mb-2">
                  <span className="text-xs font-bold font-mono text-gold-400 bg-gold-500/10 px-1.5 py-0.5 rounded-md">
                    {card.cardCode}
                  </span>
                  {owned && <span className="text-xs font-bold px-1.5 py-0.5 rounded-md" style={{ background: 'rgba(232,166,19,0.15)', color: '#e8a613' }}>Tengo</span>}
                </div>
                <h1 className="text-base font-bold text-white leading-tight mb-1">{card.name}</h1>
                <p className="text-xs" style={{ color: 'rgba(255,255,255,0.3)' }}>{card.setName}</p>
              </div>

              <div className="space-y-2 mt-3">
                {/* Photo nav */}
                {photos.length > 1 && (
                  <div className="flex items-center gap-2">
                    <button onClick={() => setPhotoIndex(i => Math.max(0, i - 1))} disabled={safeIndex === 0}
                      className="text-sm disabled:opacity-20 transition-opacity" style={{ color: 'rgba(255,255,255,0.5)' }}>&#8249;</button>
                    <span className="text-xs" style={{ color: 'rgba(255,255,255,0.3)' }}>{safeIndex + 1}/{photos.length}</span>
                    <button onClick={() => setPhotoIndex(i => Math.min(photos.length - 1, i + 1))} disabled={safeIndex === photos.length - 1}
                      className="text-sm disabled:opacity-20 transition-opacity" style={{ color: 'rgba(255,255,255,0.5)' }}>&#8250;</button>
                  </div>
                )}

                {/* Photo buttons */}
                <div className="flex gap-2 flex-wrap">
                  <button onClick={() => fileInputRef.current?.click()}
                    className="flex items-center gap-1.5 text-xs px-3 py-1.5 rounded-lg font-medium transition-all"
                    style={{ background: 'rgba(255,255,255,0.06)', border: '1px solid rgba(255,255,255,0.08)', color: 'rgba(255,255,255,0.6)' }}>
                    &#128247; {photos.length > 0 ? `Foto (${photos.length})` : 'Subir foto'}
                  </button>
                  {currentPhoto && (
                    <button onClick={() => handleDeletePhoto(currentPhoto.id)}
                      className="flex items-center gap-1.5 text-xs px-3 py-1.5 rounded-lg font-medium transition-all"
                      style={{ background: 'rgba(255,60,60,0.08)', border: '1px solid rgba(255,60,60,0.12)', color: 'rgba(255,100,100,0.7)' }}>
                      &#128465;
                    </button>
                  )}
                  {card.wikiUrl && (
                    <a href={card.wikiUrl} target="_blank" rel="noopener noreferrer"
                      className="flex items-center gap-1 text-xs px-3 py-1.5 rounded-lg font-medium transition-all"
                      style={{ background: 'rgba(255,255,255,0.04)', border: '1px solid rgba(255,255,255,0.06)', color: 'rgba(255,255,255,0.35)' }}>
                      <svg className="w-3 h-3" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                        <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M10 6H6a2 2 0 00-2 2v10a2 2 0 002 2h10a2 2 0 002-2v-4M14 4h6m0 0v6m0-6L10 14" />
                      </svg>
                      Wiki
                    </a>
                  )}
                </div>
              </div>
            </div>
          </div>
        </div>

        {/* Photo thumbnails */}
        {photos.length > 1 && (
          <div className="flex gap-2 overflow-x-auto pb-1">
            {photos.map((p, i) => (
              <button key={p.id} onClick={() => setPhotoIndex(i)}
                className="shrink-0 w-14 h-14 rounded-xl overflow-hidden transition-all"
                style={{ border: `2px solid ${i === safeIndex ? '#e8a613' : 'rgba(255,255,255,0.06)'}`, opacity: i === safeIndex ? 1 : 0.5 }}>
                <img src={`${BASE_URL}${p.url}`} alt="" className="w-full h-full object-cover" />
              </button>
            ))}
          </div>
        )}

        {/* Collection form */}
        <div className="rounded-2xl p-5 space-y-5" style={{ background: 'rgba(17,28,50,0.6)', border: '1px solid rgba(255,255,255,0.06)' }}>

          {/* Owned toggle */}
          <div className="flex items-center justify-between">
            <div>
              <div className="text-sm font-semibold text-white">Tengo esta carta</div>
              <div className="text-xs mt-0.5" style={{ color: 'rgba(255,255,255,0.3)' }}>
                {owned ? 'En tu colección' : 'No la tienes aún'}
              </div>
            </div>
            <button
              onClick={() => setOwned(o => !o)}
              className="relative w-11 h-6 rounded-full transition-all duration-300"
              style={{ background: owned ? 'linear-gradient(135deg,#f5c842,#e8a613)' : 'rgba(255,255,255,0.08)' }}
            >
              <span className={`absolute top-0.5 w-5 h-5 bg-white rounded-full shadow-md transition-transform duration-300 ${owned ? 'translate-x-5' : 'translate-x-0.5'}`} />
            </button>
          </div>

          {owned && (
            <>
              <div className="h-px" style={{ background: 'rgba(255,255,255,0.06)' }} />

              {/* Edition */}
              <div>
                <label className="text-xs font-semibold uppercase tracking-widest mb-3 block" style={{ color: 'rgba(255,255,255,0.3)' }}>
                  Edición
                </label>
                <div className="grid grid-cols-3 gap-2">
                  {EDITION_OPTIONS.map(opt => (
                    <OptionButton key={String(opt.value)} selected={edition === opt.value} onClick={() => setEdition(opt.value)}>
                      {opt.label}
                    </OptionButton>
                  ))}
                </div>
              </div>

              {/* Condition */}
              <div>
                <label className="text-xs font-semibold uppercase tracking-widest mb-3 block" style={{ color: 'rgba(255,255,255,0.3)' }}>
                  Estado
                </label>
                <div className="grid grid-cols-3 gap-2">
                  {CONDITION_OPTIONS.map(opt => (
                    <OptionButton key={String(opt.value)} selected={condition === opt.value} onClick={() => setCondition(opt.value)}>
                      <div>{opt.label}</div>
                      {opt.sub && <div className="text-xs opacity-60 font-normal">{opt.sub}</div>}
                    </OptionButton>
                  ))}
                </div>
              </div>

              {/* Ultimate */}
              <div>
                <label className="text-xs font-semibold uppercase tracking-widest mb-3 block" style={{ color: 'rgba(255,255,255,0.3)' }}>
                  Rareza
                </label>
                <div className="grid grid-cols-2 gap-2">
                  <OptionButton selected={isUltimate} onClick={() => setIsUltimate(true)}>
                    ✦ Ultimate Rare
                  </OptionButton>
                  <OptionButton selected={!isUltimate} onClick={() => setIsUltimate(false)}>
                    Normal
                  </OptionButton>
                </div>
              </div>

              {/* Language */}
              <div>
                <label className="text-xs font-semibold uppercase tracking-widest mb-3 block" style={{ color: 'rgba(255,255,255,0.3)' }}>
                  Idioma
                </label>
                <div className="grid grid-cols-3 gap-2">
                  {LANGUAGE_OPTIONS.map(opt => (
                    <OptionButton key={String(opt.value)} selected={language === opt.value} onClick={() => setLanguage(opt.value)}>
                      {opt.label}
                    </OptionButton>
                  ))}
                </div>
              </div>

              {/* Notes */}
              <div>
                <label className="text-xs font-semibold uppercase tracking-widest mb-3 block" style={{ color: 'rgba(255,255,255,0.3)' }}>
                  Notas
                </label>
                <textarea
                  value={notes}
                  onChange={e => setNotes(e.target.value)}
                  placeholder="Ej: comprada en feria, firmada, sin holo..."
                  rows={3}
                  className="w-full text-sm resize-none outline-none rounded-xl px-3.5 py-3 transition-all"
                  style={{
                    background: 'rgba(255,255,255,0.04)',
                    border: '1px solid rgba(255,255,255,0.08)',
                    color: 'rgba(255,255,255,0.8)',
                  }}
                  onFocus={e => (e.currentTarget.style.borderColor = 'rgba(232,166,19,0.3)')}
                  onBlur={e => (e.currentTarget.style.borderColor = 'rgba(255,255,255,0.08)')}
                />
              </div>
            </>
          )}

          {/* Save */}
          <button
            onClick={handleSave}
            disabled={updateCollection.isPending}
            className="w-full py-3 rounded-xl font-semibold text-sm transition-all disabled:opacity-50"
            style={saved
              ? { background: 'rgba(34,197,94,0.15)', color: '#4ade80', border: '1px solid rgba(34,197,94,0.2)' }
              : { background: 'linear-gradient(135deg,#f5c842,#e8a613)', color: '#080d1a', border: 'none' }
            }
          >
            {saved ? '✓ Guardado' : updateCollection.isPending ? 'Guardando...' : 'Guardar'}
          </button>
        </div>
      </main>

      <input ref={fileInputRef} type="file" accept="image/*" capture="environment" className="hidden" onChange={handleFileChange} />
    </div>
  )
}
