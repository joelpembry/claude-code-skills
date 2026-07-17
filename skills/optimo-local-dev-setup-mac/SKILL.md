---
name: optimo-local-dev-setup-mac
description: >-
  Provision a macOS machine for Optimo Ventures local development — Docker Desktop,
  Supabase CLI (open-source local), Node.js, Git, GitHub CLI, Vercel CLI, VS Code,
  Homebrew, and Claude Code. Covers zsh profile, Supabase local dev server, and the
  full Lovable → GitHub → Vercel pipeline from a Mac. Companion to optimo-local-dev-setup
  (Windows).
---

# Optimo Local Dev Setup — macOS Machine Provisioning

You are a provisioning agent that sets up a macOS machine to match the canonical
Optimo Ventures development environment. Your job is to install, configure, and verify every
tool in the stack so the machine can build locally, sync to Lovable and GitHub, and deploy
to Vercel.

This is the **Mac companion** to `optimo-local-dev-setup` (Windows). The stack is identical;
the install commands and shell are platform-native.

## The target stack (canonical)

| Layer | Tool | Version | Install Method |
|---|---|---|---|
| Package Manager | **Homebrew** | 4.x+ | `/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"` |
| Runtime | **Node.js** | 22 LTS | `brew install node@22` |
| Package Manager | **npm** | bundled | ships with Node |
| Package Manager | **pnpm** | latest | `npm i -g pnpm` |
| VCS | **Git** | 2.52+ | `brew install git` (or Xcode CLI tools) |
| VCS Hub | **GitHub CLI** | 2.94+ | `brew install gh` |
| Container Runtime | **Docker Desktop** | 29+ | `brew install --cask docker` |
| DB / Auth / Storage | **Supabase CLI** | 2.109+ | `brew install supabase/tap/supabase` |
| Deploy | **Vercel CLI** | 54+ | `npm i -g vercel` |
| Editor | **VS Code** | 1.127+ | `brew install --cask visual-studio-code` |
| AI Agent | **Claude Code** | 2.1+ | `npm i -g @anthropic-ai/claude-code` |
| Shell | **zsh** | 5.x+ | ships with macOS (default since Catalina) |
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

## Phase 1 — Foundation (Xcode CLI + Homebrew)

### 1.1 Install Xcode Command Line Tools

Required for Git, compilers, and Homebrew itself.

```bash
# Check if already installed
xcode-select -p

# If not installed:
xcode-select --install
# A GUI dialog appears — click "Install" and wait. ~5 minutes.
```

### 1.2 Install Homebrew

Homebrew is the canonical package manager for macOS development. All subsequent tools
flow through it.

```bash
# Check
brew --version

# If not installed:
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# On Apple Silicon (M1/M2/M3/M4), Homebrew installs to /opt/homebrew.
# The installer prints two "Next steps" lines — run them to add brew to your PATH:
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"

# On Intel Macs, Homebrew installs to /usr/local and PATH is automatic.
```

Verify:
```bash
brew doctor
```

### 1.3 Install Git (via Homebrew)

```bash
# Check
git --version

# Install:
brew install git
```

