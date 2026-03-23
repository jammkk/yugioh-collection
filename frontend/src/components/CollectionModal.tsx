import { useState, useEffect } from 'react'
import { Card } from '../api/client'

interface CollectionModalProps {
  card: Card
  onSave: (data: { owned: boolean; edition: number | null; condition: number | null; isUltimate: boolean }) => void
  onClose: () => void
}

export default function CollectionModal({ card, onSave, onClose }: CollectionModalProps) {
  const [edition, setEdition] = useState<number | null>(card.edition)
  const [condition, setCondition] = useState<number | null>(card.condition)
  const [isUltimate, setIsUltimate] = useState(card.isUltimate)

  // Close on Escape
  useEffect(() => {
    const handler = (e: KeyboardEvent) => { if (e.key === 'Escape') onClose() }
    window.addEventListener('keydown', handler)
    return () => window.removeEventListener('keydown', handler)
  }, [onClose])

  const handleSave = () => {
    onSave({ owned: true, edition, condition, isUltimate })
    onClose()
  }

  const handleUnmark = () => {
    onSave({ owned: false, edition: null, condition: null, isUltimate: false })
    onClose()
  }

  return (
    <div
      className="fixed inset-0 z-50 flex items-center justify-center p-4 bg-black/70"
      onClick={onClose}
    >
      <div
        className="bg-dark-700 border border-dark-600 rounded-2xl w-full max-w-sm shadow-2xl"
        onClick={e => e.stopPropagation()}
      >
        {/* Header */}
        <div className="p-4 border-b border-dark-600">
          <div className="text-xs text-gold-500 font-mono">{card.cardCode}</div>
          <div className="text-sm font-semibold text-gray-100 mt-0.5 leading-tight">{card.name}</div>
        </div>

        {/* Form */}
        <div className="p-4 space-y-4">

          {/* Edition */}
          <div>
            <label className="text-xs text-gray-400 uppercase tracking-wide mb-2 block">Edición</label>
            <div className="grid grid-cols-3 gap-2">
              {[
                { value: 1, label: '1ra Edición' },
                { value: 2, label: 'Ilimitada' },
                { value: null, label: 'No sé' },
              ].map(opt => (
                <button
                  key={String(opt.value)}
                  onClick={() => setEdition(opt.value)}
                  className={`
                    py-2 px-1 rounded-lg text-xs font-medium transition-all border
                    ${edition === opt.value
                      ? 'bg-gold-500 text-dark-900 border-gold-500'
                      : 'bg-dark-800 text-gray-400 border-dark-600 hover:border-gold-500/50 hover:text-gray-200'
                    }
                  `}
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
              {[
                { value: 1, label: 'NM / LP', desc: 'Bien' },
                { value: 2, label: 'MP / HP', desc: 'Usado' },
                { value: null, label: 'No sé', desc: '' },
              ].map(opt => (
                <button
                  key={String(opt.value)}
                  onClick={() => setCondition(opt.value)}
                  className={`
                    py-2 px-1 rounded-lg text-xs font-medium transition-all border
                    ${condition === opt.value
                      ? 'bg-gold-500 text-dark-900 border-gold-500'
                      : 'bg-dark-800 text-gray-400 border-dark-600 hover:border-gold-500/50 hover:text-gray-200'
                    }
                  `}
                >
                  <div>{opt.label}</div>
                  {opt.desc && <div className="text-xs opacity-70">{opt.desc}</div>}
                </button>
              ))}
            </div>
          </div>

          {/* Ultimate */}
          <div>
            <label className="text-xs text-gray-400 uppercase tracking-wide mb-2 block">Ultimate Rare</label>
            <div className="grid grid-cols-2 gap-2">
              {[
                { value: true, label: '✦ Ultimate' },
                { value: false, label: 'Normal' },
              ].map(opt => (
                <button
                  key={String(opt.value)}
                  onClick={() => setIsUltimate(opt.value)}
                  className={`
                    py-2 rounded-lg text-xs font-medium transition-all border
                    ${isUltimate === opt.value
                      ? 'bg-gold-500 text-dark-900 border-gold-500'
                      : 'bg-dark-800 text-gray-400 border-dark-600 hover:border-gold-500/50 hover:text-gray-200'
                    }
                  `}
                >
                  {opt.label}
                </button>
              ))}
            </div>
          </div>
        </div>

        {/* Actions */}
        <div className="p-4 pt-0 flex gap-2">
          <button
            onClick={handleSave}
            className="flex-1 bg-gold-500 hover:bg-gold-400 text-dark-900 font-semibold py-2.5 rounded-xl text-sm transition-all"
          >
            {card.owned ? 'Guardar cambios' : '✓ Tengo esta carta'}
          </button>
          {card.owned && (
            <button
              onClick={handleUnmark}
              className="bg-dark-800 hover:bg-red-900/40 border border-dark-600 hover:border-red-500/50 text-gray-400 hover:text-red-400 py-2.5 px-3 rounded-xl text-sm transition-all"
              title="Quitar de mi colección"
            >
              ✕
            </button>
          )}
        </div>
      </div>
    </div>
  )
}
