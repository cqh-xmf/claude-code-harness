# Claude Code Harness

<p align="right">
  <a href="README_ZH.md">中文</a>
</p>

<p align="center">
  <img src="docs/logo-horizontal.svg" width="600" alt="Claude Code Harness">
</p>

<p align="center">
  <b>The missing OS for Claude Code.</b><br>
  Intent-to-Tool Mapping · Degradation Mesh · Tool Rot Detection
</p>

<p align="center">
  <a href="LICENSE"><img src="https://img.shields.io/badge/license-MIT-blue"></a>
  <a href="#"><img src="https://img.shields.io/badge/platform-Windows%20%7C%20macOS%20%7C%20Linux-brightgreen"></a>
  <a href="CONTRIBUTING.md"><img src="https://img.shields.io/badge/PRs-welcome-brightgreen"></a>
  <img src="https://img.shields.io/badge/agents-91-blueviolet">
  <img src="https://img.shields.io/badge/MCPs-8_core_+_17_on--demand-orange">
</p>

---

## Before vs After

|  | Without Harness | With Harness |
|--|----------------|--------------|
| **Setup** | 3+ hours wiring MCPs manually | `bash install.sh` — 1 command |
| **Tool selection** | "Which skill handles PPT?" | **I2T Engine** — just talk naturally |
| **When tools fail** | Task blocked, debug manually | **Degradation Mesh** — 3-tier auto-fallback |
| **Unused tools** | Clutter context forever | **Tool Rot Detection** — flagged, cleaned |
| **Code review** | Manual agent selection | Auto-routed by language (14 languages) |
| **New project** | Write CLAUDE.md from scratch | `cp templates/react.md ./CLAUDE.md` |
| **Token budget** | Load everything or nothing | 8 core auto + 17 on-demand = managed |
| **Staleness** | Never know what's outdated | `mcp freshness` — checks npm + upstream |

---

## What makes it different

### I2T Engine (Intent-to-Tool Mapping)

You talk. It thinks. The routing table is a **natural-language compiler** that translates human intent into tool execution chains.

```
YOU: "Review src/auth.ts for security issues"

I2T ENGINE (internal decision chain):
  ├─ Detects: TypeScript file → selects typescript-reviewer agent
  ├─ Detects: "auth" + "security" keywords → layers security-reviewer agent
  ├─ Detects: file path contains "src/" → adds code-reviewer agent
  └─ Executes: 3 agents in parallel → returns combined report

You typed one sentence. Three agents ran. Zero tool names memorized.
```

### Degradation Mesh

Not a single fallback. A **3-tier mesh**:

```
context7 timeout → WebSearch + manual docs → ask user for URL
playwright fails → webapp-testing skill → manual browser instructions
github MCP down → native git CLI → gh CLI → manual git commands
firecrawl timeout → WebFetch → ask user for page content
```

Every tool has a fallback. No task is blocked by a dead MCP.

### Tool Rot Detection

Like dead-code detection, but for AI tools. Unused MCPs and agents are flagged across sessions. Keeps your context window lean.

---

## One command

```bash
git clone https://github.com/cqh-xmf/claude-code-harness.git ~/.claude-harness
bash ~/.claude-harness/scripts/install.sh
```

This deploys:
- **CLAUDE.md** — the I2T routing engine
- **91 agents** — language reviewers, security auditors, test runners, planners
- **29 rules** — coding standards, security policies, testing requirements
- **8 core MCPs** — context7, playwright, github, firecrawl, memory, filesystem, magic, sequential-thinking
- **17 on-demand MCPs** — one command away: `mcp enable fal-ai`
- **5 project templates** — React, Python, Node, Next.js, generic
- **Management CLI** — `mcp list`, `mcp health`, `mcp freshness`, `mcp recipe`

---

## The CLI

```bash
mcp list              # See all MCPs, grouped by category
mcp enable <name>     # Enable any of 17 on-demand MCPs
mcp disable <name>    # Disable (core MCPs protected)
mcp enable-all search # Enable entire group at once
mcp health            # Health check with cold-start timing
mcp freshness         # Check for outdated MCPs + new discoveries
mcp recipe <name>     # Trigger multi-tool workflows
mcp score             # Get your Harness Score (0–100)
```

---

## Freshness — the living system

Unlike static config collections, Harness checks for staleness:

