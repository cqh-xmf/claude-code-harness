# Contributing

## Welcome!

Claude Code Harness is a community project. New MCPs, skills, routing rules, and improvements are welcome.

## Ways to Contribute

### Add a new MCP
1. Test the MCP server locally
2. Add its config block to `mcp-configs/on-demand-mcps.json`
3. Add it to the appropriate group (search/media/platform/deploy/browser/tools)
4. Update CLAUDE.md routing table if applicable
5. Submit PR

### Add a new project template
1. Create `templates/project-claude-md/<name>.md`
2. Follow the existing template format
3. Include: project structure, tech stack, conventions, testing, commands, recommended tools
4. Submit PR

### Improve routing rules
The routing table in CLAUDE.md maps natural language → tools. If you find a mismatch:
1. Edit CLAUDE.md routing table
2. Explain the before/after in your PR description
3. Include an example conversation showing the improvement

### Fix bugs
1. Open an issue describing the bug
2. Include your environment (OS, Claude Code version, Node version)
3. PR with fix + explanation

## PR Guidelines

- Keep PRs focused (one feature/fix per PR)
- Update documentation if you change behavior
- Test on your platform before submitting
- Screenshots or terminal output welcome for UI/script changes

## Code Style

- Bash scripts: POSIX-compatible where possible, `set -euo pipefail`
- JSON: 2-space indent, no trailing commas
- Markdown: GitHub-flavored, wrap at 100 chars

## Issue Templates

### Bug Report
```
**Describe the bug**
**To Reproduce**
**Expected behavior**
**Environment (OS, Claude Code version, Node version)**
```

### Feature Request
```
**What would you like to add?**
**Why is it useful?**
**How should it work?**
```

## License

By contributing, you agree that your contributions will be licensed under the MIT License.
