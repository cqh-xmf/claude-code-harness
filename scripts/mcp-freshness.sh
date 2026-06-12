#!/usr/bin/env bash
# === Claude Code Harness — mcp-freshness.sh ===
# Staleness detection: check MCP packages on npm, agents/rules from ECC upstream.
# Usage: bash mcp-freshness.sh [--json] [--update]
set -euo pipefail

CLAUDE_HOME="${CLAUDE_HOME:-$HOME/.claude}"
SETTINGS="$CLAUDE_HOME/settings.json"
HARNESS_DIR="${HARNESS_DIR:-$(cd "$(dirname "$0")/.." && pwd)}"

RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'; CYAN='\033[0;36m'; NC='\033[0m'
PASS="${GREEN}PASS${NC}"; FAIL="${RED}FAIL${NC}"; WARN="${YELLOW}WARN${NC}"

CHECK_COUNT=0; STALE_COUNT=0; TOTAL_SCORE=0

echo ""
echo -e "${CYAN}============================================${NC}"
echo -e "${CYAN} MCP Freshness Check${NC}"
echo -e "${CYAN} $(date '+%Y-%m-%d %H:%M:%S')${NC}"
echo -e "${CYAN}============================================${NC}"
echo ""

# --- Check MCP npm packages ---
echo "--- MCP Packages (npm registry) ---"

check_npm_package() {
  local name="$1" pkg="$2"
  local latest current age
  latest=$(npm view "$pkg" version 2>/dev/null || echo "unknown")
  if [ "$latest" = "unknown" ]; then
    echo -e "  [$WARN] $name — $pkg — cannot reach npm registry"
    ((CHECK_COUNT++))
    return
  fi
  # Try to get installed version
  current=$(npm list -g "$pkg" --depth=0 2>/dev/null | grep "$pkg" | grep -oE '[0-9]+\.[0-9]+\.[0-9]+' | head -1 || echo "not-installed")
  if [ "$current" = "not-installed" ]; then
    echo -e "  ${CYAN}[N/A]${NC} $name — $pkg@$latest (not installed globally, runs via npx)"
    ((CHECK_COUNT++))
  elif [ "$current" = "$latest" ]; then
    echo -e "  [$PASS] $name — $pkg@$latest (current)"
    ((CHECK_COUNT++)); ((TOTAL_SCORE+=5))
  else
    echo -e "  [$WARN] $name — $pkg: $current → $latest (update available)"
    ((CHECK_COUNT++)); ((STALE_COUNT++))
  fi
}

check_npm_package "context7" "@upstash/context7-mcp"
check_npm_package "sequential-thinking" "@modelcontextprotocol/server-sequential-thinking"
check_npm_package "memory" "@modelcontextprotocol/server-memory"
check_npm_package "filesystem" "@modelcontextprotocol/server-filesystem"
check_npm_package "magic" "@magicuidesign/mcp"
check_npm_package "playwright" "@playwright/mcp"
check_npm_package "github" "@modelcontextprotocol/server-github"
check_npm_package "firecrawl" "firecrawl-mcp"

# Check on-demand MCPs if available
ON_DEMAND="$CLAUDE_HOME/mcp-configs/on-demand-mcps.json"
if [ -f "$ON_DEMAND" ]; then
  echo ""
  echo "--- On-Demand MCP Packages ---"
  ONDEMAND_PKGS=$(python3 -c "
import json
with open('$ON_DEMAND') as f:
    data = json.load(f)
for name, cfg in data.get('mcpServers', {}).items():
    args = cfg.get('args', [])
    # Try to find npm package in args
    for a in args:
        if not a.startswith('-') and not a.startswith('@modelcontextprotocol') and a != 'chromium' and '/' not in a:
            continue
        if a.startswith('-'):
            continue
        print(f'{name}|{a}')
        break
" 2>/dev/null)
  if [ -n "$ONDEMAND_PKGS" ]; then
    echo "$ONDEMAND_PKGS" | while IFS='|' read -r name pkg; do
      [ -z "$name" ] && continue
      check_npm_package "$name" "$pkg"
    done
  else
    echo "  (no npm-based on-demand MCPs to check)"
  fi
fi

# --- Check agents/rules from ECC upstream ---
echo ""
echo "--- Agents & Rules (upstream ECC) ---"

AGENT_COUNT=$(ls "$HARNESS_DIR/agents/"*.md 2>/dev/null | wc -l || echo 0)
RULES_COUNT=$(find "$HARNESS_DIR/rules/" -name "*.md" 2>/dev/null | wc -l || echo 0)
echo -e "  Agents installed: ${GREEN}$AGENT_COUNT${NC}"
echo -e "  Rules installed:  ${GREEN}$RULES_COUNT${NC}"
echo -e "  [INFO] Run 'node scripts/auto-update.js' to pull latest from ECC upstream"

# --- Scan GitHub Trending for new MCPs ---
echo ""
echo "--- Community Discovery (GitHub) ---"
echo "  Searching GitHub for new MCP servers..."

NEW_MCPS=$(curl -s "https://api.github.com/search/repositories?q=mcp+server+language:typescript&sort=updated&per_page=5" 2>/dev/null | python3 -c "
import json, sys
try:
    data = json.load(sys.stdin)
    for item in data.get('items', [])[:5]:
        name = item.get('full_name', '?')
        desc = item.get('description', '')[:80]
        stars = item.get('stargazers_count', 0)
        print(f'  {name} ({stars}★) — {desc}')
except:
    print('  GitHub API unavailable (rate-limited or no token)')
" 2>/dev/null || echo "  GitHub API unavailable")

echo "$NEW_MCPS"

# --- Summary ---
echo ""
echo -e "${CYAN}--- Freshness Summary ---${NC}"
echo "  MCPs checked: $CHECK_COUNT"
echo "  Stale (update available): $STALE_COUNT"

if [ "$STALE_COUNT" -eq 0 ]; then
  echo -e "  Status: ${GREEN}All fresh${NC}"
else
  echo -e "  Status: ${YELLOW}$STALE_COUNT update(s) available${NC}"
  echo ""
  echo "  To update npm packages:"
  echo "    npm update -g <package-name>"
  echo "  To update agents/rules:"
  echo "    node $HARNESS_DIR/scripts/auto-update.js"
fi

echo ""
echo -e "${CYAN}============================================${NC}"
