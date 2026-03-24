import { Link } from 'react-router-dom'
import { CardSet } from '../api/client'
import ProgressBar from './ProgressBar'

interface SetSelectorProps {
  sets: CardSet[]
}

// Cover card passcodes from YGOPRODeck for each set
const SET_COVER: Record<string, { passcode: number; name: string }> = {
  LOB: { passcode: 89631139, name: 'Blue-Eyes White Dragon' },
  MRD: { passcode: 11901678, name: 'Black Skull Dragon' },
  SRL: { passcode: 63519819, name: 'Thousand-Eyes Restrict' },
  PSV: { passcode: 77585513, name: 'Jinzo' },
  LON: { passcode: 31829185, name: 'Dark Necrofear' },
  LOD: { passcode: 71570244, name: 'Dark Ruler Ha Des' },
  PGD: { passcode: 46986414, name: 'Mystical Knight of Jackal' },
  MFC: { passcode: 38033121, name: 'Dark Magician Girl' },
  DCR: { passcode: 56307359, name: 'Invader of Darkness' },
  IOC: { passcode: 99518961, name: 'Chaos Emperor Dragon' },
  AST: { passcode: 68007326, name: 'Guardian Angel Joan' },
  SOD: { passcode: 47569030, name: 'Horus the Black Flame Dragon LV8' },
  RDS: { passcode: 59793705, name: 'Elemental HERO Bladedge' },
  FET: { passcode: 35809262, name: 'Elemental HERO Flame Wingman' },
  TLM: { passcode: 83104731, name: 'Ancient Gear Golem' },
}

export default function SetSelector({ sets }: SetSelectorProps) {
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
            to={`/sets/${set.code}`}
            className="group relative block rounded-2xl overflow-hidden transition-all duration-200 hover:-translate-y-0.5"
            style={{
              border: `1px solid ${complete ? 'rgba(232,166,19,0.3)' : 'rgba(255,255,255,0.06)'}`,
              boxShadow: complete ? '0 0 20px rgba(232,166,19,0.1)' : undefined,
              background: '#0d1425',
            }}
          >
            {/* Cover card image (right side, faded) */}
            {imgUrl && (
              <div className="absolute inset-0 flex justify-end overflow-hidden rounded-2xl">
                <img
                  src={imgUrl}
                  alt={cover?.name}
                  className="h-full w-auto object-cover opacity-20 group-hover:opacity-30 transition-opacity duration-300"
                  style={{ maskImage: 'linear-gradient(to left, rgba(0,0,0,0.8) 0%, transparent 70%)', WebkitMaskImage: 'linear-gradient(to left, rgba(0,0,0,0.8) 0%, transparent 70%)' }}
                />
              </div>
            )}

            {/* Gradient overlay to ensure text readability */}
            <div className="absolute inset-0 rounded-2xl"
              style={{ background: 'linear-gradient(to right, #0d1425 55%, transparent 100%)' }} />

            {/* Content */}
            <div className="relative p-4">
              <div className="flex items-start justify-between mb-3">
                <div className="min-w-0 flex-1">
                  <div className="flex items-center gap-2 mb-1.5">
                    <span className="text-xs font-bold font-mono text-gold-400 bg-gold-500/10 px-1.5 py-0.5 rounded-md">
                      {set.code}
                    </span>
                    {complete && <span className="text-gold-400 text-xs">✦</span>}
                  </div>
                  <h3 className="text-sm font-medium leading-tight text-white/80 group-hover:text-white transition-colors line-clamp-2 pr-8">
                    {set.name}
                  </h3>
                </div>
                <span className="text-xs font-bold shrink-0 ml-2 tabular-nums"
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
          </Link>
        )
      })}
    </div>
  )
}
