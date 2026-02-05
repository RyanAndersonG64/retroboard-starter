# RetroBoard Starter (Next.js + FastAPI + Postgres + Redis)

This is a starter repo for a real-time collaborative board app.

**Stack**
- Web: Next.js (React) + TypeScript
- API: FastAPI (Python) + SQLAlchemy + Alembic
- DB: PostgreSQL (Docker)
- Cache/Queues: Redis (Docker)

## Prereqs (Windows)
- Docker Desktop
- Node.js (LTS) + pnpm (`npm i -g pnpm`)
- Python 3.11+ and Poetry (`pipx install poetry` recommended)
- VS Code / Cursor

## 1) Start Postgres + Redis
```powershell
docker compose up -d
```

## 2) API setup + run
```powershell
cd apps\api
```

### First time setup:
```
poetry install
copy .env.example .env
poetry run alembic upgrade head
```

### Run:
```
poetry run uvicorn app.main:app --reload --port 8000
```

Test:
- http://localhost:8000/health

## 3) Web setup + run
In a new terminal:

### First time setup:
```powershell
cd apps\web
pnpm install
copy .env.local.example .env.local
```

### Run:
```
pnpm dev
```

Open:
- http://localhost:3000

## 4) (Optional) One-command local dev
This will open two new terminals (one for API, one for Web) and start Docker:
```powershell
.\infra\scripts\dev.ps1
```

## Notes
- The web app calls the API `/health` endpoint.
- Alembic migrations live in `apps/api/app/db/migrations`.
- When you add models, generate a migration:
  ```powershell
  cd apps\api
  poetry run alembic revision --autogenerate -m "your message"
  poetry run alembic upgrade head
  ```

## Next recommended milestones
1. Auth (register/login) + workspaces
2. Boards/lists/cards CRUD
3. WebSockets for live updates
4. Activity log
5. Invites + notifications (Redis jobs)
