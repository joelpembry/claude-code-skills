#!/bin/bash
# Optimo Ventures — Claude Code Skills Auto-Installer (macOS/Linux)
# Installs corporate skills library and shared memory hooks into Claude Code
# Run: ./install.sh

set -e

REPO_ROOT="$(cd "$(dirname "$0")" && pwd)"
CLAUDE_HOME="${HOME}/.claude"
SKILLS_DIR="${CLAUDE_HOME}/skills"
HOOKS_DIR="${CLAUDE_HOME}/hooks"
MEMORY_DIR="${CLAUDE_HOME}/projects"

FORCE=false
SKIP_AUTOSYNC=false
DRY_RUN=false

for arg in "$@"; do
    case $arg in
        --force) FORCE=true ;;
        --skip-auto-sync) SKIP_AUTOSYNC=true ;;
        --dry-run) DRY_RUN=true ;;
    esac
done

echo "========================================"
echo " Optimo Ventures — Skills Installer"
echo "========================================"
echo " Repo:     ${REPO_ROOT}"
echo " Target:   ${CLAUDE_HOME}"
echo " Mode:     $(if ${DRY_RUN}; then echo 'DRY RUN'; else echo 'LIVE'; fi)"
echo "========================================"

# ── Step 1: Install Skills ─────────────────────────────────────────────

echo ""
echo "[1/5] Installing skills..."

for skill_dir in "${REPO_ROOT}/skills"/*/; do
    skill_name=$(basename "$skill_dir")
    src="${skill_dir}"
    dst="${SKILLS_DIR}/${skill_name}"

    if ${DRY_RUN}; then
        echo "  Would install: ${skill_name} → ${dst}"
        continue
    fi

    if [ -d "$dst" ]; then
        if ${FORCE}; then
            rm -rf "$dst"
            echo "  Overwriting: ${skill_name}"
        else
            echo "  Already installed: ${skill_name} (use --force to overwrite)"
            continue
        fi
    fi

    mkdir -p "$(dirname "$dst")"
    ln -sfn "$src" "$dst" 2>/dev/null || cp -r "$src" "$dst"
    if [ -L "$dst" ]; then
        echo "  Symlinked: ${skill_name}"
    else
        echo "  Copied: ${skill_name}"
    fi
done

# ── Step 2: Install Hooks ──────────────────────────────────────────────

echo ""
echo "[2/5] Installing shared memory hooks..."

mkdir -p "${HOOKS_DIR}"

for hook in "${REPO_ROOT}/hooks/"*; do
    hook_name=$(basename "$hook")

    if ${DRY_RUN}; then
        echo "  Would install hook: ${hook_name}"
        continue
    fi

    cp "${hook}" "${HOOKS_DIR}/${hook_name}"
    chmod +x "${HOOKS_DIR}/${hook_name}"
    echo "  Installed hook: ${hook_name}"
done

# ── Step 3: Seed Shared Memory ─────────────────────────────────────────

echo ""
echo "[3/5] Seeding shared memory..."

for venture_dir in "${REPO_ROOT}/memory/"*/; do
    venture_name=$(basename "$venture_dir")
    shared_file="${venture_dir}/shared-memory.json"
    dst_dir="${MEMORY_DIR}/${venture_name}/memory"

    if ${DRY_RUN}; then
        echo "  Would seed: ${venture_name}"
        continue
    fi

    mkdir -p "${dst_dir}"
    if [ -f "$shared_file" ]; then
        cp "${shared_file}" "${dst_dir}/"
        echo "  Seeded: ${venture_name}/shared-memory.json"
    fi
done

# ── Step 4: Configure Claude Code Settings ─────────────────────────────

echo ""
echo "[4/5] Configuring Claude Code settings..."

SETTINGS_FILE="${CLAUDE_HOME}/settings.json"

if [ -f "$SETTINGS_FILE" ]; then
    # Use python to merge hooks into settings.json if available
    if command -v python3 &> /dev/null; then
        python3 -c "
import json, sys
with open('${SETTINGS_FILE}') as f:
    settings = json.load(f)
if 'hooks' not in settings:
    settings['hooks'] = {}
if 'SessionStart' not in settings['hooks']:
    settings['hooks']['SessionStart'] = []
if 'SessionStop' not in settings['hooks']:
    settings['hooks']['SessionStop'] = []
start_hook = '${HOOKS_DIR}/session-start-memory-sync.sh'
stop_hook = '${HOOKS_DIR}/session-stop-memory-sync.sh'
if start_hook not in settings['hooks']['SessionStart']:
    settings['hooks']['SessionStart'].append(start_hook)
if stop_hook not in settings['hooks']['SessionStop']:
    settings['hooks']['SessionStop'].append(stop_hook)
with open('${SETTINGS_FILE}', 'w') as f:
    json.dump(settings, f, indent=2)
print('  Updated: settings.json')
"
    else
        echo "  Warning: python3 not found — update settings.json manually"
    fi
else
    echo "  Warning: ${SETTINGS_FILE} not found — run Claude Code first"
fi

# ── Step 5: Daily Auto-Sync ────────────────────────────────────────────

echo ""
echo "[5/5] Configuring daily auto-sync..."

if ${SKIP_AUTOSYNC}; then
    echo "  Skipped (--skip-auto-sync)"
elif ${DRY_RUN}; then
    echo "  Would create cron job: daily git pull at 09:00"
else
    CRON_ENTRY="0 9 * * * cd ${REPO_ROOT} && git pull --quiet"
    if crontab -l 2>/dev/null | grep -q "${REPO_ROOT}"; then
        echo "  Cron job already exists"
    else
        (crontab -l 2>/dev/null; echo "$CRON_ENTRY") | crontab -
        echo "  Created daily sync cron job: 09:00"
    fi
fi

# ── Summary ────────────────────────────────────────────────────────────

echo ""
echo "========================================"
echo " Installation Complete"
echo "========================================"
echo " Skills:    $(ls -1 "${REPO_ROOT}/skills/" | wc -l) installed"
echo " Hooks:     $(ls -1 "${REPO_ROOT}/hooks/" | wc -l) installed"
echo " Memory:    $(ls -1 "${REPO_ROOT}/memory/" | wc -l) ventures seeded"
echo " Auto-sync: $(if ${SKIP_AUTOSYNC}; then echo 'disabled'; else echo 'daily at 09:00'; fi)"
echo "========================================"
echo ""
echo "Next steps:"
echo " 1. Restart Claude Code to load new skills"
echo " 2. Run /optimo-ventures to verify installation"
echo " 3. Shared memory syncs on session start"
echo ""
echo "To update later: git pull"
echo "To uninstall:   rm -rf ${CLAUDE_HOME}/skills/optimo-*"
