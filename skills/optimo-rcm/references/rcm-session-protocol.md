# RCM Session Protocol

How to invoke and run an RCM reasoning session end-to-end.

## Invocation

A session is triggered by `/rcm <goal>` (Claude Code) or a natural-language request in Claude.ai
(e.g. "run RCM on this idea," "apply the 5-perspective model to...").

## Session lifecycle

### 1. Initialize
- Capture the goal/idea/problem in one paragraph — restate it before proceeding
- Determine the active **domain pack** (venture, product, marketing, media, research)
- Initialize a **Project State** file (see `assets/project-state-template.md`)
- Declare the **active workspace** (Exploration is default for new sessions)
- Load only the knowledge library files relevant to the domain pack (token efficiency)

### 2. Dispatch perspectives
Run all five perspectives against the goal. In Claude.ai (no true parallelism), pipeline them:
Explorer → Evaluator → Executor → Threat → Social, each reading the previous perspective's
output before writing to Project State.

For each perspective:
- State the perspective name and its lens
- Load relevant knowledge library sections
- Generate structured output in the perspective's domain
- Append to Project State under the relevant dimension(s)
- Flag any assumptions as `[UNVALIDATED]`

### 3. Synthesize
After all five perspectives have run:
- Produce a **Session Summary** — what each perspective contributed
- Identify **convergences** (all perspectives agree) and **tensions** (perspectives conflict)
- Update the `Decisions` and `Specifications` dimensions with convergent findings
- Flag unresolved tensions for human review

### 4. Offer next actions
Always end a session with explicit options:
- **Branch** — fork the Project State to explore an alternative direction
- **Deep-dive** — re-enter a specific workspace with a specialist engine
- **Promote** — elevate the current branch to Approved Project State (requires all 5 sign-offs)
- **Export** — produce a deliverable from the current Project State
- **Continue** — open the next workspace

### 5. Export (when requested)
Generate the output from Project State, not from raw perspective output. The Project State
is the single source of truth. Exports include: briefs, specs, plans, risk registers, decks.

## Domain packs

Each domain pack loads specific base libraries and tunes perspective prompts:

| Domain Pack | Primary Libraries | Primary Workspace | Typical Output |
| --- | --- | --- | --- |
| **venture** | Human Truths, Audience Intelligence, Objections | Exploration → Execution | Venture brief, triage assessment |
| **product** | UI/UX, Objections, Marketing View | Execution → Evaluation | PRD, roadmap, spec |
| **marketing** | Audience Intelligence, Persuasion, Media Hierarchy | Exploration → Social | Campaign brief, messaging matrix |
| **media** | Visual Cognition, Media Composition, Narrative | Exploration → Execution | Creative brief, storyboard, concept |
| **research** | Human Truths, Evidence, Objections | Exploration → Evaluation | Research synthesis, findings report |

## Running in Claude.ai (this environment)

Since Claude.ai has no native sub-agent parallelism, run the 5 perspectives sequentially.
Each perspective reads the accumulated Project State before writing to it. This is the
correct pattern — sequential accumulation still satisfies the canonical invariant that all
five perspectives update Project State.

Label each perspective block clearly:
```
### 🔭 Explorer Perspective
[output]

### ⚖️ Evaluator Perspective
[output — reads Explorer's additions to Project State]

### ⚙️ Executor Perspective
[output — reads Explorer + Evaluator additions]

### 🛡️ Threat Perspective
[output — reads all prior additions]

### 🤝 Social Perspective
[output — reads all prior additions, provides final alignment check]
```

## Confidence and uncertainty

- If the goal is too vague to dispatch perspectives meaningfully, ask one clarifying question
  before proceeding (which domain pack? what success looks like?).
- Flag low-confidence findings in Project State with `[CONFIDENCE: LOW — reason]`.
- Do not suppress tensions between perspectives — surface them. Unresolved tensions are
  valuable signal, not failure states.
