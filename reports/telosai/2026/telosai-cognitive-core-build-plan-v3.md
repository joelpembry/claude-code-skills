# TelosAI™ — Cognitive Core Build Plan v3
**Option 1 · Non-Breaking Adaptation onto the authoritative build** · 2026-07-10 · PLANNING/DRY_RUN

- **Production:** telosai.optimoventures.ai = aim-loop-map.lovable.app
- **Authoritative build:** Lovable 14c4acd4 · commit 5e650835
- **Genesis Hub:** Confluence 101548033

## 0 · Decision — reconciliation resolved (Option 1)
Joel confirmed (2026-07-10): the published app at **telosai.optimoventures.ai** is the **same** as **aim-loop-map.lovable.app**, and the **Lovable build is authoritative**. The roadmap v2's "German placeholder / build-from-scratch / Next.js" premise was written against the bare `telosai.com` placeholder — not the real app. Roadmap v2 is therefore incorporated as an **additive, flag-gated enhancement** of the shipped Aim Clarity Hub, **not** a greenfield rebuild. Roadmap Phase 0 (German cleanup) is largely **N/A**.

## 1 · Non-breaking mandate (hard constraint)
| # | Guardrail |
|---|---|
| G1 | Branch/version isolation; prod pinned to current build until explicit promotion |
| G2 | Everything flag-gated, default OFF in prod (`VITE_TELOS_PSYCH_MATRIX_V2`, `VITE_TELOS_LOOPS_UI`, `VITE_TELOS_LIBRARY_LOOKUP`, `VITE_TELOS_MATURATION`); O1–O5 flags untouched |
| G3 | Additive schema only (new tables/columns, FORCE RLS, nullable, backfill-safe); no ALTER/DROP on existing 28 `telos_*` tables |
| G4 | Additive routes/components/edge functions; 18 existing routes + 31 edge fns intact; new output at new route `/app/portrait` |
| G5 | Existing flows keep working (two-path equivalence wrapped, not replacing) |
| G6 | Validation gate before any prod flip; defaults OFF until UAT |
| G7 | Instant rollback (flags off); rollback point = commit 5e650835 + pre-flight Supabase backup |

## 2 · What roadmap v2 adds
- **Visibility model:** RTOS 8-stage = engine-internal (hidden); **RTPL Inner + Outer Loops = user-facing** signature output.
  - Outer Loop (4): Ordered Past → Present Awareness → Aims → Chaotic Future.
  - Inner Loop (5): Aim → Act → Feedback → Recalibrate → Sharpen Aim (+ Loop Alignment).
- **9-section Psych Matrix output page:** Executive Summary · Assessment Foundations (6) · Unified Synthesis (6) · Outer Loop · Inner Loop · Strengths & Blind Spots · EQ/IQ/HQ · Maturation · Model Integrity.
- **5 input fixes** (Big Five facets, MBTI dominant-pole, Enneagram type+wing, DISC/zodiac unchanged, two-path equivalence).
- **Recursive Dynamics** (Stage 10); **loop visualizations** (signature interaction).

## 3 · Existing assets reused vs net-new
| Capability | Current build | Action |
|---|---|---|
| Auth, routing, shell, tokens, dark mode | Shipped | Reuse (verify NDA gate + Google OAuth) |
| RTOS/Psych Matrix/Loop Analyzer/Equilibrium/Energy/Aims/Signal | Shipped (28 tbl, 31 fn, 18 routes) | Reuse as engine substrate |
| 6 assessment libraries | Inbound (staged) | Add via `telos_assessment_libraries` |
| 5 input fixes + two-path | Partial (2C) | Extend additively |
| 13-stage pipeline + convergence + confidence | Pieces exist | Extend/orchestrate |
| Outer/Inner Loop generation + Recursive Dynamics | Absent | Build (flag-gated) |
| 9-section output + loop viz | Absent | Build at `/app/portrait` |
| German cleanup / Next.js (roadmap P0) | Already English/Vite | N/A |

## 4 · Workstreams (additive, flag-gated)
- **WS-A Pre-flight & safety:** branch, backup, flags, inventory verify (NDA/OAuth/existing surfaces).
- **WS-B Libraries + input fixes:** 6 libraries (`telos_assessment_libraries`), Big5/Enneagram JSON, 5 input fixes, two-path equivalence.
- **WS-C Engine (13 stages):** pipeline orchestration, Cross-Library Convergence + confidence, Stage 8 RTOS (internal), Stage 9a/9b Outer/Inner Loop generation, Stage 10 Recursive Dynamics, EQ/IQ/HQ, Maturation, Executive Summary; persist via additive columns/companion table.
- **WS-D Output surface + loop viz:** `/app/portrait` (9 sections, narrative-first); Outer(4)/Inner(5) interactive visualizations; Recursive Dynamics/EQ-IQ-HQ/Maturation/Model Integrity.
- **WS-E Static/Dynamic + onboarding:** "Your Foundation" static framing; NDA gate + Google OAuth only if missing.
- **WS-F Hardening & governance:** edge-function tests, RLS on new tables, provisional language, no engagement maximization; optional O1–O3 prod promotion (separate).
- **WS-G Docs/sync + Phase 4:** CHANGELOG, Build State page, Genesis Hub Phase Map ("Phase 3F — Cognitive Core"), Jira epics; Phase 4 (OptimoCortex) after.

## 5 · Sequence
`WS-A → WS-B → WS-C → WS-D → WS-E`; WS-F parallel; WS-G after. Estimate finalized in the Lovable Build Prompt package.

## 6 · Quality gate
Anti-"cognitive astrology": every loop node carries **specific, personal** narrative (not generic stage text). Prototype loops against real engine output; WS-C3 loop-narrative generation is the critical gate.

## 7 · Open items
1. Big Five / Enneagram JSON — build now, or Sam ships them?
2. NDA gate / Google OAuth — already present? (WS-A3 verifies)
3. Phase Map label — "Phase 3F — Cognitive Core" OK?
4. Alpha testing framework (Barbara's dashboard) — in scope?

---
*Distributed via /report-distributor · GitHub source of truth · Dropbox clickable mirror · #telosai. HTML companion: `telosai-cognitive-core-build-plan-v3.html`.*
