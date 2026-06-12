# Agents Catalog

> 30+ specialized agents for code review, testing, architecture, and more.
> Agents are invoked by Claude Code on-demand. You don't call them directly —
> the routing table in CLAUDE.md decides when to use each one.

---

## General Purpose

| Agent | Purpose | Auto-trigger |
|-------|---------|-------------|
| `code-reviewer` | General code quality, patterns, best practices | After writing code |
| `security-reviewer` | Security vulnerabilities, OWASP Top 10 | Auth/payment/user-data changes |
| `tdd-guide` | Test-driven development workflow | New features, bug fixes |
| `architect` | System design and architecture decisions | Architectural changes |
| `planner` | Implementation planning | Complex features, refactoring |
| `build-error-resolver` | Fix build and compilation errors | Build failures |
| `e2e-runner` | End-to-end testing | Critical user flows |
| `refactor-cleaner` | Dead code cleanup | Code maintenance |
| `doc-updater` | Documentation updates | After API/interface changes |

---

## Language-Specific

| Language | Reviewer Agent | Build Resolver |
|----------|---------------|----------------|
| TypeScript/JavaScript | `typescript-reviewer` | — |
| Python | `python-reviewer` | — |
| Go | `go-reviewer` | `go-build-resolver` |
| Rust | `rust-reviewer` | `rust-build-resolver` |
| Java | `java-reviewer` | `java-build-resolver` |
| Kotlin | `kotlin-reviewer` | `kotlin-build-resolver` |
| C/C++ | `cpp-reviewer` | `cpp-build-resolver` |
| C# | `csharp-reviewer` | — |
| Swift | `swift-reviewer` | `swift-build-resolver` |
| Dart/Flutter | `flutter-reviewer` | `dart-build-resolver` |
| F# | `fsharp-reviewer` | — |
| FastAPI | `fastapi-reviewer` | — |
| SQL/Database | `database-reviewer` | — |
| ML/AI Pipeline | `mle-reviewer` | `pytorch-build-resolver` |

---

## Specialized

| Agent | Purpose |
|-------|---------|
| `performance-optimizer` | Performance analysis and optimization recommendations |
| `a11y-architect` | Accessibility audit and WCAG compliance |
| `network-architect` | Network topology and configuration design |
| `homelab-architect` | Home lab and self-hosted infrastructure design |
| `healthcare-reviewer` | Healthcare/medical software compliance review |
| `seo-specialist` | SEO analysis and recommendations |
| `silent-failure-hunter` | Detect swallowed errors and silent failures |
| `type-design-analyzer` | Type system design review |

---

## Open Source Pipeline

Three-stage pipeline for preparing projects for public release:

| Stage | Agent | What it does |
|-------|-------|-------------|
| 1. Fork | `opensource-forker` | Copies files, strips secrets (20+ patterns), replaces internal references |
| 2. Sanitize | `opensource-sanitizer` | Scans for leaked secrets/PII, generates PASS/FAIL report |
| 3. Package | `opensource-packager` | Generates CLAUDE.md, README, LICENSE, setup.sh, issue templates |

---

## How Agents Work

1. CLAUDE.md routing table maps task → agent
2. Agent is launched as a sub-process with specific instructions
3. Agent uses a subset of Claude Code tools to complete its task
4. Results are returned to the main conversation

## Adding New Agents

1. Create agent definition in `~/.claude/agents/`
2. Add routing rule in CLAUDE.md
3. Test with a real task
4. Submit PR to claude-code-harness
