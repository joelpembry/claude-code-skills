# Optimo Ventures — Claude Code Skills Auto-Installer (Windows)
# Installs corporate skills library and shared memory hooks into Claude Code
# Run: .\install.ps1

param(
    [switch]$Force,           # Overwrite local overrides
    [switch]$SkipAutoSync,    # Don't create daily sync task
    [switch]$DryRun           # Show what would happen without making changes
)

$ErrorActionPreference = "Stop"
$REPO_ROOT = Split-Path -Parent $MyInvocation.MyCommand.Path
$CLAUDE_HOME = "$env:USERPROFILE\.claude"
$SKILLS_DIR = "$CLAUDE_HOME\skills"
$HOOKS_DIR = "$CLAUDE_HOME\hooks"
$MEMORY_DIR = "$CLAUDE_HOME\projects"

Write-Host @"
========================================
 Optimo Ventures — Skills Installer
========================================
 Repo:     $REPO_ROOT
 Target:   $CLAUDE_HOME
 Mode:     $(if ($DryRun) { "DRY RUN" } else { "LIVE" })
========================================
"@ -ForegroundColor Cyan

# ── Step 1: Install Skills ─────────────────────────────────────────────

Write-Host "`n[1/5] Installing skills..." -ForegroundColor Yellow

$skills = Get-ChildItem "$REPO_ROOT\skills" -Directory
foreach ($skill in $skills) {
    $src = $skill.FullName
    $dst = "$SKILLS_DIR\$($skill.Name)"

    if ($DryRun) {
        Write-Host "  Would install: $($skill.Name) → $dst"
        continue
    }

    if (Test-Path $dst) {
        if ($Force) {
            Remove-Item -Recurse -Force $dst
            Write-Host "  Overwriting: $($skill.Name)" -ForegroundColor Magenta
        } else {
            Write-Host "  Already installed: $($skill.Name) (use -Force to overwrite)" -ForegroundColor DarkYellow
            continue
        }
    }

    # Use symlink if possible, copy if not
    try {
        New-Item -ItemType SymbolicLink -Path $dst -Target $src -Force | Out-Null
        Write-Host "  Symlinked: $($skill.Name)" -ForegroundColor Green
    } catch {
        Copy-Item -Recurse -Force $src $dst
        Write-Host "  Copied: $($skill.Name) (admin rights needed for symlink)" -ForegroundColor Green
    }
}

# ── Step 2: Install Hooks ──────────────────────────────────────────────

Write-Host "`n[2/5] Installing shared memory hooks..." -ForegroundColor Yellow

$hooks = Get-ChildItem "$REPO_ROOT\hooks" -File
foreach ($hook in $hooks) {
    $dst = "$HOOKS_DIR\$($hook.Name)"

    if ($DryRun) {
        Write-Host "  Would install hook: $($hook.Name)"
        continue
    }

    if (-not (Test-Path $HOOKS_DIR)) {
        New-Item -ItemType Directory -Path $HOOKS_DIR -Force | Out-Null
    }

    Copy-Item -Force $hook.FullName $dst
    Write-Host "  Installed hook: $($hook.Name)" -ForegroundColor Green
}

# ── Step 3: Seed Shared Memory ─────────────────────────────────────────

Write-Host "`n[3/5] Seeding shared memory..." -ForegroundColor Yellow

$memorySrc = "$REPO_ROOT\memory"
$ventures = Get-ChildItem $memorySrc -Directory
foreach ($venture in $ventures) {
    $dst = "$MEMORY_DIR\$($venture.Name)\memory"

    if ($DryRun) {
        Write-Host "  Would seed: $($venture.Name)"
        continue
    }

    if (-not (Test-Path $dst)) {
        New-Item -ItemType Directory -Path $dst -Force | Out-Null
    }

    $sharedFile = "$venture\shared-memory.json"
    if (Test-Path $sharedFile) {
        Copy-Item -Force $sharedFile $dst\
        Write-Host "  Seeded: $($venture.Name)/shared-memory.json" -ForegroundColor Green
    }
}

