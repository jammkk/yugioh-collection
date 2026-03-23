import { Card } from '../api/client'
import CardCard from './CardCard'

interface CardGridProps {
  cards: Card[]
  setCode: string
  onUpdateCollection: (data: { cardId: number; owned: boolean; edition: number | null; condition: number | null; isUltimate: boolean }) => void
  onUploadPhoto?: (cardId: number, file: File) => void
  onDeletePhoto?: (cardId: number, photoId: number) => void
}

export default function CardGrid({ cards, setCode, onUpdateCollection, onUploadPhoto, onDeletePhoto }: CardGridProps) {
  if (cards.length === 0) {
    return (
      <div className="text-center py-16 text-gray-500">
        No se encontraron cartas
      </div>
    )
  }

  return (
    <div className="grid grid-cols-2 sm:grid-cols-3 md:grid-cols-4 lg:grid-cols-5 xl:grid-cols-6 gap-3">
      {cards.map(card => (
        <CardCard
          key={card.id}
          card={card}
          setCode={setCode}
          onUpdateCollection={onUpdateCollection}
          onUploadPhoto={onUploadPhoto}
          onDeletePhoto={onDeletePhoto}
        />
      ))}
    </div>
  )
}
