# Asset — Venture Genesis Hub Body Scaffolds

Fill the `{{placeholders}}`. Keep each page's header block. Use Confluence HTML when calling
`createConfluencePage` with `contentFormat=html`; the structures below map cleanly to it
(headings, tables, panels, task lists). Preserve and add labels — never strip.

---

## Hub landing page — `{{Venture}} — Program Genesis HUB`

```
# {{Venture}} — Program Genesis HUB

**Owner:** {{Owner}} | **Status:** 🟢 Active | **Updated:** {{YYYY-MM-DD}}
_Parent: 05.02 — Ventures_

## Thesis
{{One-line thesis and the problem it solves.}}

## Finance & Governance Inheritance
> This venture inherits and operates subject to 01.03.07 — GAAP Financial Accounting Canon,
> 04.01.01 — GAAP Month-End Close Operating Procedure, and 03.01.FIN — Venture Finance
> Minimum Viable Controls Template.

## Build Standard
Default Optimo build stack: **Lovable** (front-end/build) + **Supabase** (auth/Postgres/RLS/
storage/edge functions) + **Vercel** (deploy/preview/prod).
{{State "No exception" or document the approved exception + justification.}}

## Hub Index
1. Program Genesis (Narrative)
2. Cortex Reasoning & Decisions
3. Functional Specification (Living)
4. Build Incubation (Pre-Executable)
4a. Technical Architecture
5. Executable Prompts (Lovable)
6. Build Outputs & Artifacts
7. Jira Execution & State
8. Audit, Traceability & Provenance
```

---

## 1 — Program Genesis (Narrative)
```
# {{Venture}} — 1 — Program Genesis (Narrative)
**Owner:** {{Owner}} | **Status:** 🟢 Active | **Updated:** {{YYYY-MM-DD}}

## Founding context
## Problem & opportunity
## Thesis & differentiation
## Target users / market
## Success definition
```

## 2 — Cortex Reasoning & Decisions
```
# {{Venture}} — 2 — Cortex Reasoning & Decisions
**Owner:** {{Owner}} | **Status:** 🟢 Active | **Updated:** {{YYYY-MM-DD}}

## Key decisions (ADR-style: context → decision → consequences)
## Model / agent choices (ref: 02 — OptimoCortex™, 02.06 Model Registry)
## Open questions
```

## 3 — Functional Specification (Living)
```
# {{Venture}} — 3 — Functional Specification (Living)
**Owner:** {{Owner}} | **Status:** 🟢 Living | **Updated:** {{YYYY-MM-DD}}

## Scope (Lovable-first)
## Core features / user stories
## Screens & flows
## Data entities (Supabase-first)
## Non-functional requirements
```

## 4 — Build Incubation (Pre-Executable)
```
# {{Venture}} — 4 — Build Incubation (Pre-Executable)
**Owner:** {{Owner}} | **Status:** 🟡 Pre-Executable | **Updated:** {{YYYY-MM-DD}}

## Architecture sketch
## Supabase data model draft (DDL)
## Integrations & dependencies
## Risks / unknowns to resolve before build
```

## Technical Architecture  (standard — placed after Build Incubation)
```
# {{Venture}} — Technical Architecture
**Owner:** {{Owner}} | **Status:** 🟢 Active | **Updated:** {{YYYY-MM-DD}}

## System overview (Lovable front-end / Supabase backend / Vercel delivery)
## Components & data flow
## Supabase schema & RLS model
## Integrations, MCP & automation patterns
## Security, secrets & environments
## Architecture decisions (link to section 2)
```

## 5 — Executable Prompts (Lovable)
```
# {{Venture}} — 5 — Executable Prompts (Lovable)
**Owner:** {{Owner}} | **Status:** 🟢 Active | **Updated:** {{YYYY-MM-DD}}

## Build prompt v1.0
## Subsequent prompt iterations (versioned)
```

## 6 — Build Outputs & Artifacts
```
# {{Venture}} — 6 — Build Outputs & Artifacts
**Owner:** {{Owner}} | **Status:** 🟢 Active | **Updated:** {{YYYY-MM-DD}}

## Deployed environments (Vercel preview/prod URLs)
## Repositories (GitHub)
## Decks / primers / investor materials
## Output reviews
```

## 7 — Jira Execution & State
```
# {{Venture}} — 7 — Jira Execution & State
**Owner:** {{Owner}} | **Status:** 🟢 Active | **Updated:** {{YYYY-MM-DD}}

## Epic: {{KAN-XXX}}
## Stories (mirror of Jira; link each)
## Current sprint / state
```

## 8 — Audit, Traceability & Provenance
```
# {{Venture}} — 8 — Audit, Traceability & Provenance
**Owner:** {{Owner}} | **Status:** 🟢 Active | **Updated:** {{YYYY-MM-DD}}

## Change log (date — change — author — version message)
## Provenance of key decisions
## Evidence pointers (Compliance Library 04)
```
