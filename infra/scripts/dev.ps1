\
# RetroBoard local dev helper (Windows PowerShell)
# - Starts Docker services
# - Opens two new terminals: API + Web

$ErrorActionPreference = "Stop"

Write-Host "Starting Postgres + Redis..." -ForegroundColor Cyan
docker compose up -d

$root = Resolve-Path "$PSScriptRoot\..\.."

# API terminal command
$apiCmd = @"
cd "$root\apps\api"
if (!(Test-Path .env)) { Copy-Item .env.example .env }
poetry install
poetry run alembic upgrade head
poetry run uvicorn app.main:app --reload --port 8000
"@

# Web terminal command
$webCmd = @"
cd "$root\apps\web"
if (!(Test-Path .env.local)) { Copy-Item .env.local.example .env.local }
pnpm install
pnpm dev
"@

Write-Host "Launching API terminal..." -ForegroundColor Cyan
Start-Process powershell -ArgumentList "-NoExit", "-Command", $apiCmd

Write-Host "Launching Web terminal..." -ForegroundColor Cyan
Start-Process powershell -ArgumentList "-NoExit", "-Command", $webCmd

Write-Host "Done. Web: http://localhost:3000  API: http://localhost:8000" -ForegroundColor Green
