# B₁ — Claude Code Skill Scaffold

The RCM Claude Code skill lives at `.claude/skills/rcm/` (globally: `C:\Users\joelp\.claude\skills\rcm\`).

## Directory layout

```
.claude/skills/rcm/
├── SKILL.md                          # Skill definition and trigger description
├── references/
│   ├── rcm-session-protocol.md       # Session lifecycle (mirrors this operator skill)
│   ├── project-state.md              # Project State schema and branching
│   ├── specialist-engines.md         # Engine contracts
│   └── libraries/
│       ├── base/
│       │   ├── human-truths.md
│       │   ├── audience-intelligence.md
│       │   ├── objections.md
│       │   ├── visual-cognition.md
│       │   ├── media-hierarchy.md
│       │   ├── media-composition.md
│       │   ├── ui-ux.md
│       │   └── marketing-view.md
│       └── domain-packs/
│           ├── venture/
│           ├── product/
│           ├── marketing/
│           ├── media/
│           └── research/
├── templates/
│   ├── perspective-prompts/
│   │   ├── explorer.md
│   │   ├── evaluator.md
│   │   ├── executor.md
│   │   ├── threat.md
│   │   └── social.md
│   └── project-state-blank.md
├── sessions/                         # Runtime — gitignored or local only
│   └── .gitkeep
└── sync/
    └── confluence-sync.ps1           # PowerShell script to pull libraries from Confluence
```

## SKILL.md header for B₁ (Claude Code)

```yaml
---
name: rcm
description: >-
  Recursive Creativity Model — 5-perspective reasoning engine. Invoke with /rcm <goal> to
  run Explorer, Evaluator, Executor, Threat, and Social perspectives against any goal, idea,
  or problem, accumulating a Project State that can be branched, merged, and promoted to an
  Approved Project State. Use for venture ideation, product planning, marketing strategy,
  media creation, or research synthesis.
---
```

## Perspective prompt templates

Each perspective prompt in `templates/perspective-prompts/` follows this structure:

```markdown
# <Perspective Name> Perspective

You are the <Perspective> perspective of the RCM (Recursive Creativity Model) engine.

## Your lens
<one paragraph describing how this perspective thinks>

## Your mandate
- Input: the current goal + the Project State accumulated so far
- Output: your structured perspective findings, appended to the relevant Project State dimensions
- You must update at minimum: <list the Project State dimensions this perspective owns>

## Active domain pack
{DOMAIN_PACK} — load libraries from references/libraries/domain-packs/{DOMAIN_PACK}/
and relevant base/ libraries.

## Current Project State
{PROJECT_STATE}

## Your task
{TASK}
```

## Confluence → skill sync script (`sync/confluence-sync.ps1`)

The sync script pulls knowledge library pages from Confluence and writes them to
`references/libraries/base/`. Run it when libraries are updated in Confluence.

```powershell
# confluence-sync.ps1 — sync RCM knowledge libraries from Confluence to local skill directory
# Requires: Confluence API token in environment as CONFLUENCE_API_TOKEN
# Usage: .\confluence-sync.ps1

$cloudId = "a9042b7c-96da-42c2-bb54-4c2209c67b3d"
$baseUrl = "https://api.atlassian.com/ex/confluence/$cloudId/wiki/rest/api/content"

# Library page IDs — update as pages are created in Confluence
$libraries = @{
    "human-truths"          = "199131358"   # RCM Knowledge Library — Human Truths
    "audience-intelligence" = "199655427"   # RCM Knowledge Library — Audience Intelligence
    "objections"            = "199852033"   # RCM Knowledge Library — Objections
    "visual-cognition"      = "199753730"   # RCM Knowledge Library — Visual Cognition
    "media-hierarchy"       = "199098547"   # RCM Knowledge Library — Media Hierarchy
    "media-composition"     = "199360575"   # RCM Knowledge Library — Media Composition
    "ui-ux"                 = "199360596"   # RCM Knowledge Library — UI/UX
    "marketing-view"        = "199688210"   # RCM Knowledge Library — Marketing View
}

foreach ($name in $libraries.Keys) {
    $pageId = $libraries[$name]
    if ($pageId -eq "TBD") { continue }
    # fetch + write to references/libraries/base/$name.md
    # add provenance comment: <!-- source: Confluence page ID $pageId, synced $(Get-Date -Format 'yyyy-MM-dd') -->
}
```

## Build estimate (from triage addendum)

| Phase | Scope | Duration | Cost |
| --- | --- | --- | --- |
| MVP | Core engine + Explorer + Evaluator + Venture domain pack | 2-4 days | $0 |
| Full | All 5 perspectives + all domain packs + branching | 1-2 weeks | $0 |
| B₂ gate | B₁ must be validated with 1 real use case | Dogfood session | — |

## Distribution decision (C7 — PENDING)

Before public release, decide:
- **Scope:** workspace-only vs. public Claude Code skill registry
- **License:** MIT, Apache 2.0, or proprietary
- **Model:** open-engine / proprietary-content (recommended — engine open, libraries in Confluence as moat)

This decision gates public distribution. Workspace-only distribution requires no license decision.
