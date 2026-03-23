import { Link } from 'react-router-dom'
import { CardSet } from '../api/client'
import ProgressBar from './ProgressBar'

interface SetSelectorProps {
  sets: CardSet[]
}

export default function SetSelector({ sets }: SetSelectorProps) {
  return (
    <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-4">
      {sets.map(set => (
        <Link
          key={set.code}
          to={`/sets/${set.code}`}
          className={`
            block bg-dark-700 rounded-xl p-4 border-2 transition-all duration-200
            hover:scale-105 hover:shadow-lg hover:shadow-gold-500/20
            ${set.percentage === 100
              ? 'border-gold-500 shadow-gold-500/30 shadow-md'
              : 'border-dark-600 hover:border-gold-500/50'
            }
          `}
        >
          <div className="flex justify-between items-start mb-3">
            <div>
              <span className="text-gold-500 font-bold text-sm">{set.code}</span>
              <h3 className="text-gray-200 font-medium text-sm leading-tight mt-0.5">{set.name}</h3>
            </div>
            {set.percentage === 100 && (
              <span className="text-gold-400 text-lg">&#10022;</span>
            )}
          </div>
          <ProgressBar owned={set.ownedCards} total={set.totalCards} percentage={set.percentage} />
        </Link>
      ))}
    </div>
  )
}
