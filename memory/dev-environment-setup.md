---
name: local-dev-environment-setup
description: "Canonical Optimo dev machine stack for Windows 11 and macOS — tools, versions, Supabase local, Docker TCP :2375 fix (Windows only), and provisioning skills for both platforms"
metadata: 
  node_type: memory
  type: reference
  originSessionId: ee60b887-ed2a-4b68-9e27-92514524744f
---

# Optimo Local Dev Environment — Canonical Setup

## Machine Profile (Joel's Windows 11 Pro, captured 2026-07-17)

| Tool | Version | Install Method |
|---|---|---|
| PowerShell 7 | 7.6.3 | winget |
| Scoop | 0.5.3 | `iwr -useb get.scoop.sh \| iex` |
| Git | 2.52.0 | winget |
| GitHub CLI | 2.94.0 | winget |
| Node.js | 22.14.0 | winget |
| npm | 11.16.0 | bundled |
| pnpm | 11.8.0 | `npm i -g` |
| Docker Desktop | 29.6.1 | winget |
| Supabase CLI | 2.109.1 | Scoop (supabase bucket) |
| Vercel CLI | 54.14.5 | `npm i -g` |
| VS Code | 1.127.0 | winget |
| Claude Code | 2.1.212 | `npm i -g` |
| Puppeteer | 25.1.0 | `npm i -g` |

## Critical Windows-Specific Fix: Docker TCP :2375

Supabase local dev on Windows requires Docker Desktop to expose its daemon on TCP. Without this, the `vector` (logdrain) container crashes in a restart loop and analytics warns.

**Fix:** Docker Desktop → Settings → General → "Expose daemon on tcp://localhost:2375 without TLS"

Or edit `%APPDATA%\Docker\settings-store.json`:
```json
"ExposeDockerAPIOnTCP2375": true
```

Then restart Docker Desktop and `supabase stop && supabase start`.

**Why:** Vector uses `docker_logs` source to tail container logs, which needs a TCP connection to the Docker daemon. The default Windows named pipe (`//./pipe/dockerDesktopLinuxEngine`) isn't reachable from inside the vector container.

## Verification Script

```powershell
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
Claude     : $(npm list -g @anthropic-ai/claude-code 2>$null | Select-String "claude-code")
Scoop      : $(scoop --version)
WSL        : $(wsl --status 2>$null | Select-Object -First 1)
```

## Supabase Local Post-Start Validation

All 12 containers should show `(healthy)`:
```
supabase_studio, supabase_pg_meta, supabase_edge_runtime, supabase_storage,
supabase_rest, supabase_realtime, supabase_inbucket, supabase_auth,
supabase_kong, supabase_vector, supabase_analytics, supabase_db
```
imgproxy + pooler are stopped automatically on Windows (known limitation, non-critical).

## Skills

| Platform | Skill | Status |
|---|---|---|
| Windows 11 | `/optimo-local-dev-setup` | ✅ Built, verified on Joel's machine, pushed to repo |
| macOS | `/optimo-local-dev-setup-mac` | ✅ Built, pushed to repo; awaiting first Mac provisioning |

Both skills live at `skills/optimo-local-dev-setup*` in the `joelpembry/claude-code-skills` repo (master). Each covers the full 8-phase provisioning pipeline plus a canonical-machine-state reference.

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


## Related

- [[feedback-mcp-activation]] — MCP servers configured on this machine
- [[onedrive-html-render-publish-workflow]] — Superseded by Dropbox workflow
- [[optimostudio-build-status]] — DeepSeek API redirect in PowerShell profile
