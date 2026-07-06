# Reference — Gate & Handoff

## Gate decision

Compute the weighted overall (0–100) from the rubric, then apply:

| Verdict | Default condition |
| --- | --- |
| **GO** | Weighted ≥ 75 **and** no dimension < 3 **and** no blocking risk |
| **CONDITIONAL-GO** | Weighted 55–74, **or** a single resolvable blocking condition; list the exact conditions to clear before promotion |
| **NO-GO** | Weighted < 55, **or** any unresolved blocking risk (compliance/legal/IP showstopper), **or** material duplication of an existing venture/sidecar |

Thresholds are defaults — a founder may override per assessment, but record the override and why.
Always show the math: per-dimension score × weight, the sum, and the dimensions driving the verdict.
A CONDITIONAL-GO must enumerate each condition as a checkable item.

## Hybrid (H) gating

A Hybrid is gated **per component**, not as a blended whole:
1. Score and gate each component (A, B, C) on its own rubric run.
2. The Hybrid is **GO** only if the **canonical core (A) is GO/CONDITIONAL-GO** AND **at least one
   product surface (B or C) clears**. The canon is the dependency; if it fails, the hybrid fails
   (re-evaluate the products as standalone B/C instead).
3. **Graceful degradation:** drop any component below its gate; the verdict becomes the passing
   subset (e.g. A GO + C GO + B NO-GO → promote A+C). State explicitly which components passed.
4. The report carries an overall verdict **plus a per-component verdict table**, and the promotion
   plan lists the components in dependency order (A → B/C).

## Filing the report (Layer 05 pre-hub staging)

Reports are filed under **Layer 05 — Venture & Application Genesis Hubs** (`72089601`) in a
staging container, kept separate from live hubs in 05.02.

1. Ensure the staging container exists: a page titled
   `05.03 — Venture Intake & Triage (Pre-Hub Staging)`, child of `72089601`. If absent, propose
   creating it (DRY_RUN) following the `NN.NN — Title` convention, then file beneath it.
2. File each report as a child titled
   `Ideation Assessment — <Idea Name> — <YYYY-MM-DD> — <VERDICT>`.
3. Use the report template; include the disposition, scores, gate math, and (for GO/CONDITIONAL)
   the proposed handoff plan. Add a status lozenge (green GO / yellow CONDITIONAL / red NO-GO).
4. Filing is a write: plan in DRY_RUN, execute on COMMIT. Preserve labels; add an `ideation`/
   venture-slug label. On COMMIT, also note the assessment in the Canonical Registry intake list
   if one exists.

## Promotion (only after GO/CONDITIONAL-GO **and** explicit approval)

- Confirm the human approves promotion (CONDITIONAL-GO: confirm the listed conditions are met).
- Hand off per disposition (see `disposition-playbook.md`): C → optimo-ventures create-venture-hub;
  B → sidecar scaffold under the host hub; A → additive foundation edits.
- The build/scaffold itself runs in **DRY_RUN first**, then COMMIT — promotion does not skip that
  discipline. Link the resulting hub/sidecar/edit back to the assessment report, and mark the
  report's status promoted.

## After promotion
Update the report with the promotion date and links to what was created. The report is the
provenance record for why the venture/sidecar/extension exists — keep it accurate.
