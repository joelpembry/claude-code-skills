# Project State — Schema, Branching & Promotion

## What is Project State?

Project State is the central accumulated object of the RCM pattern (02.10 canon). It is a
Markdown + JSON file that represents the **current best understanding of the project** across
all 13 canonical dimensions. Every perspective updates it. Every export is generated from it.
It is the single source of truth for the project's current understanding.

## File format

Project State files are stored as `sessions/<session-id>/project-state.md` in the B₁ skill
directory, and as Confluence pages (under the venture hub's `Build Outputs & Artifacts`
sub-page) when promoted.

## 13 Canonical Dimensions

```markdown
## Project State — <Project Name>
**Session:** <session-id>
**Domain Pack:** <venture|product|marketing|media|research>
**Started:** <ISO date>
**Last updated:** <ISO date>
**Status:** <Active | Approved | Archived>

---

### 1. Objectives
_Goals, targets, success criteria_
[Updated by: Explorer, Social]

### 2. Concepts
_Ideas, alternatives, creative directions_
[Updated by: Explorer]

### 3. Research
_Evidence, data, competitive intelligence_
[Updated by: Explorer]

### 4. Evidence
_Validated facts, sourced claims, benchmarks_
[Updated by: Evaluator]

### 5. Assumptions
_Beliefs not yet validated, hypotheses_
[Updated by: All — mark each as [UNVALIDATED]]

### 6. Decisions
_Choices made, rationale, alternatives considered_
[Updated by: Evaluator, Social]

### 7. Deliverables
_Outputs produced, artifacts, exports_
[Updated by: Executor]

### 8. Dependencies
_Prerequisites, blockers, external requirements_
[Updated by: Executor, Threat]

### 9. Risks
_Threats, failure modes, probability/impact_
[Updated by: Threat]

### 10. Constraints
_Limits, boundaries, non-negotiables_
[Updated by: Threat, Social]

### 11. Success Criteria
_Measurable acceptance thresholds_
[Updated by: Social, Evaluator]

### 12. Feedback
_Stakeholder input, test results, signals_
[Updated by: Social]

### 13. Specifications
_Execution-ready output, approved state_
[Updated by: Executor — synthesized from all perspectives]

---

## Perspective Sign-offs (required for Promote)
- [ ] Explorer
- [ ] Evaluator
- [ ] Executor
- [ ] Threat
- [ ] Social (required — promotion blocked until Social signs off)
```

## Branching

### Creating a branch
Name branches descriptively: `main`, `alt-positioning`, `risk-adjusted`, `sam-direction-2`, etc.
File system: copy `project-state.md` to `project-state--<branch-name>.md` in the same session dir.
In Confluence: create a child page titled `Project State — <Branch Name> — <session-id>`.

### Compare
Diff two branch files dimension-by-dimension. Surface:
- Dimensions that diverged
- New items in branch not in main
- Items present in main but dropped in branch (flag — do not delete)

### Merge
Dimension-by-dimension merge:
1. For each dimension, list items from both branches
2. Mark conflicts: `[CONFLICT: main says X / branch says Y — resolve]`
3. Do not auto-resolve conflicts — surface them for human review
4. Produce a merged file; the original branches are not deleted

### Promote to Approved Project State
Preconditions:
- All 5 perspective sign-offs checked
- Social sign-off mandatory (the pattern enforces stakeholder alignment before promotion)
- Human COMMIT approval

On promotion:
- Set `Status: Approved`
- File a copy in Confluence under `Build Outputs & Artifacts`
- The approved Project State becomes the input for B₂ build specs and Jira epic scaffolding

### Archive
- Set `Status: Archived`
- Timestamped snapshot — read-only, searchable, never deleted
- Remove from active workspace view but preserve on disk and in Confluence
