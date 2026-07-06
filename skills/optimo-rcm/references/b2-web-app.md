# B₂ — Web Application

The RCM Platform™ web app is a visual UI layer for non-CLI users. It wraps the B₁ skill's
Project State format into an interactive dashboard.

**Status:** CONDITIONAL-GO — deferred until B₁ validates the engine (C5).

## Build stack (standard OPTIMOV)
- **Front-end:** Lovable (TanStack Start + React 19 + Tailwind v4 + shadcn/Radix)
- **Backend:** Supabase (auth + Postgres + RLS + storage + edge functions)
- **Deploy:** Vercel (preview + prod)

## Gate conditions (must ALL clear before B₂ build authorization)

| Condition | Description | Current Status |
| --- | --- | --- |
| C1 | 02.10 canon exists | ✅ CLEARED |
| C2 | B₂ functional spec complete | PENDING — B₁ spec complete, B₂ spec not yet authored |
| C3 | AI orchestration cost model validated | PENDING |
| C5 | B₁ validated with ≥1 real dogfood use case | IN PROGRESS |
| C6 | Venture domain pack content drafted + synced | PENDING |

**Note:** C4 (TelosAI overlap resolution) and C7 (distribution decision) apply to B₁; they do
not block B₂ specifically, but should be resolved before B₂ launch to avoid positioning conflict.

## Role and positioning

- B₂ is the **non-CLI surface** for the same engine that runs in B₁
- It reads and writes Project State in the same schema as B₁
- It does NOT replace B₁; it extends reach to users without Claude Code
- Target users: OPTIMOV team members, venture stakeholders, clients

## Functional spec (B₂) — when C2 is cleared, document here

The B₂ spec must cover:
1. Project State viewer and editor (all 13 dimensions, UI)
2. Perspective dispatch panel — trigger individual or all perspectives
3. Branching UI — create, compare, merge, promote, archive branches
4. Knowledge library browser — load/view library content by domain pack
5. Session management — create, resume, export sessions
6. Specialist engine invocation panel
7. Export templates — brief, spec, risk register, deck

## Venture hub creation (when C5 clears)

The venture hub will be created under `05.02 — Ventures` (id `72220673`):

```
RCM Platform™ — Program Genesis HUB
├── Program Genesis
├── Cortex Reasoning (link to 02.10 — do NOT duplicate)
├── Functional Specification
├── Build Incubation
├── Technical Architecture
├── Executable Prompts
├── Build Outputs & Artifacts
├── Jira Execution & State
└── Audit / Traceability
```

Use `optimo-ventures` build skill (`create-venture-hub` playbook) to scaffold the hub.
Pass: venture name = "RCM Platform™", thesis, domain = product/AI tool.

## Jira epic scaffold (when hub is created)

Minimum epics for B₂:
1. Project State API & schema (Supabase)
2. Perspective dispatch engine (Supabase Edge Functions / API)
3. Session management (create, resume, export)
4. Branching system (compare, merge, promote, archive)
5. Knowledge library sync + browser
6. Specialist engine invocation
7. UI — Project State viewer/editor
8. UI — Dashboard and navigation
9. Auth, RLS, and access control
10. Production deployment and monitoring
