---
name: optimo-local-dev-setup
description: >-
  Provision a Windows 11 machine for Optimo Ventures local development — Docker Desktop,
  Supabase CLI (open-source local), Node.js, Git, GitHub CLI, Vercel CLI, VS Code, Scoop,
  and Claude Code. Covers WSL2 backend, PowerShell profile, Supabase local dev server,
  and the full Lovable → GitHub → Vercel pipeline from a local machine.
---

# Optimo Local Dev Setup — Windows 11 Machine Provisioning

You are a provisioning agent that sets up a Windows 11 machine to match the canonical
Optimo Ventures development environment. Your job is to install, configure, and verify every
tool in the stack so the machine can build locally, sync to Lovable and GitHub, and deploy
to Vercel — exactly as Joel's primary workstation operates.

## The target stack (canonical)

| Layer | Tool | Version (pinned) | Install Method |
|---|---|---|---|
| Package Manager | **Scoop** | 0.5.3+ | `iwr -useb get.scoop.sh \| iex` |
| Runtime | **Node.js** | 22 LTS | `winget install OpenJS.NodeJS.LTS` |
| Package Manager | **npm** | bundled | ships with Node |
| Package Manager | **pnpm** | latest | `npm i -g pnpm` |
| VCS | **Git** | 2.52+ | `winget install Git.Git` |
| VCS Hub | **GitHub CLI** | 2.94+ | `winget install GitHub.cli` |
| Container Runtime | **Docker Desktop** | 29+ | `winget install Docker.DockerDesktop` |
| WSL Backend | **WSL2** | kernel 5.15+ | `wsl --install` (Windows feature) |
| DB / Auth / Storage | **Supabase CLI** | 2.109+ | Scoop bucket: `scoop bucket add supabase https://github.com/supabase/scoop-supabase.git` then `scoop install supabase` |
| Deploy | **Vercel CLI** | 54+ | `npm i -g vercel` |
| Editor | **VS Code** | 1.127+ | `winget install Microsoft.VisualStudioCode` |
| AI Agent | **Claude Code** | 2.1+ | `npm i -g @anthropic-ai/claude-code` |
| Shell | **PowerShell 7** | 7.6+ | `winget install Microsoft.PowerShell` |
| Browser Automation | **Puppeteer** | 25+ | `npm i -g puppeteer` |

## Operating mode

- **DRY_RUN is the default.** In DRY_RUN you output the exact commands to run and explain
  what each does, but do not execute install steps. The user reviews and says "COMMIT" or
  "go ahead."
- **COMMIT requires explicit approval.** Once approved, execute each step sequentially,
  verifying success before proceeding to the next.
- **Idempotent.** Every step checks whether the tool is already installed before acting.
  If a tool is already present at an acceptable version, skip it and report the version.
- **Never uninstall or downgrade** an existing tool unless the user explicitly requests it.

## Phase 1 — Foundation (OS features + package manager)

### 1.1 Enable WSL2 (required for Docker Desktop)

WSL2 is a Windows feature. Docker Desktop uses it as its backend on Windows.

```powershell
# Check if WSL is already installed
wsl --status

# If not installed:
wsl --install
# This installs WSL2 + a default Ubuntu distribution. Reboot required.
```

After reboot, verify:
```powershell
wsl --status
# Should show: Default Distribution: Ubuntu, Default Version: 2
```

### 1.2 Install Scoop (Windows package manager)

Scoop is the canonical package manager for this stack. It installs per-user (no admin
required for most packages) and keeps tools in `~\scoop\`.

```powershell
# Check if already installed
scoop --version

# If not installed:
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force
iwr -useb get.scoop.sh | iex

# Add the Supabase bucket (needed later):
scoop bucket add supabase https://github.com/scoop-supabase.git
```

### 1.3 Install Git

```powershell
# Check
git --version

# Install (winget is preferred — it handles PATH):
winget install --id Git.Git -e --source winget
```

Configure Git identity (use the user's actual info):
```powershell
git config --global user.name "Joel Pembry"
git config --global user.email "joel@optimoventures.ai"
git config --global init.defaultBranch main
```

### 1.4 Install PowerShell 7

Windows ships with PowerShell 5.1; PowerShell 7 is the canonical shell.

```powershell
# Check
pwsh --version

# Install:
winget install --id Microsoft.PowerShell -e --source winget
```

## Phase 2 — Runtimes & Package Managers

### 2.1 Install Node.js 22 LTS

```powershell
# Check
node --version

