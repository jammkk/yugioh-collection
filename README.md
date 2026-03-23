# GOAT Collection Tracker

Yu-Gi-Oh! GOAT format collection tracker (LOB to TLM).

## Quick Start

### 1. Start database
```bash
docker compose up -d
```

### 2. Backend setup
```bash
cd backend
npm install
npm run migrate
npm run seed -- ./data/Checklist_Maestro_YuGiOh_LOB_TLM.xlsx
npm run dev
```

### 3. Frontend setup (separate terminal)
```bash
cd frontend
npm install
npm run dev
```

Open http://localhost:5173
