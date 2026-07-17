# Canonical Machine State — Joel's Windows 11 Workstation

Snapshot taken 2026-07-16. This is the authoritative reference for what "a working Optimo
dev machine" looks like. Use this to compare new machines and verify completeness.

## OS

- **Windows 11 Pro** 10.0.26200
- **WSL2** with Ubuntu (default distribution)

## Installed Tools (with versions)

| Tool | Version | Install Method | Path |
|---|---|---|---|
| PowerShell 7 | 7.6.3 | winget | `C:\Program Files\WindowsApps\Microsoft.PowerShell_7.6.3.0_x64__8wekyb3d8bbwe\pwsh.exe` |
| Scoop | 0.5.3 | `iwr -useb get.scoop.sh \| iex` | `~\scoop\` |
| Git | 2.52.0 | winget | (system PATH) |
| GitHub CLI | 2.94.0 | winget | (system PATH) |
| Node.js | 22.14.0 | winget | (system PATH) |
| npm | 11.16.0 | bundled with Node | (system PATH) |
| pnpm | 11.8.0 | `npm i -g` | `~\AppData\Roaming\npm\` |
| Docker Desktop | 29.6.1 | winget | `C:\Program Files\Docker\Docker\resources\bin\docker.exe` |
| Supabase CLI | 2.109.1 | Scoop (supabase bucket) | `~\scoop\shims\supabase.exe` |
| Vercel CLI | 54.14.5 | `npm i -g` | `~\AppData\Roaming\npm\vercel.ps1` |
| VS Code | 1.127.0 | winget | (system PATH) |
| Claude Code | 2.1.212 | `npm i -g` | `~\AppData\Roaming\npm\` |
| Puppeteer | 25.1.0 | `npm i -g` | `~\AppData\Roaming\npm\` |

## Scoop Buckets

```
main:     https://github.com/ScoopInstaller/Main
supabase: https://github.com/supabase/scoop-supabase.git
```

## Global npm Packages

```
@anthropic-ai/claude-code@2.1.211
@forge/cli@12.14.0
docx@9.7.1
openclaw@2026.5.28
pnpm@11.8.0
puppeteer@25.1.0
vercel@54.14.5
```

## Docker Configuration

- **Backend:** WSL2 (`desktop-linux` context)
- **Engine version:** 29.6.1
- No persistent containers running by default (Supabase local dev is started on-demand)

## PowerShell Profile

Location: `~\Documents\PowerShell\Microsoft.PowerShell_profile.ps1`

Contents:
- DeepSeek API redirect for Claude Code (OptimoStudio-specific — 6 env vars)
- (Standard aliases and git prompt are described in the skill but may vary from actual profile)

## MCP Servers Configured

From `~/.claude/.mcp.json`:
- **Dropbox** (OAuth)
- **Lovable** (plugin, OAuth)
- **Slack** (plugin, OAuth)
- **Confluence** (stdio, npx)
- **Jira** (stdio, npx)
- **Zoom** (plugin, OAuth — token may need refresh)

## VS Code Extensions

- Tailwind CSS IntelliSense
- GitHub Copilot / Copilot Chat
- TypeScript Nightly
- Deno

## Key Directories

```
~\projects\                    # All Optimo project checkouts
~\projects\OptimoVentures\     # Optimo monorepo / skills repo
~\.claude\                     # Claude Code configuration
~\.claude\skills\              # Installed skills (43+)
~\.claude\projects\            # Per-project session data
~\.claude\CLAUDE.md            # Global CLAUDE.md (Ruflo + Optimo instructions)
~\scoop\                       # Scoop-managed tools
~\AppData\Roaming\npm\         # npm global packages
```

## Verification Script

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

## Changelog

| Date | Change |
|---|---|
| 2026-07-16 | Initial snapshot captured; skill created |
