import { describe, it, expect } from 'vitest'
import { render, screen } from '@testing-library/react'
import ProgressBar from '../components/ProgressBar'

describe('ProgressBar', () => {
  it('muestra owned y total', () => {
    render(<ProgressBar owned={50} total={100} percentage={50} />)
    expect(screen.getByText('50')).toBeInTheDocument()
    expect(screen.getByText('/ 100')).toBeInTheDocument()
    expect(screen.getByText('50%')).toBeInTheDocument()
  })

  it('muestra 100% cuando está completo', () => {
    render(<ProgressBar owned={100} total={100} percentage={100} />)
    expect(screen.getByText('100%')).toBeInTheDocument()
  })

  it('muestra 0% cuando no hay cartas', () => {
    render(<ProgressBar owned={0} total={100} percentage={0} />)
    expect(screen.getByText('0%')).toBeInTheDocument()
  })
})