# Install:
winget install --id OpenJS.NodeJS.LTS -e --source winget
```

After install, restart the terminal and verify:
```powershell
node --version  # expect v22.x
npm --version   # expect 10.x or 11.x
```

### 2.2 Install pnpm (optional but canonical)

```powershell
npm i -g pnpm
pnpm --version
```

## Phase 3 — Containerization & Local Supabase

### 3.1 Install Docker Desktop

Docker Desktop provides the Docker Engine that Supabase local dev uses.

```powershell
# Check
docker --version

# Install:
winget install --id Docker.DockerDesktop -e --source winglet
```

**Post-install:**
1. Launch Docker Desktop from the Start Menu.
2. Accept the license agreement.
3. Go to Settings → General and ensure "Use WSL 2 based engine" is checked.
4. Wait for the Docker engine to show "Engine running" (green dot in system tray).
5. Verify:
   ```powershell
   docker info
   docker run --rm hello-world
   ```

### 3.2 Install Supabase CLI

The Supabase CLI is installed via Scoop (not npm) on the canonical machine because
Scoop manages the binary and its dependencies cleanly on Windows.

```powershell
# Check
supabase --version

# Install (bucket must already be added — see Phase 1.2):
scoop install supabase
```

### 3.3 Start Supabase local development server

```powershell
# Navigate to a project directory (or create one):
mkdir ~/projects/my-project -Force
cd ~/projects/my-project

# Initialize Supabase:
supabase init

# Start the local stack (Postgres, Auth, Storage, Edge Functions, Realtime):
supabase start
```

This spins up Docker containers for:
- `supabase_db` — PostgreSQL 15
- `supabase_auth` — GoTrue auth server
- `supabase_storage` — S3-compatible storage
- `supabase_edge` — Deno edge functions
- `supabase_realtime` — WebSocket realtime server
- `supabase_rest` — PostgREST API
- `supabase_studio` — Supabase Studio UI (http://localhost:54323)
- `supabase_meta` — PostgreSQL meta
- `kong` — API gateway

Key local URLs:
| Service | URL |
|---|---|
| Studio | http://localhost:54323 |
| API | http://localhost:54321 |
| Inbucket (email) | http://localhost:54324 |
| Database | localhost:54322 |

To stop: `supabase stop`

## Phase 4 — Deploy & Source Control Tools

### 4.1 Install GitHub CLI

```powershell
# Check
gh --version

# Install:
winget install --id GitHub.cli -e --source winget
```

Authenticate:
```powershell
gh auth login
# Choose: GitHub.com → HTTPS → Login with a web browser
```

Verify:
```powershell
gh auth status
```

### 4.2 Install Vercel CLI

```powershell
# Check
vercel --version

# Install:
npm i -g vercel
```

Authenticate:
```powershell
vercel login
```

Link to an existing Vercel project:
```powershell
cd ~/projects/my-lovable-project
vercel link
```

### 4.3 Install Puppeteer (for HTML report generation, screenshots)

```powershell
npm i -g puppeteer
```

## Phase 5 — Editor & AI Agent

### 5.1 Install VS Code

```powershell
# Check
code --version

# Install:
winget install --id Microsoft.VisualStudioCode -e --source winglet
```

Recommended extensions (install via `code --install-extension`):
```powershell
code --install-extension bradlc.vscode-tailwindcss
code --install-extension github.copilot
code --install-extension github.copilot-chat
code --install-extension ms-vscode.vscode-typescript-next
code --install-extension denoland.vscode-deno
```

### 5.2 Install Claude Code

```powershell
# Check
claude --version

# Install:
npm i -g @anthropic-ai/claude-code
```

## Phase 6 — PowerShell Profile (Optimo Canonical)

The PowerShell profile at `$PROFILE` (typically
`~\Documents\PowerShell\Microsoft.PowerShell_profile.ps1`) should contain:

```powershell
# === Optimo Ventures — Canonical PowerShell Profile ===
# Provisioned by optimo-local-dev-setup skill
# Last updated: 2026-07-16

# — Scoop (if installed)
if (Test-Path "$env:USERPROFILE\scoop\shims") {
    $env:PATH = "$env:USERPROFILE\scoop\shims;$env:PATH"
}

# — Supabase CLI auto-complete
if (Get-Command supabase -ErrorAction SilentlyContinue) {
    supabase completion powershell | Out-String | Invoke-Expression
}

# — GitHub CLI auto-complete
if (Get-Command gh -ErrorAction SilentlyContinue) {
    gh completion -s powershell | Out-String | Invoke-Expression
}

# — Alias shortcuts
Set-Alias -Name sb -Value supabase -ErrorAction SilentlyContinue
Set-Alias -Name vc -Value vercel -ErrorAction SilentlyContinue

