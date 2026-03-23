/** @type {import('tailwindcss').Config} */
export default {
  content: ['./index.html', './src/**/*.{js,ts,jsx,tsx}'],
  theme: {
    extend: {
      colors: {
        gold: {
          300: '#fcd97a',
          400: '#f5c842',
          500: '#e8a613',
          600: '#c8870a',
        },
        surface: {
          950: '#05080f',
          900: '#080d1a',
          800: '#0d1425',
          700: '#111c32',
          600: '#182340',
        },
        border: {
          subtle: 'rgba(255,255,255,0.06)',
          DEFAULT: 'rgba(255,255,255,0.10)',
          strong: 'rgba(255,255,255,0.18)',
        },
      },
      fontFamily: {
        sans: ['Inter', 'system-ui', '-apple-system', 'sans-serif'],
        mono: ['JetBrains Mono', 'Fira Code', 'monospace'],
      },
      backgroundImage: {
        'gold-gradient': 'linear-gradient(135deg, #f5c842, #e8a613)',
        'surface-gradient': 'linear-gradient(135deg, #111c32, #0d1425)',
      },
      boxShadow: {
        'gold-sm': '0 0 12px rgba(232,166,19,0.2)',
        'gold-md': '0 0 24px rgba(232,166,19,0.25)',
        'gold-lg': '0 0 40px rgba(232,166,19,0.3)',
        'card': '0 4px 24px rgba(0,0,0,0.4)',
        'card-hover': '0 8px 40px rgba(0,0,0,0.5)',
      },
      backdropBlur: {
        xs: '4px',
      },
    },
  },
  plugins: [],
}