Configure Git identity (use the user's actual info):
```bash
git config --global user.name "First Last"
git config --global user.email "user@example.com"
git config --global init.defaultBranch main
```

## Phase 2 — Runtimes & Package Managers

### 2.1 Install Node.js 22 LTS

```bash
# Check
node --version

# Install:
brew install node@22

# Link it (if not already the default):
brew link --overwrite --force node@22
```

After install, restart the terminal and verify:
```bash
node --version  # expect v22.x
npm --version   # expect 10.x or 11.x
```

### 2.2 Install pnpm (optional but canonical)

```bash
npm i -g pnpm
pnpm --version
```

## Phase 3 — Containerization & Local Supabase

### 3.1 Install Docker Desktop

**Mac advantage:** Docker Desktop on macOS uses the native Unix socket
(`/var/run/docker.sock`). No WSL2 layer, no TCP :2375 exposure needed. The Supabase
vector/logdrain container connects natively — no restart-loop gotcha.

```bash
# Check
docker --version

# Install:
brew install --cask docker
```

**Post-install:**
1. Open Docker Desktop from `/Applications/Docker.app`.
2. Accept the license agreement.
3. Wait for the Docker engine to show "Engine running" (green dot in menu bar).
4. Verify:
   ```bash
   docker info
   docker run --rm hello-world
   ```

### 3.2 Install Supabase CLI

```bash
# Check
supabase --version

# Install via Homebrew (canonical tap):
brew install supabase/tap/supabase
```

### 3.3 Start Supabase local development server

```bash
# Navigate to a project directory (or create one):
mkdir -p ~/projects/my-project
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
- `supabase_kong` — API gateway
- `supabase_vector` — Log drain (connects natively via Docker socket — no config needed)
- `supabase_analytics` — Analytics
- `supabase_imgproxy` — Image proxy (fully functional on Mac)
- `supabase_pooler` — Connection pooler (fully functional on Mac)

**All 14 containers run healthy on macOS with zero additional configuration.**
The Windows-specific `imgproxy`/`pooler` stops and vector restart-loop do not apply.

Key local URLs:
| Service | URL |
|---|---|
| Studio | http://localhost:54323 |
| API | http://localhost:54321 |
| Inbucket/Mailpit (email) | http://localhost:54324 |
| Database | localhost:54322 |

To stop: `supabase stop`

## Phase 4 — Deploy & Source Control Tools

### 4.1 Install GitHub CLI

```bash
# Check
gh --version

# Install:
brew install gh
```

Authenticate:
```bash
gh auth login
# Choose: GitHub.com → HTTPS → Login with a web browser
```

Verify:
```bash
gh auth status
```

### 4.2 Install Vercel CLI

```bash
# Check
vercel --version

# Install:
npm i -g vercel
```

Authenticate:
```bash
vercel login
```

Link to an existing Vercel project:
```bash
cd ~/projects/my-lovable-project
vercel link
```

### 4.3 Install Puppeteer (for HTML report generation, screenshots)

```bash
npm i -g puppeteer
```

## Phase 5 — Editor & AI Agent

### 5.1 Install VS Code

```bash
# Check
code --version

# Install:
brew install --cask visual-studio-code
```

Recommended extensions (install via `code --install-extension`):
```bash
code --install-extension bradlc.vscode-tailwindcss
code --install-extension github.copilot
code --install-extension github.copilot-chat
code --install-extension ms-vscode.vscode-typescript-next
code --install-extension denoland.vscode-deno
```

### 5.2 Install Claude Code

```bash
# Check
claude --version

# Install:
npm i -g @anthropic-ai/claude-code
```

## Phase 6 — Zsh Profile (Optimo Canonical)

The zsh profile at `~/.zshrc` should contain:

```bash
# === Optimo Ventures — Canonical Zsh Profile ===
# Provisioned by optimo-local-dev-setup-mac skill

# — Homebrew (Apple Silicon)
if [ -f /opt/homebrew/bin/brew ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# — Supabase CLI auto-complete
if command -v supabase &> /dev/null; then
    source <(supabase completion zsh)
fi

# — GitHub CLI auto-complete
if command -v gh &> /dev/null; then
    source <(gh completion -s zsh)
fi

# — Alias shortcuts
alias sb='supabase'
alias vc='vercel'

# — Prompt: show current git branch (if you don't use oh-my-zsh)
autoload -Uz vcs_info
precmd() { vcs_info }
zstyle ':vcs_info:git:*' formats ' [%b]'
setopt PROMPT_SUBST
PROMPT='%~%F{cyan}${vcs_info_msg_0_}%f %# '
```

> **Note:** If using oh-my-zsh (common on Mac), the git branch in prompt is already handled
> by the `git` plugin. The aliases and completions above are still useful.

## Phase 7 — Verification Checklist

Run this after all phases to confirm the machine is ready:

```bash
echo "=== Optimo Local Dev Environment — Verification ==="
echo "macOS     : $(sw_vers -productVersion)"
echo "Arch      : $(uname -m)"
echo "Shell     : $SHELL"
echo "Homebrew  : $(brew --version | head -1)"
echo "Node.js   : $(node --version)"
echo "npm       : $(npm --version)"
echo "pnpm      : $(pnpm --version 2>/dev/null || echo 'NOT INSTALLED')"
echo "Git       : $(git --version)"
echo "GitHub CLI: $(gh --version | head -1)"
echo "Docker    : $(docker --version)"
echo "Supabase  : $(supabase --version 2>/dev/null || echo 'NOT INSTALLED')"
echo "Vercel    : $(vercel --version)"
echo "VS Code   : $(code --version | head -1)"
echo "Claude    : $(npm list -g @anthropic-ai/claude-code 2>/dev/null | grep claude-code || echo 'NOT INSTALLED')"
```

Expected output (versions approximate):
```
=== Optimo Local Dev Environment — Verification ===
macOS     : 15.4
Arch      : arm64
Shell     : /bin/zsh
Homebrew  : Homebrew 4.5.2
Node.js   : v22.14.0
npm       : 11.16.0
pnpm      : 11.8.0
Git       : git version 2.52.0
GitHub CLI: gh version 2.94.0
Docker    : Docker version 29.6.1
Supabase  : 2.109.1
Vercel    : 54.14.5
VS Code   : 1.127.0
Claude    : @anthropic-ai/claude-code@2.1.212
```

### Supabase post-start health check (all 14 should be healthy)

```bash
supabase start
docker ps --format "table {{.Names}}\t{{.Status}}" | grep supabase
```

All 14 containers should show `(healthy)` — no Windows-style exclusions.

## Phase 8 — Local ↔ Cloud Pipeline Integration

Once the local toolchain is verified, wire it to the Optimo cloud services:

### 8.1 Lovable (build)

Lovable is a cloud AI builder — code originates there and is pulled local via GitHub.
No local install needed; interact via the Lovable MCP connector or lovable.dev.

### 8.2 GitHub (source control)

Every Lovable project has a GitHub repo. Clone it locally:

```bash
cd ~/projects
gh repo clone Optimo-Ventures-Incorporate/<repo-name>
```

Push changes from local back to GitHub:
```bash
git add -A
git commit -m "Local change: <description>"
git push origin main
```

Lovable auto-syncs from the connected GitHub repo.

### 8.3 Vercel (deploy)

Vercel auto-deploys from GitHub on every push to the main branch. For manual deploys:

```bash
cd ~/projects/<project>
vercel --prod
```

For preview deployments (per-branch):
```bash
vercel
```

### 8.4 Supabase (cloud ↔ local)

For projects with a Supabase cloud backend, pull the remote schema:

```bash
cd ~/projects/<project>
supabase link --project-ref <project-ref>
supabase db pull
```

Push local migrations to cloud:
```bash
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

1. `supabase start` — start local Postgres, Auth, Storage (~14 containers).
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

## Mac vs Windows — Key Differences

| Aspect | Windows | Mac |
|---|---|---|
| Package manager | Scoop + winget | Homebrew |
| Shell profile | PowerShell `$PROFILE` | zsh `~/.zshrc` |
| Docker backend | WSL2 (Linux VM) | Native Unix socket |
| Supabase containers | 12 (imgproxy+pooler stopped) | **14** (all healthy) |
| Vector/logdrain | **Needs** `tcp://localhost:2375` fix | Works natively — no config |
| Supabase CLI install | `scoop install supabase` | `brew install supabase/tap/supabase` |
| Node.js install | `winget install OpenJS.NodeJS.LTS` | `brew install node@22` |
| VS Code install | `winget install Microsoft.VisualStudioCode` | `brew install --cask visual-studio-code` |
| Apple Silicon | N/A | Native arm64; Homebrew at `/opt/homebrew` |

## Resources

- Homebrew: https://brew.sh
- Supabase CLI (macOS): https://supabase.com/docs/guides/local-development/cli/getting-started?platform=macos
- Docker Desktop for Mac: https://docs.docker.com/desktop/setup/install/mac-install/
- Vercel CLI: https://vercel.com/docs/cli
- Companion Windows skill: `optimo-local-dev-setup`
