# Playbook — Jira Execution Orchestration

For turning a Functional Spec into Jira work, managing venture epics/stories, and keeping the
hub's "Jira Execution & State" page in sync. Honors mode discipline: DRY_RUN plans the issue
tree; COMMIT creates it.

## Ground rules

- Active project: **`KAN` — OptimoAgile** (confirm/expand via JQL; other projects may exist).
- **JQL must be bounded** — always include a project and/or date restriction; unbounded
  queries are rejected (e.g. `project = KAN AND created >= "2026-01-01" ORDER BY created DESC`).
- Assume the Lovable + Supabase + Vercel stack when writing epics/features/stories unless an
  approved exception is documented in the venture's Genesis pages.
- Every venture's Jira state is mirrored on its hub "Jira Execution & State" sub-page — keep
  them consistent; the Confluence page links to the issues.

## Spec → issue tree

1. Read the venture's Functional Specification (Living) page.
2. Propose a hierarchy: **Epic** (the venture/release) → **Stories** (features/flows) →
   optional **Sub-tasks**. Map each story back to a spec section.
3. Set sensible fields: summary, description (acceptance criteria from the spec), issue type,
   labels (venture slug), priority. Use `additional_fields` for priority/labels/custom fields.
4. DRY_RUN: present the full tree as a table (type → summary → parent → labels) before creating.

## Creating & linking

- Create the epic first (`createJiraIssue`, `issueTypeName="Epic"`), capture its key.
- Create stories with `parent` set to the epic key (or link via `createIssueLink` if the
  project uses link-based hierarchy — check `getIssueLinkTypes`).
- Transition issues with `transitionJiraIssue` (fetch valid transitions first via
  `getTransitionsForJiraIssue`); never assume transition IDs.
- Use `addCommentToJiraIssue` / `addWorklogToJiraIssue` for updates and time tracking.

## Syncing back to Confluence

After creating/updating issues, update the hub's "Jira Execution & State" page:
- List the epic and stories with their keys, statuses, and links.
- Bump `Updated:` and pass a `versionMessage`.
- Preserve labels.

## Reporting / status questions

- For "where does venture X stand," query `KAN` filtered by the venture label or epic, then
  summarize by status. Cross-check against the hub's state page and flag drift between them.