# — Prompt: show current git branch
function prompt {
    $branch = $(git rev-parse --abbrev-ref HEAD 2>$null)
    $path = Split-Path -Leaf (Get-Location)
    if ($branch) {
        "PS $path [$branch]> "
    } else {
        "PS $path> "
    }
}
```

> **Note:** The DeepSeek API redirect in Joel's personal profile is an OptimoStudio-specific
> configuration. Do NOT replicate this in a standard setup unless the user is also setting up
> an OptimoStudio development environment. The redirect is:
> ```powershell
> $env:ANTHROPIC_BASE_URL="https://api.deepseek.com/anthropic"
> $env:ANTHROPIC_AUTH_TOKEN="<token>"
> ```

## Phase 7 — Verification Checklist

Run this after all phases to confirm the machine is ready:

```powershell
@"
=== Optimo Local Dev Environment — Verification ===
PowerShell : $(pwsh --version)
Node.js    : $(node --version)
npm        : $(npm --version)
pnpm       : $(pnpm --version 2>$null || echo 'NOT INSTALLED')
Git        : $(git --version)
GitHub CLI : $(gh --version | Select-Object -First 1)
Docker     : $(docker --version)
Supabase   : $(supabase --version 2>$null || echo 'NOT INSTALLED')
Vercel     : $(vercel --version)
VS Code    : $(code --version | Select-Object -First 1)
Claude     : $(claude --version 2>$null || echo 'NOT INSTALLED')
Scoop      : $(scoop --version)
WSL        : $(wsl --status 2>$null | Select-Object -First 1)
"@
```

Expected output (versions approximate):
```
=== Optimo Local Dev Environment — Verification ===
PowerShell : PowerShell 7.6.3
Node.js    : v22.14.0
npm        : 11.16.0
pnpm       : 11.8.0
Git        : git version 2.52.0.windows.1
GitHub CLI : gh version 2.94.0
Docker     : Docker version 29.6.1
Supabase   : 2.109.1
Vercel     : 54.14.5
VS Code    : 1.127.0
Claude     : 2.1.211
Scoop      : Current Scoop version: 0.5.3
WSL        : Default Distribution: Ubuntu
```

## Phase 8 — Local ↔ Cloud Pipeline Integration

Once the local toolchain is verified, wire it to the Optimo cloud services:

### 8.1 Lovable (build)

Lovable is a cloud AI builder — code originates there and is pulled local via GitHub.
No local install needed; interact via the Lovable MCP connector or lovable.dev.

### 8.2 GitHub (source control)

Every Lovable project has a GitHub repo. Clone it locally:

```powershell
cd ~/projects
gh repo clone Optimo-Ventures-Incorporate/<repo-name>
```

Push changes from local back to GitHub:
```powershell
git add -A
git commit -m "Local change: <description>"
git push origin main
```

Lovable auto-syncs from the connected GitHub repo.

### 8.3 Vercel (deploy)

Vercel auto-deploys from GitHub on every push to the main branch. For manual deploys:

```powershell
cd ~/projects/<project>
vercel --prod
```

For preview deployments (per-branch):
```powershell
vercel
```

### 8.4 Supabase (cloud ↔ local)

For projects with a Supabase cloud backend, pull the remote schema:

```powershell
cd ~/projects/<project>
supabase link --project-ref <project-ref>
supabase db pull
```

Push local migrations to cloud:
```powershell
supabase db push
```

## Common workflows

### Start a new Lovable project from local

1. Create the project in Lovable (via MCP or lovable.dev).
2. Lovable auto-creates a GitHub repo.
3. Clone it locally: `gh repo clone Optimo-Ventures-Incorporate/<repo>`
4. If it uses Supabase, link: `supabase link --project-ref <ref>`
5. Develop locally, push to GitHub, Vercel auto-deploys.

### Develop locally with Supabase

1. `supabase start` — start local Postgres, Auth, Storage.
2. Build and test against `http://localhost:54321`.
3. When ready, push schema changes: `supabase db push`.
4. `supabase stop` when done.

### Full local → production pipeline

```
Local dev → git push → GitHub → Vercel (auto-deploy)
                ↓
         Lovable (syncs from GitHub, can also push to GitHub)
                ↓
         Supabase Cloud (via supabase db push from local)
```

## Resources

- `references/canonical-machine-state.md` — snapshot of Joel's actual machine configuration
- Scoop: https://scoop.sh
- Supabase CLI: https://supabase.com/docs/guides/local-development/cli/getting-started
- Docker Desktop: https://docs.docker.com/desktop/setup/install/windows-install/
- Vercel CLI: https://vercel.com/docs/cli
