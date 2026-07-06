---
name: report-distributor
description: Post-report distribution pipeline. Invoke after any HTML report is generated — commits to corporate GitHub repo (primary), prompts user for cloud mirror (OneDrive/Dropbox/Google Drive), generates shareable link, pushes to Slack.
---

# Report Distributor

After any Claude Code skill (or any task) produces an HTML report, this skill
commits the report to the corporate GitHub repo as the permanent source of truth,
optionally mirrors to a personal cloud storage platform for shareable links,
and pushes a summary to the relevant Slack channel.

## Trigger

Invoke explicitly with `/report-distributor <path-to-html-report>` or
automatically whenever a skill generates an HTML file ending in `-report.html`
or `-analysis.html` or `-investigation.html`.

## What it does (8 steps)

1. **Classify the report** — parse title, subject tags, and venture name from the
   HTML content to determine what it's about and which Slack channel to target.

2. **Commit to GitHub (PRIMARY — corporate source of truth):**
   - Copy the `.html` report to `claude-code-skills/reports/<venture-slug>/YYYY/`
   - Generate MD companion (see step 6) and commit alongside the HTML
   - `git add`, `git commit -m "Report: <title> — <date>"`, `git push`
   - This is the permanent, team-visible, version-controlled record
   - Every team member can browse reports at:
     `https://github.com/OptimoVentures/claude-code-skills/tree/main/reports/`

3. **Prompt user for cloud mirror (optional shareable link):**
   Present the three supported platforms for generating a shareable link:

   | # | Platform | Shareable Link? | Use When |
   |---|----------|-----------------|----------|
   | 1 | **OneDrive** | Manual right-click → Share | Default. Syncs automatically. |
   | 2 | **Dropbox** | Automatic via MCP | You need an immediate shareable link |
   | 3 | **Google Drive** | Queued for batch sync | Google Workspace integration needed |
   | 0 | **Skip** | GitHub only | The report is already team-visible via GitHub |

   Use `AskUserQuestion`. Default to option 1 (OneDrive) if the user doesn't
   express a preference. If the user picks option 0, skip to step 7 (Slack).

4. **Store locally** — copy the `.html` report to
   `C:\Users\joelp\Reports\<Subject>\YYYY-MM-DD\<report>.html`

5. **Upload to chosen cloud mirror & generate shareable link:**

   **If Skip (option 0):**
   - No cloud mirror. Report is already in GitHub — the corporate source of truth.
   - Slack post will link to the GitHub file URL.

   **If OneDrive (option 1):**
   - Copy to `C:\Users\joelp\OneDrive\Reports\<Subject>\YYYY-MM-DD\<report>.html`
   - OneDrive syncs automatically to cloud
   - Shareable link: instruct the user to right-click the file in Windows Explorer →
     "Share" → "Copy link", OR provide the local path as a fallback
   - Post the local path to Slack with a note that the file is syncing

   **If Dropbox (option 2):**
   - Use `mcp__DropboxMCP__create_file` to upload to `/Reports/<Subject>/<report>.html`
   - Use `mcp__DropboxMCP__create_shared_link` with `path_or_file_id` set to the
     uploaded file path, `audience="no_one"`, and add viewer emails if requested
   - The returned shared link URL is the shareable link — push this to Slack
   - If `create_shared_link` returns a link, post it directly to Slack as a clickable
     file link
   - If storage quota is exceeded (OVER_QUOTA), fall back to OneDrive and inform the user

   **If Google Drive (option 3):**
   - Store locally as normal
   - Append to `C:\Users\joelp\Reports\.drive-queue.json`:
     ```json
     { "file": "<report>.html", "path": "<local-path>", "queued": "<ISO timestamp>", "subject": "<subject>" }
     ```
   - Inform the user the file is queued and will be synced when Drive MCP is available
   - Use OneDrive as the fallback cloud mirror in the meantime

6. **Generate MD companion** — produce a `.md` version alongside the `.html` with
   the same base filename, preserving all headings, findings, and structure.

7. **Push shareable link to Slack** — post to the relevant venture channel (see
   channel mapping below) with:
   - Report title and date
   - Key findings summary (3-5 bullets)
   - The GitHub file URL (always included — corporate source of truth)
   - The shareable link (Dropbox shared link, OneDrive path, or Drive queue note)
   - Confluence page link if one was filed
   - MD companion path

8. **Open in browser** — launch the HTML report in the default browser:
   ```powershell
   Start-Process "<path-to-report>.html"
   ```

## User Prompt Format

When prompting the user to choose a cloud platform, present it like this:

```
Where should the HTML report be shared from?

1. OneDrive — syncs automatically, share via right-click
2. Dropbox — generates a shareable link via MCP (requires storage space)
3. Google Drive — queued for batch sync (pending MCP availability)
```