# ── Step 4: Configure Claude Code Settings ─────────────────────────────

Write-Host "`n[4/5] Configuring Claude Code settings..." -ForegroundColor Yellow

$settingsFile = "$CLAUDE_HOME\settings.json"
$settings = @{}
if (Test-Path $settingsFile) {
    $settings = Get-Content $settingsFile | ConvertFrom-Json -AsHashtable
}

# Add shared memory hooks to settings if not already present
$needsUpdate = $false
if (-not $settings.ContainsKey("hooks")) {
    $settings["hooks"] = @{
        "SessionStart" = @()
        "SessionStop" = @()
    }
    $needsUpdate = $true
}

$startHooks = [System.Collections.ArrayList]($settings["hooks"]["SessionStart"] ?? @())
$stopHooks = [System.Collections.ArrayList]($settings["hooks"]["SessionStop"] ?? @())

$startScript = "$HOOKS_DIR\session-start-memory-sync.ps1"
$stopScript = "$HOOKS_DIR\session-stop-memory-sync.ps1"

if ($startHooks -notcontains $startScript) {
    $startHooks.Add($startScript) | Out-Null
    $needsUpdate = $true
}
if ($stopHooks -notcontains $stopScript) {
    $stopHooks.Add($stopScript) | Out-Null
    $needsUpdate = $true
}

$settings["hooks"]["SessionStart"] = $startHooks
$settings["hooks"]["SessionStop"] = $stopHooks

if ($needsUpdate -and -not $DryRun) {
    $settings | ConvertTo-Json -Depth 5 | Set-Content $settingsFile
    Write-Host "  Updated: settings.json with shared memory hooks" -ForegroundColor Green
} else {
    Write-Host "  Settings already configured" -ForegroundColor DarkYellow
}

# ── Step 5: Daily Auto-Sync ────────────────────────────────────────────

Write-Host "`n[5/5] Configuring daily auto-sync..." -ForegroundColor Yellow

$taskName = "OptimoSkillsSync"
$existingTask = Get-ScheduledTask -TaskName $taskName -ErrorAction SilentlyContinue

if ($SkipAutoSync) {
    Write-Host "  Skipped (--SkipAutoSync)" -ForegroundColor DarkYellow
} elseif ($existingTask -and -not $Force) {
    Write-Host "  Task already exists: $taskName (use -Force to recreate)" -ForegroundColor DarkYellow
} elseif (-not $DryRun) {
    $action = New-ScheduledTaskAction -Execute "git" -WorkingDirectory $REPO_ROOT -Argument "pull"
    $trigger = New-ScheduledTaskTrigger -Daily -At "09:00"
    $principal = New-ScheduledTaskPrincipal -UserId $env:USERNAME -LogonType Interactive -RunLevel Limited
    Register-ScheduledTask -TaskName $taskName -Action $action -Trigger $trigger -Principal $principal -Description "Daily sync of Optimo Ventures Claude Code skills" -Force | Out-Null
    Write-Host "  Created daily sync task: 09:00 each day" -ForegroundColor Green
}

# ── Summary ────────────────────────────────────────────────────────────

Write-Host @"

========================================
 Installation Complete
========================================
 Skills:    $($skills.Count) installed
 Hooks:     $(@(Get-ChildItem "$REPO_ROOT\hooks" -File).Count) installed
 Memory:    $($ventures.Count) ventures seeded
 Auto-sync: $(if ($SkipAutoSync) { "disabled" } else { "daily at 09:00" })
========================================

Next steps:
 1. Restart Claude Code to load new skills
 2. Run /optimo-ventures to verify installation
 3. Shared memory syncs on session start

To update later: git pull
To uninstall:   Remove-Item -Recurse $CLAUDE_HOME\skills\optimo-* -Force
"@ -ForegroundColor Cyan
