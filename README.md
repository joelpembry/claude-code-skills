# Optimo Ventures — Claude Code Skills Library

Corporate skills library for the Optimo Ventures AI Operator ecosystem.
All skills are governed by [OptimoCodex™](https://optimoventures.atlassian.net/wiki/spaces/OPTIMOV/pages/71008296)
and codified as canonical specifications under
[00.07 — Optimo AI Operator Skills](https://optimoventures.atlassian.net/wiki/spaces/OPTIMOV/pages/145653795).

## Quick Start (Employees)

```powershell
# Windows
git clone https://github.com/joelpembry/claude-code-skills.git
cd claude-code-skills
.\install.ps1
```

```bash
# macOS / Linux
git clone https://github.com/joelpembry/claude-code-skills.git
cd claude-code-skills
./install.sh
```

The installer:
- Symlinks all skills into your Claude Code skills directory
- Registers shared memory hooks (SessionStart/Stop)
- Sets up daily auto-sync (`git pull`)
- Detects existing installations and preserves local overrides

## Skills Included

| Skill | Purpose | Confluence Spec |
|---|---|---|
| `optimo-ventures` | Enterprise operator — Confluence, Jira, Slack, governance | [00.07.1](https://optimoventures.atlassian.net/wiki/spaces/OPTIMOV/pages/145096711) |
| `optimo-venture-triage` | Ideation intake & Go/No-Go gate | [00.07.2](https://optimoventures.atlassian.net/wiki/spaces/OPTIMOV/pages/145457162) |
| `optimo-rcm` | 5-perspective recursive reasoning engine | Built-in — references 02.10 Cortex |
| `report-distributor` | Post-report distribution pipeline | [00.07.3](https://optimoventures.atlassian.net/wiki/spaces/OPTIMOV/pages/213581915) |

## ChatGPT Equivalents

Custom GPT instructions for each skill live in `/chatgpt/`. These mirror the Claude Code
skills for team members using ChatGPT instead of Claude.

## Shared Memory

Each venture has a shared memory file in `/memory/<venture-slug>/shared-memory.json`.
These are synced at session start so every team member has the same build state,
decisions, conventions, and contacts. See [Shared Memory Architecture](#shared-memory)
below.

## Keeping Current

The installer sets up a daily scheduled task that runs `git pull`. You can also
update manually:

```bash
cd ~/claude-code-skills
git pull
```

## Adding a New Skill

1. Create `skills/<skill-name>/SKILL.md` with proper YAML frontmatter
2. Add ChatGPT equivalent in `chatgpt/<skill-name>-gpt.md`
3. File canonical spec as `00.07.N` in Confluence per governance
4. Update this README's skill table
5. Open a PR for review

## Governance

All skills are governed by OptimoCodex™ invariants. The specification synchronization
doctrine (00.07 container) requires: any skill revision → update its `00.07.N` Confluence
spec page AND the operator usage guide in the same commit. The installed package and
its spec must never drift apart.

## Repository Layout

```
claude-code-skills/
├── README.md
├── install.ps1 / install.sh        ← auto-installer
├── skills/                          ← Claude Code skills
│   ├── optimo-ventures/
│   ├── optimo-venture-triage/
│   ├── optimo-rcm/
│   └── report-distributor/
├── chatgpt/                         ← ChatGPT Custom GPT equivalents
├── memory/                          ← shared memory per venture
│   ├── optimoland/
│   ├── gutwise-journey/
│   ├── rcm-platform/
│   └── ... (one folder per genesis hub)
├── hooks/                           ← SessionStart/Stop hooks
└── .github/
    └── CODEOWNERS
```
