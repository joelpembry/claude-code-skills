# Reference — Disposition Playbook (A / B / C / D)

How to place an ideation in the ecosystem. Always read the *live* workspace before deciding;
the ecosystem evolves. cloudId `a9042b7c-96da-42c2-bb54-4c2209c67b3d`, space `OPTIMOV`
(`71598082`).

## Anchors this skill needs

| Page ID | What | Use |
| --- | --- | --- |
| `71368725` | 01.04 — Canonical Registries | Source of truth for what already exists |
| `71008296` / `71761921` / `70877225` | 01 Codex / 02 Cortex / 03 Agile | Foundation extension targets (A) |
| `72089601` | 05 — Venture & Application Genesis Hubs | Parent for staging + hubs |
| `72220673` | 05.02 — Ventures | All venture hubs (overlap check + sidecar attach) |
| `71729153` | 01.03 — Compliance Canon | Risk dimension |
| `88604696` | OptimoLand Enrichment Sidecar (exemplar) | Sidecar pattern reference |

To enumerate current ventures/sidecars: `getPagesInConfluenceSpace(71598082)` (paginate) and
filter, or Rovo `search` / CQL by title. If the `optimo-ventures` skill is installed, its
`references/workspace-map.md` has the fuller anchor list.

## Decide the disposition

Run these reads, then choose:

1. **Overlap scan.** Search registry + hub titles + sidecars for adjacency to the idea's core.
2. **Capability vs product test.** Would *every* venture consume this (→ A, Foundation)? Or does
   it augment *one* venture (→ B, Sidecar)? Or is it a standalone product with its own users and
   revenue (→ C, Venture Hub)?
3. **Dual-nature test (→ H).** Does it contain BOTH a reusable canonical core AND a product
   surface? Apply the **separability test**: the core must be reusable beyond this one idea
   (≥ 2 prospective consumers) AND each component must independently clear its gate. If yes, it's
   a Hybrid — decompose it (below). If the "canonical" part is idea-specific, it is NOT A; collapse
   to B or C.
4. **Non-destructive test (for B).** Does it enrich/observe without owning the host venture's
   core writes? Sidecars are non-destructive by default; writeback is guarded and approval-gated.
5. **Showstopper scan.** Compliance/legal/IP blocker, or clear duplication → D (with reasons).

State the chosen disposition, the runner-up, and confidence. If A vs B vs C vs H is within ~1 point
of weighted score or confidence < 0.80, present the alternatives and let the human pick. Do not
inflate to a Hybrid to avoid a decision — the separability test is the gate against that.

## Hybrid (H) decomposition

A Hybrid is handled as a **set of linked components**, not a single thing:

1. **Identify the canonical core** — the reusable primitive/rule/agent/contract. Name its target
   page in 01/02/03 and its ≥ 2 prospective consumers. This is the **A** component.
2. **Identify the product surface(s)** — a sidecar on a named host venture (**B**) and/or a new
   standalone venture (**C**).
3. **Score each component separately** on the rubric (each gets its own row-set and gate).
4. **Sequence:** A first (canon must exist before consumption), then B and/or C, each **linking
   back** to the new canon — never duplicating it (honors "canon in 01; products link").
5. **Graceful degradation:** drop any component that fails its gate; the disposition becomes the
   passing subset (e.g. A+C where C fails → A alone; A+B+C where B fails → A+C).

Recognized forms and what they mean:
- **A+B** — canonize a reusable capability AND deploy it as a sidecar on an existing venture.
- **A+C** — canonize a reusable primitive AND stand up a new venture that consumes it (studio ideal).
- **B+C** — serve an existing venture as a sidecar AND, in parallel, stand up a new venture for a
  different market/segment using the same capability.
- **A+B+C** — full stack: canon + sidecar on an existing venture + a new venture, all linked to the canon.

## What each handoff produces (only after gate + approval)

### A — Extend the Foundation
- Identify the exact target page(s) in 01/02/03 and propose **additive** canonical edits (new
  section, contract, registry entry). Never weaken existing canon. Route through the
  optimo-ventures governance playbook in DRY_RUN; bump `Updated:` and pass a version message.

### B — Sidecar (new or extend existing)
Attach under the host venture's hub (child of that hub page). Model the structure on the
OptimoLand Enrichment Sidecar. **Sidecar scaffold spec** (the pages to plan):
1. `<Venture> <Sidecar> — Architecture, Governance & Pilot Operations` (parent)
2. `… — Data Model` (reference data, enriched read-only views)
3. `… — Source Intake & Workflow` (ingestion, versioning, parser model)
4. `… — Governance & RLS Model` (approval structure, row-level security posture)
5. `… — Operations & Health` (alerting, retry/recovery, freshness)
6. `… — Pilot Rollout Plan` (cohorts, gating, promotion criteria)
7. `… — Future Writeback Design` (guarded, disabled-by-default, approval-gated)
Non-destructive by default; any writeback to production entities is explicitly approval-gated.
If extending an existing sidecar, propose additive pages/sections only.

### C — New Venture Hub
Hand to the **optimo-ventures `create-venture-hub`** workflow. Provide: venture name (with any ™),
one-line thesis, domain (drives template choice — life-sciences/Nebius vs generic), and the
spec seeds surfaced in assessment. That workflow handles the 8 canonical sections + Technical
Architecture, finance inheritance, registry entry, and Jira bootstrap — in DRY_RUN then COMMIT.

### H — Hybrid (sequenced)
Execute the components in dependency order: **A first** (create/extend the canonical core in
01/02/03), then **B and/or C**, each linking back to that canon. Each component runs DRY_RUN →
COMMIT and is approved independently. A CONDITIONAL-GO product surface can be deferred while the
canon lands now. Record all components and their links on the assessment report.

### D — No-Go / Park
File the NO-GO report with the blocking reason(s) and the conditions that would flip the verdict.
No promotion. Parking is legitimate — record it so the idea isn't re-litigated from scratch.
