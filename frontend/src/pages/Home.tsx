import { useStats } from '../hooks/useCards'
import SetSelector from '../components/SetSelector'
import ProgressBar from '../components/ProgressBar'

export default function Home() {
  const { data: stats, isLoading, error } = useStats()

  if (isLoading) {
    return (
      <div className="min-h-screen bg-dark-800 flex items-center justify-center">
        <div className="text-gold-500 text-xl animate-pulse">Cargando colección...</div>
      </div>
    )
  }

  if (error) {
    return (
      <div className="min-h-screen bg-dark-800 flex items-center justify-center">
        <div className="text-red-400 text-center">
          <div className="text-4xl mb-4">&#9888;</div>
          <div>Error conectando al servidor</div>
          <div className="text-sm text-gray-500 mt-2">Asegúrate de que el backend esté corriendo en puerto 3000</div>
        </div>
      </div>
    )
  }

  return (
    <div className="min-h-screen bg-dark-800">
      {/* Header */}
      <header className="bg-dark-900 border-b border-dark-600 sticky top-0 z-10">
        <div className="max-w-7xl mx-auto px-4 py-4">
          <div className="flex flex-col sm:flex-row sm:items-center sm:justify-between gap-3">
            <div>
              <h1 className="text-2xl font-bold text-gold-500">GOAT Collection Tracker</h1>
              <p className="text-gray-400 text-sm">Yu-Gi-Oh! Formato GOAT — LOB a TLM</p>
            </div>
            {stats && (
              <div className="sm:min-w-[280px]">
                <ProgressBar
                  owned={stats.owned_cards}
                  total={stats.total_cards}
                  percentage={stats.percentage}
                />
              </div>
            )}
          </div>
        </div>
      </header>

      {/* Main */}
      <main className="max-w-7xl mx-auto px-4 py-8">
        <h2 className="text-lg font-semibold text-gray-300 mb-6">
          Sets ({stats?.sets?.length ?? 0})
        </h2>
        {stats?.sets && <SetSelector sets={stats.sets} />}
      </main>
    </div>
  )
}
