/** @type {import('tailwindcss').Config} */
export default {
  content: ['./index.html', './src/**/*.{js,ts,jsx,tsx}'],
  theme: {
    extend: {
      colors: {
        gold: {
          400: '#f5c842',
          500: '#c8a415',
          600: '#a88210',
        },
        dark: {
          900: '#0d0d1a',
          800: '#1a1a2e',
          700: '#16213e',
          600: '#0f3460',
        },
      },
    },
  },
  plugins: [],
}
