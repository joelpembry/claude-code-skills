#!/usr/bin/env pwsh
# SessionStop Hook — Shared Memory Persistence
# Prompts to commit session changes to shared memory and push to GitHub.
# Installed by: Optimo Ventures Skills Installer

param(
    [string]$ProjectPath = $env:CLAUDE_PROJECT_PATH
)

$REPO = "C:\Users\joelp\Projects\OptimoVentures\claude-code-skills"

Write-Host "[Optimo] Session ending — check shared memory..." -ForegroundColor Cyan

if (-not $ProjectPath) {
    Write-Host "[Optimo] No project path detected. Skipping memory persistence." -ForegroundColor DarkGray
    exit 0
}

$venture = Split-Path -Leaf $ProjectPath
$sharedMemoryFile = "$REPO\memory\$venture\shared-memory.json"

if (-not (Test-Path $sharedMemoryFile)) {
    Write-Host "[Optimo] No shared memory file for: $venture" -ForegroundColor DarkGray
    exit 0
}

# ── Check for local changes to propose ─────────────────────────────────

try {
    Push-Location $REPO

    # Check if shared memory was modified this session
    $modified = git diff --name-only HEAD -- "memory/$venture/"
    if ($modified) {
        Write-Host "[Optimo] Shared memory has changes for: $venture" -ForegroundColor Yellow
        Write-Host "  Modified files:" -ForegroundColor Yellow
        foreach ($m in $modified) {
            Write-Host "    $m" -ForegroundColor DarkYellow
        }
        Write-Host ""
        Write-Host "  To commit and share with the team, run:" -ForegroundColor Cyan
        Write-Host "    cd $REPO" -ForegroundColor White
        Write-Host "    git add memory/$venture/" -ForegroundColor White
        Write-Host '    git commit -m "Update shared memory for ' -ForegroundColor White -NoNewline
        Write-Host "$venture" -ForegroundColor White -NoNewline
        Write-Host '"' -ForegroundColor White
        Write-Host "    git push" -ForegroundColor White
    } else {
        Write-Host "[Optimo] No shared memory changes to persist." -ForegroundColor DarkGray
    }

    Pop-Location
} catch {
    Write-Host "[Optimo] Warning: Could not check memory status." -ForegroundColor DarkYellow
    Pop-Location -ErrorAction SilentlyContinue
}
