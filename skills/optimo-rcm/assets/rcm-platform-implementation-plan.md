# RCM Platform(TM) — Comprehensive Implementation Plan

**Perspective:** Executor
**Date:** 2026-06-28
**Status:** Active — CONDITIONAL-GO (H: A+B1+B2)
**Current Disposition:** 3 components — A (Canon) = DONE, B1 (Skill) = DONE, B2 (Web App) = PENDING

---

## Table of Contents

1. [Current State Assessment](#1-current-state-assessment)
2. [Conditions Clearing Plan (C2-C7)](#2-conditions-clearing-plan)
3. [B2 Web Application Build Plan](#3-b2-web-application-build-plan)
4. [Domain Pack Production Plan](#4-domain-pack-production-plan)
5. [Knowledge Library Completion & Sync Plan](#5-knowledge-library-completion--sync-plan)
6. [Skill Distribution Plan](#6-skill-distribution-plan)
7. [Dependencies & Critical Path](#7-dependencies--critical-path)
8. [Total Build Estimate](#8-total-build-estimate)
9. [Risk & Contingency](#9-risk--contingency)

---

## 1. Current State Assessment

### Component A — Canonical Core (02.10)

| Item | Status | Detail |
|---|---|---|
| 02.10 Confluence page | COMPLETE | Page 189661186, version 1, Active |
| 5 perspectives defined | COMPLETE | Explorer, Evaluator, Executor, Threat, Social |
| 13 Project State dimensions | COMPLETE | Objectives through Specifications |
| Branching contract | COMPLETE | Compare, Merge, Promote, Archive |
| Specialist engine interface | COMPLETE | Narrative, Persuasion, Sales, Decision |
| Consumer registry | COMPLETE | 6 consumers listed (TelosAI, OptimoStudio, etc.) |
| Governance terms | COMPLETE | Additive amendments; invariant preservation |

### Component B1 — Claude Code Skill

| Item | Status | Detail |
|---|---|---|
| SKILL.md | COMPLETE | Full command reference, architecture doc |
| 5 perspective prompt templates | COMPLETE | Explorer, Evaluator, Executor, Threat, Social |
| Project State JSON schema | COMPLETE | 13-dimension schema with metadata |
| Project State blank template | COMPLETE | Markdown and JSON forms |
| Session templates | COMPLETE | project-state-template.md, session-report-template.md |
| Real project sessions | 6 COMPLETED | ai-compliance-automation, electric-pet-for-kids, gutwise-connector-architecture, optimostudio-rcm-integration, rcm-platform-venture, western-narrative-world |
| Validation sessions | 2 COMPLETED | Includes OptimoShield session |
| Sync script | DRAFT | sync-libraries.sh exists but relies on MCP commands |
| Library-registry.json | STALE | Lists all 8 libraries as "not yet created" (incorrect) |

### Component B2 — Web Application

| Item | Status | Detail |
|---|---|---|
| Functional spec | DRAFT | b2-web-app.md reference document exists |
| Jira epic scaffold | DEFINED | 10 epics listed in spec |
| Architecture decision | MADE | Lovable + Supabase + Vercel (standard OPTIMOV) |
| Build | NOT STARTED | Conditional on C2-B2, C3, C5, C6 clearing |

### Knowledge Libraries

**CRITICAL FINDING:** All 8 base libraries are ALREADY authored in Confluence with substantial content (Sam, Version 1, 2026-06-28). The library-registry.json is stale. This is a positive discovery that changes the build estimates.

| Library | Confluence Page | Content Status | Local Sync Status |
|---|---|---|---|
| Human Truths | 199131358 | COMPLETE (v1) | NOT SYNCED |
| Audience Intelligence | 199655427 | COMPLETE (v1) | NOT SYNCED |
| Objections | 199852033 | COMPLETE (v1) | NOT SYNCED |
| Visual Cognition | 199753730 | COMPLETE (v1) | NOT SYNCED |
| Media Hierarchy | 199098547 | COMPLETE (v1) | NOT SYNCED |
| Media Composition | 199360575 | COMPLETE (v1) | NOT SYNCED |
| UI/UX | 199360596 | COMPLETE (v1) | NOT SYNCED |
| Marketing View | 199688210 | COMPLETE (v1) | NOT SYNCED |

### Domain Packs

| Pack | Status | Detail |
|---|---|---|
| venture | EMPTY | Directory exists, no manifest or extensions |
| product | EMPTY | Directory exists, no manifest or extensions |
| marketing | EMPTY | Directory exists, no manifest or extensions |
| media | EMPTY | Directory exists, no manifest or extensions |
| research | EMPTY | Directory exists, no manifest or extensions |

### Conditions Gate (as of 2026-06-28)

| Cond | Description | Status | Notes |
|---|---|---|---|
| C1 | 02.10 canon exists | CLEARED | Page 189661186, Live |
| C2 | Functional spec B1+B2 | IN PROGRESS | B1 spec = complete; B2 spec = draft reference doc |
| C3 | AI cost model | PENDING | Not started |
| C4 | TelosAI overlap | PENDING | Known overlap on Explorer+Social; no boundary agreement |
| C5 | B1 validated (>=1 dogfood) | EFFECTIVELY CLEARED | 6 real project sessions, 2 validation sessions |
| C6 | Domain pack content | PARTIAL | Venture pack conceptualized; no authored content |
| C7 | Distribution decision | PENDING | No decision on workspace-only vs. public |

---

## 2. Conditions Clearing Plan

### C2-B2: Web Application Functional Spec

**Current State:** B2 spec exists as a reference document (b2-web-app.md) but is not a canonical Confluence page. It defines the stack, 10 Jira epics, and 7 feature groups but lacks detail.

**What's Needed:**
1. Promote B2 spec from local reference doc to Confluence venture hub page
2. Write detailed functional spec covering:
   - User personas (CLI user, web-only user, team admin)
   - Data model (Supabase tables, RLS policies)
   - API contracts (REST endpoints for Project State CRUD, perspective dispatch)
   - All 30+ screens (wireframe-level descriptions)
   - Auth model (Supabase Auth, OAuth providers, API keys)
   - Export formats (HTML, Markdown, PDF, JSON)
   - Integration contracts (how B2 calls Claude API for perspective dispatch)
3. File as DRY_RUN to OptimoCodex if it touches canon boundaries

**Who:** Sam + Joel (for screen priority)
**Effort:** 2-3 days
**Output:** Confluence page "RCM Platform(TM) — B2 Web Application Functional Specification"
**Gate cleared when:** Technical architecture review completed; Joel signs off on scope

### C3: AI Orchestration Cost Model

**Current State:** No cost model exists. Risk R3 in project state flags "$13K/month at 500 projects" as a concern but no detailed modeling has been done.

**What's Needed:**
1. Per-session cost calculation:
   - 5 perspectives x 1 agent call each = 5 agent calls per session
   - Average input tokens per perspective (estimate from existing B1 sessions)
   - Average output tokens per perspective
   - Claude Sonnet 4.6 vs. Haiku 3.5 vs. Opus 4.5 pricing
   - Prompt caching savings (system prompts are identical, high cache hit rate)
2. Tier-to-cost mapping:
   - Free tier: 3 sessions/month, Explorer only (1 perspective)
   - Personal: 20 sessions/month, all 5 perspectives ($10-25/mo)
   - Team: 100 sessions/month, all features ($50-100/mo)
   - Enterprise: unlimited, custom models ($500+/mo)
3. Validate against 6 existing B1 sessions (extract actual token usage)
4. Model at different scales: 50, 200, 1000 active users/month
5. Include Edge Function hosting costs (Supabase + Vercel)

**Who:** Sam + Joel (pricing decisions)
**Effort:** 3-4 days
**Output:** Spreadsheet or Confluence page with per-tier cost/revenue model
**Gate cleared when:** Unit economics show >=70% gross margin at personal tier; Joel approves pricing

**Cost Estimate (Monthly at 200 users):**
| Tier | Users | Sessions/user | Total sessions | Inference cost | Infra cost | Revenue | Margin |
|---|---|---|---|---|---|---|---|
| Free | 100 | 3 | 300 | $30-90 | $25 | $0 | -$55 |
| Personal | 70 | 20 | 1,400 | $140-420 | $0 | $700-1,750 | ~75% |
| Team | 25 | 100 | 2,500 | $250-750 | $0 | $1,250-2,500 | ~70% |
| Enterprise | 5 | unlimited | ~500 | $50-150 | $25 | $2,500-5,000 | ~95% |
| **Total** | **200** | | **~4,700** | **$470-1,410** | **$50** | **~$4,450-9,250** | **~80-95%** |

### C4: TelosAI Overlap Resolution

**Current State:** TelosAI Phase 4 is active and uses Explorer+Social perspectives. RCM also uses these. Risk of conflicting perspective definitions, duplicated prompt engineering, or inconsistent Project State formats.

**What's Needed:**
1. Document TelosAI's current perspective usage in detail (which dimensions, what prompts)
2. Determine relationship model:
   - **Option A: RCM subsumes TelosAI** — TelosAI becomes a thin consumer of RCM's Project State + specific perspective prompts. This is architecturally cleanest (RCM orchestrates, TelosAI configures)
   - **Option B: TelosAI is independent but references RCM** — Separate codebases; TelosAI links to 02.10 canon but maintains its own perspective prompts
3. Write boundary agreement documenting:
   - Which perspectives each owns (RCM owns all 5 generically; TelosAI owns Explorer+Social specifically for orientation/simulation use cases)
   - Shared schema for Project State dimensions (should be identical — both reference 02.10)
   - Prompt governance (RCM perspective prompts are reference; TelosAI may extend but not weaken)
4. File agreement in Confluence

**Who:** Sam + TelosAI lead (Collin King or designated)
**Effort:** 2-3 days for analysis + agreement
**Output:** Confluence page "RCM Platform(TM) / TelosAI(TM) — Perspective Boundary Agreement"
**Gate cleared when:** Both leads sign; agreement filed; no unresolved conflicts

### C6: Domain Pack Content Strategy

**Current State:** Venture pack is conceptualized; all 5 pack directories are empty. Base libraries are authored (surprise — all 8 done) but pack manifests and extensions don't exist.

**Priority Order (recommended):**

| Priority | Pack | Rationale | Effort |
|---|---|---|---|
| 1 | venture | Internal dogfood; B1 validation; highest immediate ROI | 3-4 days |
| 2 | product | OPTIMOV ventures building products; next most common use | 2-3 days |
| 3 | marketing | External use cases; campaign strategy for ventures | 2-3 days |
| 4 | media | Content creation teams | 2 days |
| 5 | research | Broadest, most generic; lowest urgency | 1-2 days |

**What's Needed Per Pack:**
1. `pack-manifest.md` — which base libraries to load, any domain-specific overrides
2. Domain-specific extension files (e.g., venture-specific objection patterns, GTM templates)
3. Example prompts and session configurations
4. Test the pack with a real RCM session

**Who:** Sam (primary author), venture leads (review)
**Effort:** 10-14 days total across all 5 packs (can run partially in parallel)
**Output:** 5 populated domain pack directories with manifests and extensions
**Gate cleared when:** At least 1 pack (venture) is fully authored and tested in a session

### C7: Distribution Decision

**Current State:** No decision. Risk R1 flags that public SaaS exposes 02.10 to competitors. The recommended model in b1-skill-scaffold.md is "open engine / proprietary libraries."

**What's Needed:**
1. Decide scope:
   - **Workspace-only** (current): No distribution changes; skill stays in .claude/skills/
   - **Public Claude Code registry**: Submit skill to Anthropic's public skill registry
   - **GitHub public repo**: Publish engine code, exclude libraries
2. Decide license:
   - **MIT** for engine/orchestration (recommended — it's canonical, not proprietary)
   - **Proprietary/Confluence access** for libraries (recommended — this is the moat)
   - **Apache 2.0**, **AGPL**, or other (if needed for enterprise distribution)
3. Decide B2 SaaS licensing (if B2 is built):
   - Per-seat subscription (recommended for multi-tenant)
   - Per-workspace with team seats
   - Single-tenant enterprise contract
4. Write distribution governance document

**Who:** Joel (final decision), Sam (recommendation), legal review
**Effort:** 1 day discussion + 1 day legal = 2 total
**Output:** Confluence page "RCM Platform(TM) — Distribution Governance & Licensing"
**Gate cleared when:** Joel signs distribution decision; licensing determined

### Conditions Clearing Summary

| Cond | Owner | Effort | Can Parallelize? |
|---|---|---|---|
| C2-B2 spec | Sam + Joel | 2-3 days | Yes (with C3, C6, C7) |
| C3 cost model | Sam + Joel | 3-4 days | Yes (with C2, C6, C7) |
| C4 TelosAI | Sam + TELO lead | 2-3 days | Yes (depends on TelosAI availability) |
| C6 domain packs | Sam + venture leads | 10-14 days | Yes (packs can be authored in parallel) |
| C7 distribution | Joel + Sam | 2 days | Yes |
| **Total sequential worst-case** | | **~24 days** | |
| **Total parallel best-case** | | **~10-14 days** | C6 is the long pole |

---

## 3. B2 Web Application Build Plan

### Architecture

```
Lovable (Frontend)              Supabase (Backend)           Vercel (Hosting)
┌──────────────────────┐       ┌────────────────────┐       ┌──────────────┐
│ TanStack Start       │       │ PostgreSQL         │       │ Preview env  │
│ React 19             │       │ - projects         │       │ Production   │
│ Tailwind v4 + shadcn │◄─────►│ - project_states   │◄─────►│ Edge caching │
│ Radix primitives     │       │ - perspectives      │       │ Custom domain│
│                      │       │ - sessions          │       └──────────────┘
│ Pages:               │       │ - branches          │
│ - Dashboard          │       │ - exports           │       Claude API
│ - Project State view │       │ Auth (Supabase)     │       ┌──────────────┐
│ - Perspective panel  │       │ Edge Functions:     │◄─────►│ 5 perspective│
│ - Branch tree        │       │ - dispatch-perspective│     │ agent calls  │
│ - Library browser    │       │ - merge-branch       │       └──────────────┘
│ - Session manager    │       │ - export-state       │
│ - Export viewer      │       │ RLS by user_id       │
└──────────────────────┘       └────────────────────┘
```

### Phase 1 — MVP: Single-User Web App (CONDITIONAL-GO)

**Duration:** 5 weeks (1 engineer + AI/Lovable)
**Gate:** Must clear C2-B2 spec, C1, C5 before starting

**Week 1-2: Foundation (Lovable + Supabase)**
| Feature | Description | Lovable Effort |
|---|---|---|
| Supabase data model | Tables: projects, project_states, perspectives, sessions, branches, exports | 1 day (schema design + migration) |
| Supabase Auth | Magic link + Google OAuth; RLS policies by user_id | 1 day |
| Lovable project scaffold | TanStack Start + shadcn/ui setup; authentication pages | 2 days |
| Dashboard shell | Navigation layout; sidebar with main sections | 2 days |

**Week 2-3: Core Features**
| Feature | Description | Lovable Effort |
|---|---|---|
| Project State viewer | 13-dimension read-only view with collapsible sections | 2 days |
| Project State editor | Inline editing for each dimension; save to Supabase | 2 days |
| New project wizard | Create project, set goal, select domain pack | 1 day |
| Perspective output panels | Read-only view of each perspective's structured output | 2 days |

**Week 3-4: Dispatch & Branching**
| Feature | Description | Lovable Effort |
|---|---|---|
| Perspective dispatch panel | Trigger individual or all 5 perspectives | 2 days |
| Perspective call status | Polling-based progress indicator for each agent call | 1 day |
| Branch creation UI | Fork current Project State with name/description | 1 day |
| Branch list | Show all branches with status, timestamp, author | 1 day |

**Week 4-5: Export & Polish**
| Feature | Description | Lovable Effort |
|---|---|---|
| Export to Markdown | Generate .md file from Project State | 1 day |
| Export to HTML | Wrapped HTML document for sharing | 1 day |
| Session management | Create, resume, rename, delete sessions | 1 day |
| UI polish, error states, loading states | Complete UX | 2 days |
| Vercel deployment | Preview + production deploy pipeline | 1 day |

**Phase 1 Total: 5 weeks / ~$1,500 Lovable credits**

**MVP Deliverable:** A working single-user web app where a user can:
1. Sign up / sign in
2. Create a project with a goal
3. Trigger all 5 perspectives (which call Claude API via Edge Functions)
4. View and edit all 13 Project State dimensions
5. Create branches
6. Export to Markdown/HTML

### Phase 2 — Advanced Engine Integration

**Duration:** 4 weeks
**Gate:** Phase 1 deployed and validated with >=3 real users

| Feature | Description | Effort |
|---|---|---|
| Supabase Edge Functions | Server-side perspective dispatch with proper error handling | 1 week |
| Knowledge library browser | View library content by domain pack; search within libraries | 1 week |
| Specialist engine panel | Invoke Narrative, Persuasion, Sales, Decision engines | 3 days |
| Session comparison | Side-by-side diff of two sessions or branches | 3 days |
| Branch merge UI | Interactive merge with conflict markers per dimension | 2 days |
| Branch promote UI | Gate: all 5 perspectives must sign off | 1 day |

**Phase 2 Total: 4 weeks / ~$1,200 Lovable credits**

### Phase 3 — Multi-Tenant SaaS

**Duration:** 6 weeks
**Gate:** Phase 2 validated; >=5 active users; willingness to pay confirmed

| Feature | Description | Effort |
|---|---|---|
| Workspace system | Workspaces with membership; RLS by workspace_id | 1 week |
| Team collaboration | Shared Project States; comment threads | 1 week |
| Stripe billing | Subscription tiers; usage tracking; invoicing | 1 week |
| API key management | API keys for programmatic access | 3 days |
| Advanced export | PDF, deck (slide), risk register formats | 1 week |
| Admin panel | User management, workspace management | 1 week |

**Phase 3 Total: 6 weeks / ~$2,000 Lovable credits**

### Phase 4 — Platform Scale

**Duration:** 4 weeks
**Gate:** Commercial launch; >=20 paying users

| Feature | Description | Effort |
|---|---|---|
| Domain pack marketplace | Browse, install, and manage domain packs | 1 week |
| Custom perspective prompts | Users write and save custom perspective prompts | 1 week |
| Audit trail | Full event log for compliance use cases | 3 days |
| Single-tenant deployment | Docker compose or Vercel enterprise for large clients | 1 week |
| Usage analytics dashboard | Dashboard showing session counts, cost, popular features | 3 days |

**Phase 4 Total: 4 weeks / ~$1,200 Lovable credits**

### B2 Total Build Estimate

| Phase | Duration | Lovable Credits | Engineer Hours | Cumulative |
|---|---|---|---|---|
| Phase 1 (MVP) | 5 weeks | ~$1,500 | ~160 hrs | 5 weeks |
| Phase 2 (Advanced) | 4 weeks | ~$1,200 | ~120 hrs | 9 weeks |
| Phase 3 (Multi-tenant) | 6 weeks | ~$2,000 | ~200 hrs | 15 weeks |
| Phase 4 (Scale) | 4 weeks | ~$1,500 | ~120 hrs | 19 weeks |
| **Total B2** | **~19 weeks** | **~$6,200** | **~600 hrs** | **19 weeks** |

**Infrastructure Costs During Build:**
| Service | Plan | Monthly Cost |
|---|---|---|
| Supabase | Pro (launch) / Team (scale) | $25-599/mo |
| Vercel | Pro | $20/mo |
| Claude API (during dev) | Developer tier | $50-100/mo |
| Custom domain | Vercel included | $0 |
| **Total monthly infra** | | **$95-720/mo** |

**Personnel:**
- 1 engineer (full-stack, Lovable-experienced) — OPTIMOV internal
- AI pair (Lovable) — workspace credits
- Sam (content, spec, QA) — part-time during build
- Joel (product decisions, funding) — review gates

---

## 4. Domain Pack Production Plan

### Pack Manifest Template

Each domain pack will include:
```
domain-packs/<name>/
├── pack-manifest.md       # Which base libraries to load + pack metadata
├── objection-bank.md      # Domain-specific objection patterns (optional)
├── templates/             # Domain-specific output templates (optional)
└── examples/              # Example prompts and session configs (optional)
```

### Pack-by-Pack Production

**Priority 1: Venture Pack (3-4 days)**

Purpose: Venture ideation, business model design, GTM strategy, fundraising, governance

Content:
| File | Description | Author | Effort |
|---|---|---|---|
| pack-manifest.md | Load: Human Truths, Audience Intelligence, Objections, Marketing View | Sam | 0.5 day |
| objections/venture.md | Venture-specific objections (market timing, competition, TAM doubts) | Sam | 1 day |
| templates/gating-framework.md | CONDITIONAL-GO evaluation rubric | Sam | 1 day |
| templates/business-model-canvas.md | Venture canvas aligned to Project State dimensions | Sam | 1 day |
| examples/venture-session.md | Example RCM session config for venture ideation | Sam | 0.5 day |

Total: 3-4 days

**Priority 2: Product Pack (2-3 days)**

Purpose: Product development, UX research, roadmapping, feature prioritization

Content:
| File | Description | Effort |
|---|---|---|
| pack-manifest.md | Load: UI/UX, Objections, Marketing View | 0.5 day |
| templates/prd-template.md | Product requirements document aligned to Project State | 1 day |
| templates/acceptance-criteria.md | Acceptance criteria patterns per dimension | 0.5 day |
| examples/product-session.md | Example config for product concept validation | 0.5 day |

**Priority 3: Marketing Pack (2-3 days)**

Purpose: Campaign strategy, audience targeting, channel planning, creative briefs

Content:
| File | Description | Effort |
|---|---|---|
| pack-manifest.md | Load: Audience Intelligence, Media Hierarchy, Marketing View | 0.5 day |
| overrides/marketing-view.md | Marketing-specific positioning patterns | 1 day |
| templates/campaign-brief.md | Campaign brief template aligned to Project State | 1 day |

**Priority 4: Media Pack (2 days)**

Purpose: Content creation, visual design, narrative development

Content:
| File | Description | Effort |
|---|---|---|
| pack-manifest.md | Load: Visual Cognition, Media Composition, Human Truths | 0.5 day |
| overrides/media-composition.md | Media-specific composition extensions | 1 day |
| templates/storyboard-format.md | Storyboard format aligned to Project State | 0.5 day |

**Priority 5: Research Pack (1-2 days)**

Purpose: Deep research, evidence gathering, competitive analysis

Content:
| File | Description | Effort |
|---|---|---|
| pack-manifest.md | Load: Human Truths, Objections, Audience Intelligence | 0.5 day |
| templates/research-synthesis.md | Research synthesis format | 0.5 day |
| templates/evidence-standards.md | Evidence quality rubric | 0.5 day |

### Domain Pack Total

| Activity | Effort | Who |
|---|---|---|
| Venture pack | 3-4 days | Sam |
| Product pack | 2-3 days | Sam |
| Marketing pack | 2-3 days | Sam |
| Media pack | 2 days | Sam |
| Research pack | 1-2 days | Sam |
| **Total** | **10-14 days** | Sam (primary); venture leads for review |

---

## 5. Knowledge Library Completion & Sync Plan

### Critical Finding: Libraries Already Authored

All 8 base libraries were authored by Sam on 2026-06-28 and exist in Confluence with substantial content. The library-registry.json is stale — it shows "not yet created" for all libraries. This changes the plan: the work is not authoring, but syncing and maintaining.

### What's Actually Needed

**Step 1: Sync All 8 Libraries to Local (1 day)**

The sync-libraries.sh script exists but doesn't actually call the Confluence API — it relies on Claude Code MCP tools invoked within a session via `/rcm sync-libraries`. The actual sync needs the PowerShell script from the B1 scaffold (confluence-sync.ps1) or direct MCP tool calls.

Recommended approach: Write a PowerShell script that uses the Confluence MCP tools (get_page_content) to pull each library and write to disk.

| Library | Confluence ID | Local target |
|---|---|---|
| Human Truths | 199131358 | references/libraries/base/human-truths.md |
| Audience Intelligence | 199655427 | references/libraries/base/audience-intelligence.md |
| Objections | 199852033 | references/libraries/base/objections.md |
| Visual Cognition | 199753730 | references/libraries/base/visual-cognition.md |
| Media Hierarchy | 199098547 | references/libraries/base/media-hierarchy.md |
| Media Composition | 199360575 | references/libraries/base/media-composition.md |
| UI/UX | 199360596 | references/libraries/base/ui-ux.md |
| Marketing View | 199688210 | references/libraries/base/marketing-view.md |

**Effort:** 1 day (engineering) — write PS1 script, run it, verify all files, update registry

**Step 2: Add Provenance Headers to Synced Files (0.5 day)**

Each synced file must carry:
```markdown
<!-- source: Confluence page ID XXXXXXX, version N, synced YYYY-MM-DD -->
```

The sync script should auto-add this. If manual, add during first sync.

**Step 3: Update library-registry.json (0.5 day)**

Current state: all 8 entries show `"status": "not yet created"`.
Correct to: `"status": "active"`, add `"confluencePageId"`, `"version": 1`, `"synced": "2026-06-28"`.

**Step 4: Establish Sync Cadence (0.5 day)**

Options:
- **Manual on change**: Author updates Confluence page, runs sync manually. Recommended for now (low volume).
- **Weekly cron**: Crontab or scheduled GitHub Action. Overkill for current content velocity.
- **On session start**: RCM skill checks library freshness on `/rcm` invocation. Nice-to-have.

Recommendation: Manual on change for now; revisit at >5 active weekly users.

**Step 5: Content Maintenance (ongoing)**

| Activity | Frequency | Owner |
|---|---|---|
| Content review | Monthly | Sam |
| Version bumps | On substantive changes | Sam |
| New library creation | As needed | Sam (new topic) |

**Remaining Content Work:**

| Library | Current State | What's Needed | Effort |
|---|---|---|---|
| Human Truths | Complete v1 | None urgent | — |
| Audience Intelligence | Complete v1 | None urgent | — |
| Objections | Complete v1 | None urgent | — |
| Visual Cognition | Complete v1 | None urgent | — |
| Media Hierarchy | Complete v1 | None urgent | — |
| Media Composition | Complete v1 | None urgent | — |
| UI/UX | Complete v1 | None urgent | — |
| Marketing View | Complete v1 | None urgent | — |

**Total: 2.5 days** for sync + registry update + cadence setup. Not 8+ days of authoring.

---

## 6. Skill Distribution Plan

### Recommended Model: Open Engine / Proprietary Libraries

```
Public (GitHub / Claude Registry)         Private (Confluence / OPTIMOV)
┌──────────────────────────────┐          ┌──────────────────────────────┐
│ Engine: MIT License          │          │ Knowledge Libraries:         │
│                              │          │ Proprietary, Confluence-hosted│
│ .claude/skills/rcm/          │          │ Layer 05 — Venture-local     │
│ ├── SKILL.md                 │          │                              │
│ ├── templates/               │          │ Access via Confluence auth   │
│ │   └── perspective-prompts/ │          │ Not in public repo           │
│ ├── scripts/sync-libraries.sh│          │ Not in public skill registry │
│ └── references/              │          │ ──────────────────────────── │
│     └── project-state.md     │          │ Domain Packs:                │
│                              │          │ Venture, Product, etc.       │
│ Published as reference       │          │ Extend base libraries        │
│ implementation of 02.10      │          │ Not in public repo           │
└──────────────────────────────┘          └──────────────────────────────┘
```

### Distribution Paths

**Path A: Workspace-Only (Recommended for now)**
- Skill stays in `.claude/skills/optimo-rcm/`
- No public distribution
- No licensing decisions needed
- Libraries stay in Confluence, synced locally
- **Time: 0 days**

**Path B: Public Claude Code Registry (Future, after B2 validation)**
- Submit skill to Anthropic's skill registry
- Engine only (no libraries)
- MIT license
- Requires README, screenshots, and usage examples
- **Time: 1-2 days packaging + registry submission wait**

**Path C: GitHub Public Repo (Future, after B2 launch)**
- Create public repo at github.com/optimoventures/rcm
- Engine + templates + scripts only
- Libraries excluded (refer to Confluence)
- MIT license
- Requires CI/CD, issue templates, contribution guidelines
- **Time: 2-3 days setup**

### B2 SaaS Licensing (if/when built)

| Plan | Price | What's Included | Libraries Access |
|---|---|---|---|
| Free | $0 | 3 sessions, Explorer only | Human Truths only |
| Personal | $15-25/mo | 20 sessions, all 5 perspectives | 8 base libraries |
| Team | $75-100/mo | 100 sessions, team sharing | All libraries + 1 domain pack |
| Enterprise | $500-5,000/mo | Unlimited, custom models, SSO | All libraries + all packs |

### Recommendation

1. **Immediately:** Stay workspace-only (Path A). No action needed.
2. **After B2 MVP launch:** Publish engine to GitHub (Path C) with MIT license. Build community credibility.
3. **After B2 Phase 3 (commercial launch):** Optionally submit to Claude Code registry (Path B) for discovery.

---

## 7. Dependencies & Critical Path

### Dependency Graph

```
                    ┌─────────────────┐
                    │  C1 — 02.10      │
                    │  CANON EXISTS     │
                    └────────┬─────────┘
                             │ (already cleared)
                             ▼
                    ┌─────────────────┐
                    │  C5 — B1         │
                    │  VALIDATED       │
                    └────────┬─────────┘
                             │ (already cleared)
              ┌──────────────┼──────────────┐
              │              │              │
              ▼              ▼              ▼
    ┌─────────────────┐ ┌──────────┐ ┌──────────────┐
    │ C2-B2 — B2      │ │ C3 — Cost│ │ C6 — Domain  │
    │ FUNCTIONAL SPEC  │ │ MODEL    │ │ PACKS        │
    └────────┬─────────┘ └────┬─────┘ └──────┬───────┘
             │                │              │
             └────────────────┼──────────────┘
                              │
                              ▼
                    ┌─────────────────┐
                    │  B2 PHASE 1     │
                    │  MVP WEB APP    │
                    └────────┬─────────┘
                             │
              ┌──────────────┼──────────────┐
              │              │              │
              ▼              ▼              ▼
    ┌─────────────────┐ ┌──────────┐ ┌──────────────┐
    │ C4 — TelosAI    │ │ C7 —     │ │ B2 PHASE 2   │
    │ OVERLAP         │ │ DISTRIB- │ │ ADV ENGINE   │
    │ (needs resol'n  │ │ UTION    │ │              │
    │  before B2      │ │ (needs   │ │              │
    │  commercial)    │ │ before   │ │              │
    │                 │ │ public)  │ │              │
    └─────────────────┘ └──────────┘ └──────┬───────┘
                                            │
                                            ▼
                                   ┌─────────────────┐
                                   │  B2 PHASE 3     │
                                   │  MULTI-TENANT   │
                                   └────────┬─────────┘
                                            │
                                            ▼
                                   ┌─────────────────┐
                                   │  B2 PHASE 4     │
                                   │  PLATFORM SCALE │
                                   └─────────────────┘
```

### Critical Path

The critical path goes through:
1. **C2-B2 spec** (2-3 days) → not on critical path by itself, but gates B2 Phase 1
2. **B2 Phase 1 MVP** (5 weeks) — the longest single item and the only one that produces a shippable B2
3. **B2 Phase 2** (4 weeks) — gates Phase 3
4. **C3 cost model** (3-4 days) — must be done before Phase 3 commercial pricing
5. **C4 TelosAI** (2-3 days) — must be done before Phase 3 commercial launch (not technically blocking build)
6. **B2 Phase 3** (6 weeks) — gates commercial launch
7. **C7 distribution** (2 days) — must be done before Phase 3 public launch

**Minimum timeline to B2 MVP:**
```
C2-B2 spec (Sam, 5 days) → B2 Phase 1 (1 eng + AI, 5 weeks)
Total: ~6 weeks
```

**Minimum timeline to B2 commercial launch (Phase 3):**
```
C2-B2 spec → B2 Phase 1 → B2 Phase 2 → C3 + C4 (in parallel with Phase 2) → B2 Phase 3 → C7
Total: ~15-17 weeks
```

### What Can Run in Parallel

| Parallel Track A | Parallel Track B | Parallel Track C |
|---|---|---|
| C2-B2 spec | C3 cost model | C6 domain packs |
| B2 Phase 1 | C4 TelosAI | Library sync |
| B2 Phase 2 | C7 distribution | Domain pack testing |
| B2 Phase 3+ | | |

Track A is the critical path. Tracks B and C can parallelize entirely.

### Resource Bottlenecks

| Resource | Bottleneck Risk | Mitigation |
|---|---|---|
| Sam (content, spec, domain packs) | Single point of failure for Tracks B+C | Venture leads can review; Sam prioritizes C6 (venture pack) first |
| 1 engineer + AI (Lovable) | Standard OPTIMOV velocity; queue if other ventures | No ventures currently building on Lovable that compete |
| TelosAI lead availability | C4 blocked if TelosAI lead unavailable | Schedule boundary discussion early |
| Joel (CEO) sign-off | Blocks C2-B2, C3 pricing, C7 distribution | Batch all Joel decisions into 2-3 review sessions |

---

## 8. Total Build Estimate

### Phased Timeline

| Phase | Duration | Start Week | End Week | Dependencies |
|---|---|---|---|---|
| **Conditions clearing** | 10-14 days | Week 0 | Week 2 | None (all parallel) |
| C2-B2 spec (Sam) | 2-3 days | Week 0 | Week 0.5 | None |
| C3 cost model (Sam+Joel) | 3-4 days | Week 0 | Week 1 | None |
| C6 domain packs (Sam) | 10-14 days | Week 0 | Week 2 | None |
| Library sync (eng) | 2.5 days | Week 0 | Week 0.5 | None |
| C4 TelosAI (Sam+TELO) | 2-3 days | Week 1 | Week 1.5 | TelosAI lead |
| C7 distribution (Joel) | 2 days | Week 2 | Week 2.5 | Earlier conditions |
| **B2 Phase 1 (MVP)** | **5 weeks** | **Week 3** | **Week 8** | C2-B2 cleared + Joel GO |
| B2 Phase 2 (Advanced) | 4 weeks | Week 8 | Week 12 | Phase 1 done |
| C3 + C4 complete by | | | Week 12 | Before Phase 3 |
| **B2 Phase 3 (Multi-tenant)** | 6 weeks | Week 12 | Week 18 | Phase 2 + C3 + C4 |
| C7 final decision | | | Week 17 | Before public launch |
| B2 Phase 4 (Scale) | 4 weeks | Week 18 | Week 22 | Phase 3 done |

**Total: 22 weeks from start to full platform**

### Cost Summary

| Category | B2 Phase 1 | B2 Full (Phases 1-4) | Annual Run Rate |
|---|---|---|---|
| **Lovable credits** | $1,500 | $6,200 | $0 (build phase only) |
| **Supabase** | $25/mo | $25-599/mo | $300-7,200/yr |
| **Vercel** | $20/mo | $20-200/mo | $240-2,400/yr |
| **Claude API (dev)** | $50-100/mo | $50-200/mo | $600-2,400/yr |
| **Personnel (engineer)** | $0 (internal) | $0 (internal) | $0 (internal) |
| **Personnel (Sam content)** | Part-time | Part-time | Part-time |
| **Domain names** | $0 (Vercel) | $15/yr | $15/yr |
| **Total cash cost** | **~$400-600/mo** | **~$500-2,000/mo** | **~$1,155-12,015/yr** |
| **Total build cash cost** | **~$2,000-3,000** | **~$8,000-15,000** | |

### People Required

| Role | Phase 1 | Phase 2 | Phase 3 | Phase 4 |
|---|---|---|---|---|
| Full-stack engineer (Lovable) | 1 FTE | 1 FTE | 1 FTE | 1 FTE |
| Content author (Sam) | 0.25 FTE | 0.25 FTE | 0.1 FTE | 0.1 FTE |
| Product decisions (Joel) | Review gates | Review gates | Active | Active |
| TelosAI coordination | None | Boundary discussion | None | None |
| **Total people** | **2** | **2** | **2** | **2** |

### Key Milestones & Decision Gates

| Milestone | Week | What Ships | Go/No-Go Decision |
|---|---|---|---|
| M0 — All conditions cleared | Week 2 | None (paperwork) | Joel: "Start B2" |
| M1 — B2 MVP launch | Week 8 | Single-user web app | Joel: "Continue to Phase 2" |
| M2 — B2 Advanced launch | Week 12 | Full engine + branching + library browser | Joel: "Validated, proceed to commercial" |
| M3 — B2 Commercial launch | Week 18 | Multi-tenant SaaS with billing | Revenue target: 20 paying users |
| M4 — B2 Scale launch | Week 22 | Full platform + marketplace | Revenue target: $5k MRR |

---

## 9. Risk & Contingency

### Top Risks

| Risk | Probability | Impact | Mitigation |
|---|---|---|---|
| Sam content bottleneck (domain packs + spec) | 0.6 | High | Prioritize venture pack first; defer less-critical packs; engage venture leads |
| B2 competitive positioning failure | 0.4 | High | Validate with 5 external design partners before Phase 3 investment; if no WTP, kill B2 at M1 gate |
| Claude API adds native multi-perspective reasoning | 0.3 | Very High | Knowledge libraries become the moat instead; pivot to library-as-a-service |
| Joel declines to fund B2 at M0 gate | 0.3 | Critical | B2 stops; B1 continues as internal tool only |
| Inference costs higher than modeled | 0.4 | Medium | Cache system prompts aggressively; offer Haiku tier for price-sensitive users |
| TelosAI integration conflicts | 0.3 | Medium | Resolve C4 early (Week 1-2); boundary agreement prevents future conflicts |

### Contingency Plans

**If B2 not authorized at M0:**
- Conditions clearing effort is ~$0 (Sam's time, no cash cost)
- B1 continues as internal tool
- Knowledge libraries remain Confluence-only, synced locally
- No loss; C5 validation already delivered value to ventures

**If B2 fails to gain traction by M2:**
- Kill B2 after Phase 2 (total cost: ~$4,500 + 9 weeks)
- Pivot to only B1 + public GitHub release
- Knowledge libraries remain the moat; community builds on MIT engine

**If Claude ships native multi-perspective reasoning:**
- Engine commoditizes (expected — MIT license, pattern is open)
- Libraries become the defensible product
- Pivot B2 to "Knowledge Library Platform" — not the reasoning engine but the content

---

## Appendix: Key Decisions Required

| Decision | Must Be Made By | Options | Recommended |
|---|---|---|---|
| B2 build authorization | Joel (M0 gate, Week 2) | Go / No-go | Go if all conditions cleared |
| B2 pricing | Joel (Week 12, before Phase 3) | $15-25 Personal / $75-100 Team / $500+ Enterprise | Start at $19/$79/$499 |
| Distribution model (C7) | Joel (Week 17, before public launch) | Workspace-only / GitHub / Registry | GitHub engine (MIT) + proprietary libraries |
| TelosAI boundary (C4) | Sam + TELO lead (Week 1-2) | RCM subsumes / separate | RCM orchestrates; TelosAI configures |
| Engineer assignment | Joel (Week 3) | Internal / contracted | Internal (OPTIMOV) |
| Free tier scope | Joel (Week 12) | 3 sessions vs 10 vs unlimited | 3 sessions, Explorer only |
