import { Link } from 'react-router-dom'
import { CardSet } from '../api/client'
import ProgressBar from './ProgressBar'

interface SetSelectorProps {
  sets: CardSet[]
  collectionId: number
}

// Cover card passcodes from YGOPRODeck for each set
const SET_COVER: Record<string, { passcode: number; name: string }> = {
  LOB: { passcode: 89631139, name: 'Blue-Eyes White Dragon' },
  MRD: { passcode: 11901678, name: 'Black Skull Dragon' },
  SRL: { passcode: 64631466, name: 'Relinquished' },
  PSV: { passcode: 63519819, name: 'Thousand-Eyes Restrict' },
  LON: { passcode: 29549364, name: 'Mask of Restrict' },
  LOD: { passcode: 28566710, name: 'Last Turn' },
  PGD: { passcode: 76052811, name: 'Helpoemer' },
  MFC: { passcode: 98502113, name: 'Dark Paladin' },
  DCR: { passcode: 12600382, name: 'Exodia Necross' },
  IOC: { passcode: 40737112, name: 'Dark Magician of Chaos' },
  AST: { passcode: 18378582, name: 'Archlord Zerato' },
  SOD: { passcode: 48229808, name: 'Horus the Black Flame Dragon LV8' },
  RDS: { passcode: 61505339, name: 'The Creator' },
  FET: { passcode: 61441708, name: 'Sacred Phoenix of Nephthys' },
  TLM: { passcode: 83104731, name: 'Ancient Gear Golem' },
}

export default function SetSelector({ sets, collectionId }: SetSelectorProps) {
  return (
    <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-3">
      {sets.map(set => {
        const complete = set.percentage === 100
        const cover = SET_COVER[set.code]
        const imgUrl = cover
          ? `https://images.ygoprodeck.com/images/cards_small/${cover.passcode}.jpg`
          : null

        return (
          <Link
            key={set.code}
            to={`/collections/${collectionId}/sets/${set.code}`}
            className="group relative flex overflow-hidden rounded-2xl transition-all duration-200 hover:-translate-y-0.5"
            style={{
              border: `1px solid ${complete ? 'rgba(232,166,19,0.3)' : 'rgba(255,255,255,0.06)'}`,
              boxShadow: complete ? '0 0 20px rgba(232,166,19,0.1)' : undefined,
              background: '#0d1425',
              minHeight: '100px',
            }}
          >
            {/* Left: set info */}
            <div className="relative flex-1 p-4 flex flex-col justify-between min-w-0 z-10">
              <div>
                <div className="flex items-center gap-2 mb-1.5">
                  <span className="text-xs font-bold font-mono text-gold-400 bg-gold-500/10 px-1.5 py-0.5 rounded-md">
                    {set.code}
                  </span>
                  {complete && <span className="text-gold-400 text-xs">✦</span>}
                </div>
                <h3 className="text-sm font-medium leading-tight text-white/80 group-hover:text-white transition-colors line-clamp-2">
                  {set.name}
                </h3>
              </div>
              <div className="mt-3">
                <div className="flex items-center justify-between mb-1.5">
                  <span className="text-xs tabular-nums"
                    style={{ color: complete ? '#e8a613' : 'rgba(255,255,255,0.3)' }}>
                    {set.ownedCards}/{set.totalCards}
                  </span>
                </div>
                <ProgressBar
                  owned={set.ownedCards}
                  total={set.totalCards}
                  percentage={set.percentage}
                  size="sm"
                />
              </div>
            </div>

            {/* Right: cover card image */}
            {imgUrl && (
              <div className="relative shrink-0 w-20 overflow-hidden">
                {/* gradient fade from left */}
                <div className="absolute inset-0 z-10"
                  style={{ background: 'linear-gradient(to right, #0d1425 0%, transparent 40%)' }} />
                <img
                  src={imgUrl}
                  alt={cover?.name}
                  className="h-full w-full object-cover object-top transition-transform duration-300 group-hover:scale-105"
                  style={{ opacity: 0.85 }}
                />
              </div>
            )}
          </Link>
        )
      })}
    </div>
  )
}
