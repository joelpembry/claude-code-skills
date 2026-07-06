#!/usr/bin/env bash
# sync-libraries.sh — Sync RCM knowledge libraries from Confluence to local skill directory
#
# Usage: ./sync-libraries.sh [--all] [--domain <name>]
#
# Canonical source: Confluence pages under RCM Platform™ Knowledge Libraries
# Runtime target:   .claude/skills/rcm/references/libraries/
#
# Each synced file carries a provenance comment:
#   <!-- source: Confluence page ID XXXXXXX, version N, synced YYYY-MM-DD -->
#
# Prerequisites:
#   - Claude Code with Confluence MCP tools available
#   - MCP tools must be authenticated

set -euo pipefail

SKILL_DIR="$(cd "$(dirname "$0")/.." && pwd)"
LIB_DIR="$SKILL_DIR/references/libraries"
REGISTRY_FILE="$SKILL_DIR/references/library-registry.json"

# ── Library registry (Confluence page ID → local path) ────────────
# Update this registry when new libraries are created in Confluence.
# This is the authoritative map — edit it here, commit to git.
# The sync script reads this file; library authors update it when they
# publish a new library version in Confluence.

if [[ ! -f "$REGISTRY_FILE" ]]; then
  echo "No library registry found at $REGISTRY_FILE"
  echo "Create one with: cp references/library-registry.template.json references/library-registry.json"
  exit 1
fi

echo "=== RCM Library Sync ==="
echo "Registry: $REGISTRY_FILE"
echo "Target:   $LIB_DIR"
echo ""

# ── Per-library sync ──────────────────────────────────────────────
# The actual sync uses Claude Code's MCP Confluence tools.
# This script sets up the environment and provides the registry.
# The sync itself runs inside a Claude Code session via the rcm skill.

# For now, this is invoked by the rcm skill's SKILL.md during setup.
# In the future, this will call the MCP tools directly.

echo "Registry contents:"
cat "$REGISTRY_FILE" | python3 -m json.tool 2>/dev/null || cat "$REGISTRY_FILE"

echo ""
echo "To sync libraries, run: /rcm sync-libraries"
echo "This will invoke the Confluence MCP tools and pull all registered pages."
