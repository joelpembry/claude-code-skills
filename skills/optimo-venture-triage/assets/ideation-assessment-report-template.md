# Asset — Ideation Assessment Report Template

Fill every `{{placeholder}}`. Keep the header block. Use this for both the in-chat output and the
filed Confluence page (render headings/tables/panels in HTML when filing).

```
# Ideation Assessment — {{Idea Name}} — {{YYYY-MM-DD}}

**Analyst:** optimo-venture-triage | **Verdict:** {{GO | CONDITIONAL-GO | NO-GO}} | **Disposition:** {{A Foundation | B Sidecar | C Venture Hub | H Hybrid (A+B / A+C / B+C / A+B+C) | D No-Go}} | **Overall:** {{nn}}/100 | **Updated:** {{YYYY-MM-DD}}

## 0. RCM Pre-Analysis (if --rcm-project-state supplied)
{{Omit this entire section if no RCM Project State was ingested.}}

- **RCM Project State:** `{{path/to/project-state.json}}`
- **Perspectives run:** Explorer {{✓/✗}} | Evaluator {{✓/✗}} | Executor {{✓/✗}} | Threat {{✓/✗}} | Social {{✓/✗}}
- **Key RCM findings incorporated:**
  - Explorer: {{top 3 concepts by novelty, objective refinements adopted}}
  - Evaluator: {{weighted scores per dimension (advisory only — triage scores independently)}}
  - Threat: {{top risks by P×I carried forward; constraints adopted}}
  - Social: {{key stakeholders, adoption barriers, success criteria adopted}}
  - Executor: {{recommended approach, phase count, estimate range}}
- **RCM ↔ Triage divergence (if any):** {{dimensions where scores differ by ≥2 points, with explanation}}
- **Confidence in RCM pre-analysis:** {{0.00–1.00 — how much the triage relies on RCM findings vs. independent verification}}

## 1. Idea (normalized)
{{One-paragraph restatement: name, thesis, problem, proposed capability, source content. If RCM Project State was ingested, note which Explorer objective refinements were adopted.}}

## 2. Ecosystem juxtaposition & disposition
- **Best-fit disposition:** {{A/B/C/H/D}} — {{why, in one or two sentences}}
- **Runner-up:** {{disposition}} — {{why it lost}}
- **Overlap check:** {{existing venture(s)/sidecar(s) it is adjacent to, and how much}}
- **If Hybrid — decomposition & separability:** {{canonical core + its ≥2 consumers (A target page);
  product surface(s) (B host / C venture); confirm each independently clears its gate}}
- **Disposition confidence:** {{0.00–1.00}}

## 2a. Per-component verdicts (Hybrid only)
| Component | Target | Score/100 | Verdict | Depends on |
| --- | --- | --- | --- | --- |
| A — canon core | {{01/02/03 page}} | {{}} | {{}} | — |
| B — sidecar | {{host venture}} | {{}} | {{}} | A |
| C — new venture | {{venture}} | {{}} | {{}} | A |
{{Drop rows that don't apply. Promotion proceeds in dependency order; failed components are dropped.}}

## 3. Scored assessment
| # | Dimension | Score /5 | Weight | Confidence | Justification + evidence |
| --- | --- | --- | --- | --- | --- |
| 1 | Strategic fit & overlap | {{}} | 20% | {{}} | {{}} |
| 2 | Ecosystem placement | {{}} | 15% | {{}} | {{}} |
| 3 | Risk | {{}} | 20% | {{}} | {{}} |
| 4 | Cost | {{}} | 15% | {{}} | {{}} |
| 5 | Benefit / value | {{}} | 15% | {{}} | {{}} |
| 6 | Market | {{}} | 10% | {{}} | {{}} |
| 7 | Feasibility & readiness | {{}} | 5% | {{}} | {{}} |

**Weighted overall:** {{show the math: Σ(score×weight) → nn/100}}
**Lowest-confidence dimensions:** {{list}}
**Blocking conditions (if any):** {{list, or "none"}}

## 4. Risk / Cost / Benefit / Market detail
- **Risk:** {{technical, compliance (ref 01.03), security, IP/legal, execution — with mitigations}}
- **Cost:** {{build + run + model/inference (ref 01.01.10 token discipline) + opportunity cost}}
- **Benefit / value:** {{revenue model, platform leverage, moat}}
- **Market:** {{TAM/SAM/SOM with sourced figures; competitors; timing/demand — cite sources}}

## 5. Gate
- **Verdict:** {{GO | CONDITIONAL-GO | NO-GO}}
- **Rationale:** {{the dimensions/conditions driving it}}
- **Conditions to clear (CONDITIONAL-GO only):** {{checkable list}}

## 6. Proposed handoff (GO / CONDITIONAL-GO)
{{C → optimo-ventures create-venture-hub with name/thesis/domain/spec seeds;
  B → sidecar scaffold under <host hub>; A → additive edits to <01/02/03 page>;
  H → sequenced: A (canon) first, then B and/or C linking back to it, each DRY_RUN → COMMIT.
  Note that the build runs DRY_RUN → COMMIT and requires explicit approval.}}

## 7. Provenance
- Filed under: 05.03 — Venture Intake & Triage (Pre-Hub Staging)
- Promotion status: {{not promoted | promoted on YYYY-MM-DD → links}}
{{If RCM Project State ingested:}}
- RCM pre-analysis: `{{path/to/project-state.json}}` — {{n}} perspectives, {{n}} risks, {{n}} concepts, {{n}} evidence claims
{{End if}}
```
