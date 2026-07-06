# Playbook — Build & Deploy (Lovable + Supabase + Vercel, + GitHub)

For authoring build prompts, wiring backends, deploying, and recording outputs. The canonical
standard is `Optimo App Build Standard — Lovable, Supabase, Vercel` (page `97517590`) and
`OptimoCodex™ — Foundational Platform Architecture & Lovable Build Spec` (page `105185282`).

## The standard (default, unless an approved exception exists)

- **Lovable** — front-end and app assembly. Functional specs are written **Lovable-first**.
- **Supabase** — auth, Postgres, row-level security, storage, edge-function workflows.
  Backend and data-model work is written **Supabase-first** (DDL drafts live in Build Incubation).
- **Vercel** — deployment, hosting, preview environments, production delivery. Deployment and
  environment planning is written **Vercel-first**.
- **GitHub** — source control for the above. Not in the live connector set by default; if repo
  ops are needed, check `search_mcp_registry` and suggest connecting it, else use the web.

Any deviation must be documented and justified in the venture's Genesis + Technical
Architecture pages **before** execution begins.

## Authoring a Lovable build prompt

1. Pull the Functional Spec (Living) and Build Incubation pages for the venture.
2. Write the prompt Lovable-first: screens/flows, components, state, and the Supabase data
   contracts it should assume. Version it (`v1.0`, `v2.0 (Genesis-Enriched)`, …) as the hubs do.
3. Store it on the venture's "Executable Prompts (Lovable)" page. Preserve prior versions —
   never overwrite; add the new version.

## Vercel operations

- `list_projects` (needs a teamId — get it via `list_teams`) to find the venture's project.
- `get_deployment` / `list_deployments` for status; `get_deployment_build_logs` and
  `get_runtime_logs` for diagnostics.
- For protected preview URLs, use `get_access_to_vercel_url` or `web_fetch_vercel_url`.
- Record preview/prod URLs on the venture's "Build Outputs & Artifacts" page.

## Recording outputs (provenance)

After a build or deploy:
- Update "Build Outputs & Artifacts" with environment URLs, repo links, and a dated entry.
- Add an Audit/Traceability entry on the hub.
- If anything structural changed in Confluence, add a Reorg Report under `70877186`.

## Mode discipline

Reading logs/status is always fine. Authoring/altering Confluence build pages, creating
deployments, or pushing changes are writes — plan them in DRY_RUN and execute on COMMIT.
