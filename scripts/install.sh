#!/usr/bin/env bash
# === Claude Code Harness — install.sh ===
# One-command bootstrap for the full Claude Code harness.
# Usage: bash install.sh
set -euo pipefail

RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'; CYAN='\033[0;36m'; NC='\033[0m'
PASS="${GREEN}PASS${NC}"; FAIL="${RED}FAIL${NC}"; WARN="${YELLOW}WARN${NC}"

HARNESS_DIR="$(cd "$(dirname "$0")/.." && pwd)"
CLAUDE_HOME="${CLAUDE_HOME:-$HOME/.claude}"

echo ""
echo -e "${CYAN}============================================${NC}"
echo -e "${CYAN} Claude Code Harness — Installer${NC}"
echo -e "${CYAN}============================================${NC}"
echo ""

# --- Detect platform ---
case "$(uname -s)" in
  Linux*)   PLATFORM="linux" ;;
  Darwin*)  PLATFORM="macos" ;;
  MINGW*|MSYS*|CYGWIN*) PLATFORM="windows" ;;
  *)        PLATFORM="unknown" ;;
esac
echo -e "[INFO] Platform: ${GREEN}$PLATFORM${NC}"

# --- Resolve user profile path ---
if [ "$PLATFORM" = "windows" ]; then
  USERPROFILE_FWD="${USERPROFILE:-$HOME}"
  USERPROFILE_FWD="${USERPROFILE_FWD//\\//}"
else
  USERPROFILE_FWD="$HOME"
fi

# --- Prerequisites ---
echo ""
echo "--- Checking prerequisites ---"

check_cmd() {
  if command -v "$1" &>/dev/null; then
    echo -e "  [$PASS] $1"
    return 0
  else
    echo -e "  [$FAIL] $1 NOT FOUND — install it first"
    return 1
  fi
}

ERRORS=0
check_cmd "node" || ((ERRORS++))
check_cmd "npx" || ((ERRORS++))
check_cmd "git" || ((ERRORS++))

if [ "$ERRORS" -gt 0 ]; then
  echo ""
  echo -e "[$FAIL] $ERRORS prerequisite(s) missing. Fix and re-run."
  exit 1
fi

# --- Ensure ~/.claude/ exists ---
mkdir -p "$CLAUDE_HOME"

# --- Install CLAUDE.md ---
echo ""
echo "--- Installing CLAUDE.md (router) ---"
if [ -f "$CLAUDE_HOME/CLAUDE.md" ]; then
  cp "$CLAUDE_HOME/CLAUDE.md" "$CLAUDE_HOME/CLAUDE.md.backup.$(date +%Y%m%d_%H%M%S)"
  echo "  [INFO] Existing CLAUDE.md backed up"
fi
cp "$HARNESS_DIR/CLAUDE.md" "$CLAUDE_HOME/CLAUDE.md"
echo -e "  [$PASS] CLAUDE.md installed"

# --- Generate settings.json ---
echo ""
echo "--- Generating settings.json ---"

SETTINGS_TARGET="$CLAUDE_HOME/settings.json"
SETTINGS_TEMPLATE="$HARNESS_DIR/settings.template.json"

if [ -f "$SETTINGS_TARGET" ]; then
  cp "$SETTINGS_TARGET" "$SETTINGS_TARGET.backup.$(date +%Y%m%d_%H%M%S)"
  echo "  [INFO] Existing settings.json backed up"
fi

# Replace placeholders
sed -e "s|{{USERPROFILE}}|$USERPROFILE_FWD|g" \
    -e "s|{{ANTHROPIC_AUTH_TOKEN}}|${ANTHROPIC_AUTH_TOKEN:-YOUR_API_KEY_HERE}|g" \
    "$SETTINGS_TEMPLATE" > "$SETTINGS_TARGET"

echo -e "  [$PASS] settings.json generated"
echo -e "  [${YELLOW}ACTION${NC}] Edit ${CLAUDE_HOME}/settings.json and set your API key + base URL"

# --- Install Playwright browser ---
echo ""
echo "--- Installing Playwright browser ---"
if npx playwright install chrome 2>/dev/null; then
  echo -e "  [$PASS] Chromium installed for Playwright"
else
  echo -e "  [$WARN] Playwright install failed — run: npx playwright install chrome"
fi

# --- Install Agents ---
echo ""
echo "--- Installing Agents ---"
mkdir -p "$CLAUDE_HOME/agents"
AGENT_COUNT=$(ls "$HARNESS_DIR/agents/"*.md 2>/dev/null | wc -l)
cp "$HARNESS_DIR/agents/"*.md "$CLAUDE_HOME/agents/" 2>/dev/null || true
echo -e "  [$PASS] $AGENT_COUNT agents installed"

# --- Install Rules ---
echo ""
echo "--- Installing Rules ---"
for RULESET in common web zh; do
  if [ -d "$HARNESS_DIR/rules/$RULESET" ]; then
    mkdir -p "$CLAUDE_HOME/rules/$RULESET"
    cp "$HARNESS_DIR/rules/$RULESET/"*.md "$CLAUDE_HOME/rules/$RULESET/" 2>/dev/null || true
    echo -e "  [$PASS] rules/$RULESET installed"
  fi
done

# --- Copy MCP configs ---
echo ""
echo "--- Installing MCP on-demand catalog ---"
mkdir -p "$CLAUDE_HOME/mcp-configs"
cp "$HARNESS_DIR/mcp-configs/on-demand-mcps.json" "$CLAUDE_HOME/mcp-configs/"
echo -e "  [$PASS] on-demand-mcps.json installed"

# --- Copy templates ---
echo ""
echo "--- Installing project templates ---"
mkdir -p "$CLAUDE_HOME/templates/project-claude-md"
cp "$HARNESS_DIR/templates/project-claude-md/"*.md "$CLAUDE_HOME/templates/project-claude-md/"
echo -e "  [$PASS] Project templates installed"

# --- Copy scripts ---
echo ""
echo "--- Installing management scripts ---"
mkdir -p "$CLAUDE_HOME/scripts"
cp "$HARNESS_DIR/scripts/mcp-toggle.sh" "$CLAUDE_HOME/scripts/"
cp "$HARNESS_DIR/scripts/mcp-health.sh" "$CLAUDE_HOME/scripts/"
chmod +x "$CLAUDE_HOME/scripts/"*.sh 2>/dev/null || true
echo -e "  [$PASS] mcp-toggle.sh, mcp-health.sh installed"

# --- Final summary ---
echo ""
echo -e "${CYAN}============================================${NC}"
echo -e "${GREEN} Install complete!${NC}"
echo ""
echo "  Next steps:"
echo "  1. Edit ~/.claude/settings.json — set your API key"
echo "  2. Restart Claude Code"
echo "  3. Run:  bash ~/.claude/scripts/mcp-health.sh"
echo "  4. List: bash ~/.claude/scripts/mcp-toggle.sh list"
echo ""
echo "  Quick start a new project:"
echo "    cp ~/.claude/templates/project-claude-md/react.md ./CLAUDE.md"
echo ""
echo -e "${CYAN}============================================${NC}"
