interface ProgressBarProps {
  owned: number
  total: number
  percentage: number
  className?: string
}

export default function ProgressBar({ owned, total, percentage, className = '' }: ProgressBarProps) {
  return (
    <div className={className}>
      <div className="flex justify-between text-xs text-gray-400 mb-1">
        <span>{owned} / {total}</span>
        <span>{percentage}%</span>
      </div>
      <div className="h-2 bg-dark-900 rounded-full overflow-hidden">
        <div
          className="h-full bg-gold-500 rounded-full transition-all duration-500"
          style={{ width: `${percentage}%` }}
        />
      </div>
    </div>
  )
}
