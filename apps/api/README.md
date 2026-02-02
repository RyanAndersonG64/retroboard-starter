# RetroBoard API

Run locally:
```powershell
poetry install
copy .env.example .env
poetry run alembic upgrade head
poetry run uvicorn app.main:app --reload --port 8000
```
