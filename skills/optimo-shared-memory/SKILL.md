# Optimo Shared Memory — Cross-Session Venture Context

---
name: optimo-shared-memory
description: SessionStart hook synced shared memory — loads venture build state, decisions, conventions, and contacts from the corporate GitHub repo so every team member's Claude Code session has identical context.
---

# Shared Memory Skill

This skill is invoked automatically by the SessionStart hook. It loads the
venture's shared memory from the corporate GitHub repo and injects it into
the session context so Claude has the same build state, active tickets,
decisions, conventions, and contacts as every other team member.

## How It Works

1. **SessionStart** hook runs `session-start-memory-sync.ps1`
2. Hook pulls the latest `memory/<venture-slug>/shared-memory.json` from GitHub
3. This skill reads the JSON and loads it into the session context
4. Claude now has:
   - Current build phase and sprint
   - Active Jira tickets
   - Recent decisions and their rationale
   - Team conventions (which model to use, naming rules, etc.)
   - Key contacts (venture lead, technical lead, etc.)
   - Triage status and conditions (if applicable)

5. **SessionEnd** hook prompts to commit any changes back

## Shared Memory Schema

Each venture has a `shared-memory.json`:

```json
{
  "venture": "Venture Name",
  "ventureSlug": "venture-slug",
  "hubPageId": "12345678",
  "confluencePages": {
    "hub": "12345678",
    "triage": "12345678",
    "architecture": "12345678"
  },
  "buildState": {
    "phase": "Phase 2 — Active Build",
    "currentSprint": "Sprint 4",
    "lovableProjectId": "abc123",
    "vercelDeployment": "venture-name.vercel.app",
    "lastDeploy": "2026-07-01",
    "currentStep": "Implementing user auth"
  },
  "jira": {
    "epic": "KAN-XXX",
    "activeTickets": ["KAN-XXX", "KAN-YYY"]
  },
  "decisions": [
    {
      "date": "2026-07-01",
      "decision": "Use Supabase Auth with magic link + OAuth",
      "by": "Technical Lead",
      "rationale": "Simplest integration with existing Supabase backend"
    }
  ],
  "conventions": [
    "Use Sonnet 4.6 for all builds",
    "Never delete Confluence pages",
    "All HTML reports go through report-distributor"
  ],
  "contacts": {
    "ventureLead": "Name",
    "technicalLead": "Name"
  }
}
```

## Venture Slug Mapping

The hook determines which venture to load based on the project path:

| Project Path Contains | Venture Slug | Shared Memory File |
|---|---|---|
| `optimoland` | `optimoland` | `memory/optimoland/shared-memory.json` |
| `gutwise` | `gutwise-journey` | `memory/gutwise-journey/shared-memory.json` |
| `rcm` | `rcm-platform` | `memory/rcm-platform/shared-memory.json` |
| `optimolaunch` | `optimolaunch` | `memory/optimolaunch/shared-memory.json` |
| `optimoevidence` | `optimoevidence` | `memory/optimoevidence/shared-memory.json` |
| `telosai` | `telosai` | `memory/telosai/shared-memory.json` |
| `optimoselect` | `optimoselect` | `memory/optimoselect/shared-memory.json` |
| `optimostudio` | `optimostudio` | `memory/optimostudio/shared-memory.json` |
| `artquest` | `artquest` | `memory/artquest/shared-memory.json` |

## Governance

- Shared memory is additive. Never remove information without a decision record.
- Decisions should include date, description, author, and rationale.
- Conventions should be actionable rules, not aspirations.
- Build state should be updated at least once per sprint.
- Shared memory is stored in the corporate GitHub repo — it survives machine changes and personnel turnover.
