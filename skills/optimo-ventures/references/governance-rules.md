# Playbook — Governance, Taxonomy & Audits

Read this for anything about classification, naming, re-parenting, structural audits, or the
rules that constrain writes. The doctrine here comes from `00.03`, `00.03.A`, and `00.04`.

## The rules, restated operationally

**From 00.03 — Confluence Structure:**
1. Never delete pages or history.
2. Never strip labels from existing pages (preserve them on every edit).
3. Taxonomy pages use `NN.NN — Title`.
4. Venture Genesis Hubs use `<VentureName> — Program Genesis HUB`.
5. Canonical artifacts reside in Layer 01; operational references may link from Layer 04 —
   they link, they do not copy.
6. Classifications below 0.80 confidence are not moved without human review.

**From 00.04 — MCP / AI Operator:**
1. DRY_RUN by default.
2. COMMIT needs explicit human approval per session.
3. Log structural changes in a Reorg Report under `00 — Optimo Workspace Index & Governance`.
4. Confirm re-parenting is API-supported before executing; otherwise provide a UI map.
5. Never delete pages, history, or labels.
6. Autonomous-action confidence threshold: 0.80.

## Mode protocol (apply to every write-capable task)

1. State `Mode: DRY_RUN`.
2. Produce a **change plan**: for each target — action (create/edit/move/transition),
   space, parent, title, label set (preserved + added), and a one-line body summary, plus
   the exact connector call(s).
3. For classifications/placements, give a confidence score. If any is < 0.80, mark it
   "needs human review" and do not include it in an auto-COMMIT batch.
4. Wait for explicit `COMMIT`. On COMMIT, execute only the approved items, then write/append
   a Reorg Report under page `70877186` summarizing what changed, with timestamps and links.

## Classifying a page into the taxonomy

1. Read the page (markdown) and its current parent/labels.
2. Match content to Layer 00–07 intent (see `workspace-map.md`).
3. Canon/invariants/registries → 01. Intelligence/agents/models → 02. Execution/Jira/
   gestation → 03. Operational policy/evidence → 04. Venture-specific → under that venture's
   hub in 05.02. Meeting notes/scratch → 07.
4. Score confidence. ≥ 0.80 → propose the move. < 0.80 → list options for a human.
5. Preserve every existing label; add taxonomy labels rather than replacing.

## Re-parenting safely

- The Confluence v2 API supports setting `parentId` on update — confirm the move works in
  DRY_RUN by validating both page IDs exist and are in the same space.
- If a move would cross spaces or the API path is uncertain, output a **UI re-parenting map**
  (a table of `page → new parent`) for a human instead of attempting it.
- Never re-parent a canonical (01) page beneath a venture (05). Canon does not live under
  ventures.

## Structural audit workflow

When asked to audit/maintain the workspace:
1. Pull the page tree (`getPagesInConfluenceSpace`, paginate fully).
2. Check: naming convention adherence, orphan pages, hubs missing canonical sub-pages,
   ventures missing the finance-inheritance pointer, stale `Updated:` dates, canon
   duplicated into Layer 04/05 instead of linked.
3. Produce a findings table with severity and a remediation plan — in DRY_RUN.
4. Offer to COMMIT fixes that are ≥ 0.80 confidence and rule-compliant; leave the rest for review.

## Editing canonical pages

- Treat Layer 01 pages as constitutional. Prefer additive edits; never weaken doctrine.
- Keep the header block (`Owner: … | Status: … | Updated: …`) and bump `Updated:`.
- Always pass a meaningful `versionMessage`.
- Preserve labels.

## Specification sync (when a skill itself is revised)

The operator skills are codified under `00.07` (see anchors in `workspace-map.md`). When any operator
skill is revised, perform the sync in the **same COMMIT** as part of releasing the change:
1. Update the matching specification page — `00.07.1` (`145096711`) for the build skill, `00.07.2`
   (`145457162`) for the triage skill — so it faithfully reflects the new behavior.
2. If the change affects how a human invokes the skill, update the usage guide too — `00.05`
   (`145489932`) or `00.06` (`145653774`).
3. Bump `Updated:`, pass a version message, preserve labels (additive edits only).
4. Log the change in a Reorg Report under `00.01` (`71106580`).
The installed `.skill` package and its `00.07.x` spec must never drift apart — revise them together.
