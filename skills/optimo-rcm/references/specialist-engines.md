# Specialist Engines

Specialist engines are domain-specific reasoning modules invoked as sub-skills or sub-agents
within the RCM pattern. They are registered extensions of the 02.10 canonical spec.

**Governance:** New specialist engines must be registered in 02.10 (page `189661186`) before
any venture may invoke them as a Cortex service. This is an additive amendment; it never
weakens the canonical spec.

## Interface Contract (from 02.10 canon)

Every engine must implement:
- **Input:** Current Project State + engine-specific parameters
- **Output:** Structured findings appended to the relevant Project State section(s)
- **Idempotency:** Re-running with the same input produces consistent output; engines must not
  mutate state outside their assigned Project State sections

## Registered Engines

### Narrative Engine
- **Domain:** Story, identity, transformation
- **Invocation trigger:** Any creative or media workspace; when the goal involves brand story,
  origin narrative, transformation arc, or identity work
- **Project State sections written:** Concepts, Deliverables
- **Typical output:** Narrative brief, story arc, identity statement, transformation model

### Persuasion Engine
- **Domain:** Influence, conversion, adoption
- **Invocation trigger:** Marketing or campaign workspace; when the goal involves changing
  minds, driving action, or overcoming objections
- **Project State sections written:** Concepts, Evidence, Feedback
- **Typical output:** Messaging matrix, objection-reframe map, conversion brief

### Sales Engine
- **Domain:** Offers, commitment, onboarding
- **Invocation trigger:** Venture/go-to-market workspace; when the goal involves pricing,
  packaging, closing, or customer onboarding
- **Project State sections written:** Concepts, Decisions, Success Criteria
- **Typical output:** Offer structure, pricing model, onboarding flow, commitment trigger map

### Decision Engine
- **Domain:** Prioritization, tradeoffs, recommendations
- **Invocation trigger:** Evaluation workspace; when the goal involves a structured choice
  between options, prioritization of a backlog, or a go/no-go recommendation
- **Project State sections written:** Decisions, Evidence, Risks
- **Typical output:** Decision brief, weighted option matrix, recommendation with rationale

## Invoking an Engine (Claude.ai session)

When the active session reaches a domain that warrants a specialist engine:
1. Announce the engine: `Invoking [Engine Name] Engine`
2. State the input: current Project State section(s) + engine-specific parameters
3. Run the engine's reasoning within the perspective that triggered it
4. Append output to the correct Project State sections
5. Return to the main perspective flow

Engines are invoked **within** a perspective, not instead of one. The Persuasion Engine runs
inside the Explorer or Social perspective; the Decision Engine runs inside Evaluator.

## Registering a New Engine (DRY_RUN plan)

To register a new engine:
1. Define: name, domain, invocation trigger, Project State sections written, output format
2. File a DRY_RUN plan to add an entry to the **Registered Engines** table in 02.10 (page `189661186`)
3. On COMMIT, update 02.10 and bump its `Updated:` date with a version message
4. Update this reference file to add the new engine
5. Log a Reorg Report under `00.01` (`71106580`)
