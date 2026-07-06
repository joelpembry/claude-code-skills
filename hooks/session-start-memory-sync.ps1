#!/usr/bin/env pwsh
# SessionStart Hook — Shared Memory Sync
# Pulls latest shared memory from GitHub repo and loads into session context.
# Installed by: Optimo Ventures Skills Installer

param(
    [string]$ProjectPath = $env:CLAUDE_PROJECT_PATH
)

$REPO = "C:\Users\joelp\Projects\OptimoVentures\claude-code-skills"

# ── Sync latest shared memory ──────────────────────────────────────────

Write-Host "[Optimo] Syncing shared memory..." -ForegroundColor Cyan

try {
    Push-Location $REPO
    $before = git rev-parse HEAD
    git pull --quiet 2>&1 | Out-Null
    $after = git rev-parse HEAD

    if ($before -ne $after) {
        Write-Host "[Optimo] Shared memory updated!" -ForegroundColor Green
        $changes = git diff --name-only $before $after -- memory/
        foreach ($c in $changes) {
            Write-Host "  Updated: $c" -ForegroundColor DarkGreen
        }
    } else {
        Write-Host "[Optimo] Shared memory is current." -ForegroundColor DarkGray
    }
    Pop-Location
} catch {
    Write-Host "[Optimo] Warning: Could not sync shared memory. Using cached version." -ForegroundColor DarkYellow
    if (Test-Path $REPO) {
        Pop-Location -ErrorAction SilentlyContinue
    }
}

# ── Load shared memory into context ─────────────────────────────────────

if ($ProjectPath) {
    $venture = Split-Path -Leaf $ProjectPath
    $sharedMemoryFile = "$REPO\memory\$venture\shared-memory.json"

    if (Test-Path $sharedMemoryFile) {
        $memory = Get-Content $sharedMemoryFile -Raw | ConvertFrom-Json
        Write-Host "[Optimo] Loaded shared memory for: $venture" -ForegroundColor Cyan
        Write-Host "  Build State: $($memory.buildState.currentSprint)" -ForegroundColor DarkGray
        Write-Host "  Active Tickets: $($memory.buildState.activeJiraTickets -join ', ')" -ForegroundColor DarkGray

        # Emit as structured data for Claude to pick up
        Write-Output $memory | ConvertTo-Json -Compress
    }
}
