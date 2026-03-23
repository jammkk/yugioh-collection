import { Link } from 'react-router-dom'
import { CardSet } from '../api/client'
import ProgressBar from './ProgressBar'

interface SetSelectorProps {
  sets: CardSet[]
}

export default function SetSelector({ sets }: SetSelectorProps) {
  return (
    <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-3">
      {sets.map(set => {
        const complete = set.percentage === 100
        return (
          <Link
            key={set.code}
            to={`/sets/${set.code}`}
            className="group block rounded-2xl p-4 transition-all duration-200 hover:-translate-y-0.5"
            style={{
              background: complete
                ? 'linear-gradient(135deg, rgba(232,166,19,0.12), rgba(17,28,50,0.9))'
                : 'rgba(17,28,50,0.6)',
              border: `1px solid ${complete ? 'rgba(232,166,19,0.3)' : 'rgba(255,255,255,0.06)'}`,
              boxShadow: complete ? '0 0 20px rgba(232,166,19,0.1)' : undefined,
            }}
            onMouseEnter={e => {
              if (!complete) (e.currentTarget as HTMLElement).style.borderColor = 'rgba(255,255,255,0.12)'
            }}
            onMouseLeave={e => {
              if (!complete) (e.currentTarget as HTMLElement).style.borderColor = 'rgba(255,255,255,0.06)'
            }}
          >
            <div className="flex items-start justify-between mb-3">
              <div className="min-w-0">
                <div className="flex items-center gap-2 mb-1">
                  <span className="text-xs font-bold font-mono text-gold-400 bg-gold-500/10 px-1.5 py-0.5 rounded-md">
                    {set.code}
                  </span>
                  {complete && <span className="text-gold-400 text-xs">✦</span>}
                </div>
                <h3 className="text-sm font-medium leading-tight text-white/80 group-hover:text-white transition-colors line-clamp-2">
                  {set.name}
                </h3>
              </div>
              <span className="text-xs font-bold ml-2 shrink-0" style={{ color: complete ? '#e8a613' : 'rgba(255,255,255,0.3)' }}>
                {set.ownedCards}/{set.totalCards}
              </span>
            </div>
            <ProgressBar
              owned={set.ownedCards}
              total={set.totalCards}
              percentage={set.percentage}
              size="sm"
            />
          </Link>
        )
      })}
    </div>
  )
}