```bash
$ mcp freshness

Checking 25 MCPs against npm registry...
  context7:      @upstash/context7-mcp      ✅ latest (v2.1.0)
  firecrawl:     firecrawl-mcp              ⚠️  v1.2.0 → v1.3.1 available
  tavily:        @tavily/mcp-server-tavily  ✅ latest
  ...

Agents (91):  checking upstream ECC repo...  3 updates available
Rules (29):   checking upstream ECC repo...  up to date

Freshness score: 84/100
  Run: mcp update to apply available updates
```

Never wonder if your tooling is stale again.

---

## Harness Score

```bash
$ mcp score

  Claude Code Harness Score: 87/100

  MCP Online:       8/8   (25 pts) ✅
  Tokens Set:       2/3   (12 pts) ⚠️  FIRECRAWL_API_KEY missing
  Agents Ready:    91/91  (20 pts) ✅
  Rules Active:    29/29  (15 pts) ✅
  Freshness:        84%   (10 pts) ⚠️  3 updates available
  Recipes:           0/4   (0 pts)  💡 Try: mcp recipe list
  Templates:         5/5   (5 pts)  ✅
```

Share your score. Compare with others. Keep improving.

---

## Architecture

```
YOU SAY: "Build a landing page"
         │
         ▼
┌─────────────────────────────────┐
│       I2T ENGINE (CLAUDE.md)    │
│  Intent → Tool Mapping          │
│  "landing page" → frontend skill│
└─────────────┬───────────────────┘
              │
    ┌─────────┼─────────┐
    ▼         ▼         ▼
┌────────┐ ┌────────┐ ┌────────┐
│ 8 CORE │ │23 SKILL│ │91 AGENT│
│  MCPs  │ │   S    │ │   S    │
└───┬────┘ └───┬────┘ └───┬────┘
    │          │          │
    └──────────┼──────────┘
               │
    ┌──────────▼──────────┐
    │  DEGRADATION MESH   │
    │  Tool A↓ → B↓ → C   │
    └──────────┬──────────┘
               │
    ┌──────────▼──────────┐
    │  TOOL ROT DETECTION │
    │  Unused → Flagged   │
    └─────────────────────┘
```

---

## File Structure

```
claude-code-harness/
├── README.md + README_ZH.md    ← Bilingual docs
├── CLAUDE.md                    ← The I2T Engine (router)
├── settings.template.json       ← MCP config (no real keys)
├── LICENSE (MIT) + .gitignore
│
├── agents/                      ← 91 agents
│   ├── code-reviewer.md
│   ├── security-reviewer.md
│   ├── typescript-reviewer.md
│   ├── opensource-forker.md
│   └── ... (14 language reviewers, planners, debuggers)
│
├── rules/                       ← 29 rules (common/web/zh)
│   ├── common/ (coding-style, security, testing...)
│   ├── web/ (design-quality, patterns, performance...)
│   └── zh/ (中文翻译)
│
├── scripts/
│   ├── install.sh               ← One-command bootstrap
│   ├── mcp-toggle.sh            ← MCP enable/disable/recipe/score/freshness
│   ├── mcp-health.sh            ← Health check + timing
│   └── mcp-freshness.sh         ← Staleness detection + auto-update
│
├── mcp-configs/
│   ├── on-demand-mcps.json      ← 17 cataloged MCPs
│   └── recipes.json             ← Multi-tool workflows
│
├── templates/project-claude-md/ ← Project quick-start
│   ├── react.md, python.md, node.md, nextjs.md, generic.md
│
└── docs/
    ├── architecture.md, agents-catalog.md
    └── logo-*.svg (4 variants)
```

---

## FAQ

**Is this just a collection of other people's work?**
No. The I2T Engine, Degradation Mesh, and Tool Rot Detection are original. The MCP configs, agents, and rules are battle-tested components from the community — organized, routed, and kept fresh by Harness. Think of it as an OS: the kernel is yours; the drivers are from the ecosystem.

**Does this work with Anthropic's official API?**
Yes. Edit `settings.json` → `env.ANTHROPIC_BASE_URL` to `https://api.anthropic.com`.

**Can I use only parts of it?**
Yes. Everything is optional. Use just the MCP catalog, or just the routing table, or the full stack.

**How do I contribute?**
See [CONTRIBUTING.md](CONTRIBUTING.md). Add MCPs, agents, recipes, or improve the routing table.

---

## License

MIT — use it, fork it, ship it.

---

<p align="center">
  <sub>Built to make Claude Code run at full power, from the first command.</sub>
</p>
