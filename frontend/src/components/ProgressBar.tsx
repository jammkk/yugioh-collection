interface ProgressBarProps {
  owned: number
  total: number
  percentage: number
  className?: string
  size?: 'sm' | 'md'
}

export default function ProgressBar({ owned, total, percentage, className = '', size = 'md' }: ProgressBarProps) {
  const h = size === 'sm' ? 'h-1' : 'h-1.5'
  const complete = percentage === 100

  return (
    <div className={className}>
      <div className="flex justify-between items-baseline mb-1.5">
        <span className="text-xs tabular-nums" style={{ color: 'rgba(255,255,255,0.35)' }}>
          {owned} <span style={{ color: 'rgba(255,255,255,0.2)' }}>/ {total}</span>
        </span>
        <span className={`text-xs font-semibold tabular-nums ${complete ? 'text-gold-400' : ''}`}
          style={complete ? undefined : { color: 'rgba(255,255,255,0.5)' }}>
          {percentage}%
        </span>
      </div>
      <div className={`${h} rounded-full overflow-hidden`} style={{ background: 'rgba(255,255,255,0.05)' }}>
        <div
          className="h-full rounded-full transition-all duration-700"
          style={{
            width: `${percentage}%`,
            background: complete
              ? 'linear-gradient(90deg, #fcd97a, #e8a613)'
              : 'linear-gradient(90deg, #e8a613, #c8870a)',
          }}
        />
      </div>
    </div>
  )
}
