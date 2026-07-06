# Optimo Ventures — Workspace Map & Connector Inventory

The authoritative anchor list. Page IDs are real and stable; titles may evolve, so confirm
with a read when a change is material. If an ID 404s, search by title with
`searchConfluenceUsingCql` (`type=page AND space=OPTIMOV AND title ~ "..."`).

## Atlassian site

- **cloudId:** `a9042b7c-96da-42c2-bb54-4c2209c67b3d`
- **Host:** `optimoventures.atlassian.net`
- Confluence scopes include read/write page + comment; Jira scopes include read/write work.

## Confluence spaces

| Key | Name | spaceId | Homepage | Use |
| --- | --- | --- | --- | --- |
| `OPTIMOV` | Optimo Ventures Canonical Workspace | `71598082` | `71598199` | **Primary system of record** — all canon, hubs, governance |
| `OV` | Optimo Ventures (global) | `71303170` | `71303474` | Public/general venture space |
| `OPTIMOAGIL` | OptimoAgile | `11436037` | `11436144` | Agile execution space |
| `PM` | Project Management | `327684` | `327948` | PM onboarding/templates |

Personal spaces exist per team member (Susan Embry-Buscy, Samuel Embry-Busch, Barbara Embry,
John Campbell, cking, sembrybusch) — never treat these as canonical.

## Canonical layer anchors (space OPTIMOV)

| Page ID | Title | Notes |
| --- | --- | --- |
| `71598199` | (Space homepage) | Root of canonical workspace |
| `70877186` | 00 — Optimo Workspace Index & Governance | Reorg Reports live under here |
| `70909954` | 00.02 — Taxonomy & Ontology | Layer definitions |
| `71401492` | 00.03 — Governance Rules for Confluence Structure | Core rules |
| `87719938` | 00.03.A — Governance Rules (Annex A — Detailed) | Detailed rules |
| `71008277` | 00.04 — MCP / AI Operator Integration Rules | Mode discipline |
| `71008296` | 01 — OptimoCodex™ (Canonical Layer) | Parent of canon |
| `71696385` | 01.01 — Genesis & Invariants | |
| `119373825` | 01.01.10 — Optimo Token Discipline Canon | |
| `70877206` | 01.02 — Semantic Contracts & Interfaces | |
| `71729153` | 01.03 — Compliance Canon (SOC2/NIS2/ISO/27001/42001) | |
| `87490562` | 01.03.07 — GAAP Financial Accounting Canon | **Finance inheritance** |
| `122945540` | 01.03.07.BANK — Banking, Treasury & Cash Controls | |
| `123109378` | 01.03.07.BILL — Billing, Payments & Revenue Infra | |
| `71368725` | 01.04 — Canonical Registries | **Source of truth for venture registry** |
| `85164033` | 01.04.TP — Platform & Toolchain Registry | |
| `80478209` | 01.05 — Nebius Integration Canon | |
| `105185282` | OptimoCodex™ — Foundational Platform Architecture & Lovable Build Spec | |
| `71761921` | 02 — OptimoCortex™ (Intelligence & Reasoning) | Parent |
| `71794689` | 02.01 — Agent Architectures & Patterns | |
| `71139349` | 02.02 — Model & Gateway Governance | |
| `87916547` | 02.06 — Cortex LLM Model Registry & Routing Spec | |
| `70877225` | 03 — OptimoAgile™ (Execution & Governance) | Parent |
| `71827457` | 03.01 — Program Gestation Model & Templates | **Venture template canon** |
| `87588865` | 03.01.FIN — Venture Finance Minimum Viable Controls Template | **Finance inheritance** |
| `80478231` | 03.01.LS — Life Sciences Venture Template (Nebius-Backed) | Domain template |
| `71925761` | 03.04 — Jira & Execution Orchestration | |
| `71958529` | 04 — Optimo Compliance Library | Parent |
| `71991297` | 04.01 — Policy & Control Library (Operational) | |
| `87556097` | 04.01.01 — GAAP Month-End Close Operating Procedure | **Finance inheritance** |
| `72089601` | 05 — Venture & Application Genesis Hubs | Parent |
| `72122369` | 05.01 — Venture Applications Registry (pointer → 01.04) | |
| `72220673` | **05.02 — Ventures** | **Parent for all venture hubs** |
| `72253441` | 06 — Human Factors & Sovereignty Layers | |
| `72253460` | 07 — Operational Spaces | Meeting notes / scratch |
| `97517590` | Optimo App Build Standard — Lovable, Supabase, Vercel | **Build stack canon** |

## AI Operator skill codification anchors (00.07)

The skills are codified as canonical specifications; keep these in sync with the installed packages
(see the Specification sync invariant in SKILL.md and governance-rules.md).

| Page ID | Title | Sync target for |
| --- | --- | --- |
| `145653795` | 00.07 — Optimo AI Operator Skills (Codified Specifications) | container / doctrine |
| `145096711` | 00.07.1 — optimo-ventures (Build Skill) — Canonical Specification | this skill |
| `145457162` | 00.07.2 — optimo-venture-triage (Precursor Gate) — Canonical Specification | the triage skill |
| `213581915` | 00.07.3 — report-distributor (Post-Report Distribution Pipeline) — Canonical Specification | the report-distributor skill |
| `145489932` | 00.05 — Optimo Ventures Skill — Operator Usage Guide | this skill (human guide) |
| `145653774` | 00.06 — Optimo Venture Triage Skill — Operator Usage Guide | triage skill (human guide) |
| `213319727` | 00.08 — Report Distributor Skill — Operator Usage Guide | report-distributor skill (human guide) |
| `71106580` | 00.01 — Workspace Overview & Navigation | parent for Reorg Reports |

## Known Venture Genesis Hubs (children of 05.02 — Ventures, id 72220673)

Each is `<Venture> — Program Genesis HUB`. Use these as reference exemplars of the template.

| Hub page ID | Venture |
| --- | --- |
| `80969729` | MolDesignAI |
| `76841008` | MedAppealAI |
| `97484802` | OptimoCares+ |
| `115638275` | GenesisGrid™ |
| `131366914` | GutWise Journey™ |
| `120881158` | OptimoCommand™ |
| `24576001` | OptimoCanon™ |
| `16154662` | ArtQuest |
| `77758465` | OptimoGenesis (OG) hub |
| `88440854` | OGL (Land & Lease) |
| `137920553` | OptiSelectAI |

To get the current, complete list: `getPagesInConfluenceSpace(spaceId=71598082)` and filter
titles ending `— Program Genesis HUB`, or read children of `72220673`. New hubs may exist
that post-date this map.

## Jira

- Project **`KAN` — OptimoAgile** is the active execution project (others may exist; confirm
  via JQL). JQL must be bounded (add a date or project restriction; unbounded queries error).
- Venture execution state is mirrored on each hub's "Jira Execution & State" sub-page.

## Connector inventory

- **Atlassian Rovo** — Confluence (read/write pages, comments, CQL search) + Jira
  (search JQL, create/edit/transition issues, worklogs, issue links). Primary connector.
- **Vercel** — list/get projects, deployments, build/runtime logs, deployment access.
  Used for the deploy half of the build stack.
- **Slack** — search/read/post messages, canvases. Use for venture comms/notifications.
- **Zoom** — meeting assets, recordings, docs. Source for meeting-note ingestion (Layer 07).
- **GitHub** — *not in the live connector set as of this map.* If a request needs repo
  operations, check `search_mcp_registry` / suggest connecting it, or fall back to the web.
  Treat GitHub as the source-control half of the build stack once connected.