Use `AskUserQuestion` with `multiSelect: false`. Default to option 1 (OneDrive)
if the user doesn't respond or says "just use OneDrive."

## Parallel folder structure

```
C:\Users\joelp\Reports\                          (primary)
C:\Users\joelp\OneDrive\Reports\                 (OneDrive mirror — auto-synced to cloud)
  ├── OptimoLand\
  │   └── 2026-07-04\
  │       ├── optimoland-vercel-investigation-report.html
  │       └── optimoland-vercel-investigation-report.md
  ├── RCM Platform\
  │   └── 2026-07-05\
  │       ├── rcm-triage-report.html
  │       ├── rcm-session-report.html
  │       └── rcm-competitive-analysis.html
  ├── Optimo Ventures (Parent)\
  ├── OptimoEvidence\
  ├── OptimoLaunch\
  ├── GutWise Journey\
  ├── OptimoSelect\
  ├── TelosAI\
  ├── ArtQuest\
  ├── OptimoStudio\
  ├── OptimoCares+\
  ├── MolDesignAI\
  ├── MedAppealAI\
  ├── GenesisGrid\
  └── Platform (Codex + Cortex + Agile)\
```

All paths use identical `<Subject>\<YYYY-MM-DD>\` structure.

## MD Companion Format

Every HTML report gets a `.md` companion that:
- Uses the same base filename (e.g., `report.html` → `report.md`)
- Preserves all headings (H1→#, H2→##, H3→###)
- Converts tables to markdown tables
- Preserves finding badges as `**severity**` text
- Links to the Slack message URL at the bottom
- Notes the local, OneDrive, Dropbox (if used), and Confluence file paths

## Slack Channel Mapping

| Report Subject | Slack Channel |
|---|---|
| OptimoLand | `#optimoland` |
| RCM Platform | `#ideation-triage` |
| Optimo Ventures (Parent) | `#general` |
| OptimoLaunch | `#optimolaunch` |
| GutWise Journey | `#gutwise-journey` |
| Platform / Cross-cutting | `#optimo-platform` |
| Unknown / Other | `#general` |

## Slack Post Format

The Slack message should contain:
1. Report title with emoji indicator (🔷 for triage, 🔍 for analysis, 📊 for investigation)
2. Key findings summary (3-5 bullets)
3. The shareable link from the chosen cloud platform:
   - **Dropbox:** the shared link URL from `create_shared_link`
   - **OneDrive:** the local path + "Syncing via OneDrive — right-click to share"
   - **Google Drive:** "Queued for Drive sync — available locally at `<path>`"
4. Confluence page link (if one was filed)
5. MD companion path

## Dropbox MCP Usage

When the user selects Dropbox:

1. **Upload:** `mcp__DropboxMCP__create_file(path="/Reports/<Subject>/<report>.html", content="<html>")`
2. **Share:** `mcp__DropboxMCP__create_shared_link(path_or_file_id="/Reports/<Subject>/<report>.html", audience="no_one")`
3. **Post the returned URL** to Slack as the shareable link
4. **On quota failure:** fall back to OneDrive, inform user: "Dropbox storage is full. Report saved to OneDrive instead. To free Dropbox space, delete files at dropbox.com."

## OneDrive Shareable Link (Manual)

OneDrive does not have a programmatic shareable-link API accessible from this
skill. The file syncs automatically to OneDrive cloud, and the user can generate
a shareable link by:
1. Opening `C:\Users\joelp\OneDrive\Reports\<Subject>\YYYY-MM-DD\` in Windows Explorer
2. Right-clicking the HTML file
3. Selecting "Share" → "Copy link"

Note this limitation in the Slack post and provide the local file path.

## Google Drive Queue

The queue file at `C:\Users\joelp\Reports\.drive-queue.json` is a JSON array:
```json
[
  {
    "file": "rcm-triage-report.html",
    "path": "C:\\Users\\joelp\\Reports\\RCM Platform\\2026-07-05\\rcm-triage-report.html",
    "queued": "2026-07-05T20:30:00.000Z",
    "subject": "RCM Platform"
  }
]
```

When Google Drive MCP becomes available, process the queue in FIFO order.

## Implementation notes

- Classify the subject by scanning the HTML `<title>`, `<h1>`, and any
  `.badge` / `.finding-title` elements for venture names
- The date folder uses the report's generation date (from `<meta>` or file
  modified time), not the current date
- If a Slack channel doesn't exist for the venture, suggest creating one with
  `slack_create_conversation` (lowercase, use hyphens)
- OneDrive sync is automatic — Windows syncs the Reports folder to cloud
- Dropbox quota issues are common — always have OneDrive as fallback
- Google Drive is pending — see [[google-drive-mcp-setup]]
- Always post the shareable link (or best available path) to Slack, regardless
  of which cloud platform was chosen
