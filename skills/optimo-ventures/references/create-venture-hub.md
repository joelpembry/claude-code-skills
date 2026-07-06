# Playbook — Create a Venture / Application Genesis Hub (End-to-End)

This is the flagship workflow. It produces a new venture's complete Genesis Hub under
`05.02 — Ventures` (parent page `72220673`, space `OPTIMOV` / `71598082`), wired to canon,
finance, the build standard, and Jira. **Default mode is DRY_RUN** — plan the whole hub,
show it, and execute only on explicit COMMIT.

## Inputs to gather first

Ask only for what's missing; infer the rest from analogous hubs.
- **Venture name** (exact, including any ™) and a one-line thesis.
- **Domain** (e.g. life sciences, fintech, infra) → picks the closest existing template:
  `03.01.LS` for life sciences/Nebius-backed; otherwise the generic `03.01` gestation model.
- **Build-stack exception?** Default is Lovable + Supabase + Vercel; only deviate if stated.
- **Any Hero Partner / investor context** (some hubs add partner-doctrine and pitch pages).

## Pre-flight checks (DRY_RUN, read-only)

1. Confirm the venture isn't already registered — search `01.04 — Canonical Registries`
   (`71368725`) and existing hub titles under `72220673`. If it exists, switch to "update,"
   not "create."
2. Confirm naming: hub will be titled exactly `<VentureName> — Program Genesis HUB`.
3. Confirm the three finance-inheritance targets exist (`87490562`, `87556097`, `87588865`).

## The canonical hub structure

Create the hub page, then the standard sub-pages **in order**. Section names follow the
canonical sequence used across MolDesignAI, MedAppealAI, OptimoCares+, GenesisGrid™, etc.
Use the venture's own short prefix if it has one (e.g. "OG 1 —", "MA …"), otherwise the
plain section title. The 8 canonical sections:

1. **Program Genesis (Narrative)** — the why, thesis, market, founding context.
2. **Cortex Reasoning & Decisions** — key reasoning, ADRs, model/agent decisions (ties to 02).
3. **Functional Specification (Living)** — Lovable-first functional spec; "living" doc.
4. **Build Incubation (Pre-Executable)** — pre-build design, data model sketch, architecture.
5. **Executable Prompts (Lovable)** — the actual Lovable build prompts.
6. **Build Outputs & Artifacts** — what got built; links to repos, decks, outputs.
7. **Jira Execution & State** — mirror of the venture's Jira epics/stories and status.
8. **Audit, Traceability & Provenance** — change log, provenance, evidence pointers.

**Always also add a Technical Architecture page**, placed immediately after Build Incubation
(between sections 4 and 5), titled `<Venture> — Technical Architecture`. This is standard
across hubs (e.g. MedAppealAI's "Technical Architecture — MCP & Automation Patterns",
OptimoCares+'s "Technical Architecture", GenesisGrid™'s "Architecture & System Design Canon").
Where relevant, also add a **Hero Partner Doctrine** page — that one stays optional, added when
investor/partner context exists.

The hub landing page itself should contain: the one-line thesis, the **finance-inheritance
pointer** (verbatim below), the build-stack declaration (or documented exception), a child-page
index, and the `Owner / Status / Updated` header block.

### Required finance-inheritance pointer (paste into the hub landing page)

> This venture inherits and operates subject to 01.03.07 — GAAP Financial Accounting Canon,
> 04.01.01 — GAAP Month-End Close Operating Procedure, and 03.01.FIN — Venture Finance
> Minimum Viable Controls Template.

Use `assets/venture-hub-template.md` as the body scaffold for each page.

## Build order (the connector calls)

All `createConfluencePage` calls use `cloudId=a9042b7c-96da-42c2-bb54-4c2209c67b3d`,
`spaceId=71598082`, `contentFormat=html` (or `markdown`).

1. Create hub landing page, `parentId=72220673`, title `<Venture> — Program Genesis HUB`.
2. Capture the returned hub page ID; create the 8 sub-pages with `parentId=<hubId>`, in order,
   **plus the standard `<Venture> — Technical Architecture` page after Build Incubation** (and
   a Hero Partner Doctrine page if investor/partner context exists).
3. Add the build-standard + finance pointers on the landing page (already in the template).
4. **Register** the venture in `01.04 — Canonical Registries` (`71368725`) — add a row/entry
   (name, owner, status, hub link, created date). 05.01 only points to 01.04, so register in 01.
5. **Bootstrap Jira** (see `jira-orchestration.md`): create the venture epic in project `KAN`
   and seed the initial stories from the Functional Spec; then reflect them on the hub's
   "Jira Execution & State" page.
6. Apply labels consistently (e.g. a venture slug label) — never strip existing labels.

## DRY_RUN output format

Present a numbered plan: every page to be created (title → parent → 1-line body summary),
the registry entry, the Jira epic/stories, and the full ordered list of connector calls.
End with: `Mode: DRY_RUN. Reply "COMMIT" to create the hub, register the venture, and
bootstrap Jira.`

## On COMMIT

Execute in the build order above. After creation:
- Verify each page exists and is correctly parented (re-read the tree).
- Append an entry to the hub's Audit/Traceability page and a Reorg Report under `70877186`.
- Return the live links to the hub and its sub-pages, the registry entry, and the Jira epic.

## Guardrails specific to hub creation

- Do not weaken or re-state canon inside the venture — **link** to 01/03/04 pages.
- If a build-stack exception is requested, it must be written into the Genesis + Technical
  Architecture pages with justification before any build prompt is authored.
- If confidence on domain/template choice is < 0.80, ask rather than assume.
