# RCM Knowledge Libraries

## Governance

- Libraries are **venture-local content (Layer 05)** — not canon (Layer 01).
- They are the product's data; the pattern's architecture is canon (02.10).
- **Authored and versioned in Confluence** as child pages of the RCM venture hub,
  titled `RCM Knowledge Library — <Library Name>`.
- **Synced to skill directory** at `.claude/skills/rcm/references/libraries/`.
- Each file carries a provenance comment with source page ID, version, and sync date.
- Sam Embry-Busch is the primary content author; any OPTIMOV member may contribute.

## The 8 Base Libraries

| Library | Confluence Page ID | Description | Applicable Domain Packs |
| --- | --- | --- | --- |
| **Human Truths** | `199131358` | Universal human motivations, desires, fears, and behavioral drivers | All |
| **Audience Intelligence** | `199655427` | Persona profiles, segmentation models, audience behavior patterns | venture, marketing, product |
| **Objections** | `199852033` | Common objections by domain, reframe strategies, pre-mortem library | All |
| **Visual Cognition** | `199753730` | How audiences perceive visual content, attention, hierarchy, gestalt | media, marketing, product |
| **Media Hierarchy** | `199098547` | Channel effectiveness, media sequencing, reach vs. depth | marketing, media |
| **Media Composition** | `199360575` | Format, duration, structure, pacing, creative composition rules | media, marketing |
| **UI/UX** | `199360596` | Interaction design principles, usability heuristics, UX pattern library | product, venture |
| **Marketing View** | `199688210` | Positioning, messaging, market framing, competitive differentiation | venture, marketing |

## Domain Packs

Domain packs are curated subsets of base libraries + domain-specific overrides.

| Domain Pack | Base Libraries Loaded | Domain-specific Extensions |
| --- | --- | --- |
| **venture** | Human Truths, Audience Intelligence, Objections, Marketing View | Venture sizing, CONDITIONAL-GO patterns |
| **product** | UI/UX, Objections, Marketing View | PRD templates, acceptance criteria patterns |
| **marketing** | Audience Intelligence, Media Hierarchy, Marketing View | Campaign brief format, channel matrix |
| **media** | Visual Cognition, Media Composition, Human Truths | Storyboard format, format specs |
| **research** | Human Truths, Objections, Audience Intelligence | Research synthesis format, evidence standards |

## Library versioning

Each Confluence library page must carry in its header:
```
Updated: YYYY-MM-DD
Version: N
Status: Active | Draft | Deprecated
Author: <name>
```

## Sync protocol

1. **On library update in Confluence** → run `sync/confluence-sync.ps1` to pull updated
   pages into the skill directory
2. **Verify provenance comment** in the synced `.md` file matches the current Confluence version
3. **Token budget awareness** — in a Claude.ai session, load only the libraries needed for
   the active domain pack (2-3 files max per session unless explicitly requested)

## Creating a new library

1. Create the Confluence page under the RCM venture hub:
   `RCM Knowledge Library — <Library Name>`
2. Add the header (Updated/Version/Status/Author)
3. Author the content in structured Markdown with clear sections
4. Update `sync/confluence-sync.ps1` with the new page ID
5. Run sync to pull it into the skill directory
6. If the library is cross-domain, add it to `base/`; if domain-specific, add to
   `domain-packs/<domain>/`
7. Update this reference file's table above with the new library

## Creating a new domain pack

1. Create a directory `domain-packs/<name>/`
2. Add a `pack-manifest.md` declaring which base libraries to load and any extensions
3. Author any domain-specific extension files
4. Update `references/rcm-session-protocol.md` to include the new domain pack in the
   domain pack table
5. File a DRY_RUN plan before adding to the canonical domain pack list
