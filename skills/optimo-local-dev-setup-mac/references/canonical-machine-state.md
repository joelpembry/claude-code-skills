# Canonical Machine State — Mac Development Workstation

Template. Populate with actual values after provisioning the first Mac.

## OS

- **macOS** 15.x (Sequoia) or later
- **Architecture:** Apple Silicon (arm64) preferred; Intel (x86_64) supported
- **Shell:** zsh (default)

## Installed Tools (target versions)

| Tool | Version | Install Method | Path |
|---|---|---|---|
| Xcode CLI | 16.x | `xcode-select --install` | `/Library/Developer/CommandLineTools/` |
| Homebrew | 4.x | shell script | `/opt/homebrew/bin/brew` (Apple Silicon) or `/usr/local/bin/brew` (Intel) |
| Git | 2.52+ | `brew install git` | `/opt/homebrew/bin/git` |
| GitHub CLI | 2.94+ | `brew install gh` | `/opt/homebrew/bin/gh` |
| Node.js | 22 LTS | `brew install node@22` | `/opt/homebrew/bin/node` |
| npm | bundled | ships with Node | `/opt/homebrew/bin/npm` |
| pnpm | 11+ | `npm i -g` | `/opt/homebrew/bin/pnpm` |
| Docker Desktop | 29+ | `brew install --cask docker` | `/Applications/Docker.app` |
| Supabase CLI | 2.109+ | `brew install supabase/tap/supabase` | `/opt/homebrew/bin/supabase` |
| Vercel CLI | 54+ | `npm i -g` | `/opt/homebrew/bin/vercel` |
| VS Code | 1.127+ | `brew install --cask visual-studio-code` | `/Applications/Visual Studio Code.app` |
| Claude Code | 2.1+ | `npm i -g` | `/opt/homebrew/bin/claude` |
| Puppeteer | 25+ | `npm i -g` | `/opt/homebrew/lib/node_modules/puppeteer` |

## Homebrew Taps

```
homebrew/core
supabase/tap
```

## Global npm Packages

```
@anthropic-ai/claude-code
pnpm
puppeteer
vercel
```

## Docker Configuration

- **Backend:** Native macOS (no WSL, no Linux VM layer)
- **Socket:** `/var/run/docker.sock` (vector/logdrain connects natively)
- **No TCP :2375 exposure needed** — this is a Windows-only requirement
- **All 14 Supabase containers** run healthy (imgproxy + pooler included — Mac-only)

## Zsh Profile

Location: `~/.zshrc`

Contents:
- Homebrew shellenv (Apple Silicon path)
- Supabase + GitHub CLI completions
- `sb` → supabase, `vc` → vercel aliases
- Git branch in prompt (or oh-my-zsh git plugin)

## VS Code Extensions

- Tailwind CSS IntelliSense
- GitHub Copilot / Copilot Chat
- TypeScript Nightly
- Deno

## Key Directories

```
~/projects/                   # All Optimo project checkouts
~/.claude/                    # Claude Code configuration
~/.claude/skills/             # Installed skills
~/.claude/CLAUDE.md           # Global CLAUDE.md
/opt/homebrew/                # Homebrew prefix (Apple Silicon)
/usr/local/                   # Homebrew prefix (Intel)
```

## Verification Script

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

## Changelog

| Date | Change |
|---|---|
| 2026-07-17 | Initial template created; awaiting first Mac provisioning |
