# Claude Code Harness（中文）

<p align="right">
  <a href="README.md">English</a>
</p>

<p align="center">
  <b>让 Claude Code 从"聊天工具"变成"全栈 AI 开发平台"。</b><br>
  8 核心 MCP · 23 Skills · 30 Agents · 决策树路由 · 降级容错
</p>

<p align="center">
  <img src="docs/screenshots/demo.gif" width="700" alt="演示">
</p>

<p align="center">
  <a href="LICENSE"><img src="https://img.shields.io/badge/license-MIT-blue.svg"></a>
  <a href="#"><img src="https://img.shields.io/badge/platform-Windows%20%7C%20macOS%20%7C%20Linux-brightgreen.svg"></a>
  <a href="#"><img src="https://img.shields.io/badge/PRs-welcome-brightgreen.svg"></a>
</p>

---

## 这是什么？

Claude Code 安装后**零预配置**。每个用户都要花数小时：

- 一个一个接线 MCP 服务器
- 从零写 CLAUDE.md
- 找 Skill、装 Skill
- 调试认证和路径
- 搞清楚什么任务该用什么工具

**这套 Harness 让你一条命令获得经过实战验证的生产级配置。**

---

## 一条命令安装

```bash
git clone https://github.com/cqh-xmf/claude-code-harness.git ~/.claude-harness
bash ~/.claude-harness/scripts/install.sh
```

重启 Claude Code。搞定。

---

## 你能得到什么

### 8 个核心 MCP（预配置，自动启动）

| MCP | 功能 |
|-----|------|
| `context7` | 实时文档查询（任何库/框架/SDK） |
| `sequential-thinking` | 复杂问题的链式推理 |
| `memory` | 跨会话知识图谱 |
| `filesystem` | 限定范围的文件操作 |
| `magic` | 50+ 动画 React UI 组件 |
| `playwright` | 浏览器自动化与测试 |
| `github` | GitHub 全操作（PR、Issue、搜索） |
| `firecrawl` | 网页抓取 → Markdown |

### 17 个按需 MCP（已编目，一条命令启用）

搜索类：`exa-web-search`、`tavily`、`brave-search`
媒体类：`fal-ai`、`figma`
平台类：`notion`、`slack`、`linear`、`jira`、`confluence`、`supabase`
部署类：`vercel`、`cloudflare-docs`、`clickhouse`
浏览器类：`browserbase`、`browser-use`
工具类：`longhand`、`evalview`、`devfleet`

```bash
bash ~/.claude-harness/scripts/mcp-toggle.sh enable fal-ai    # 启用单个
bash ~/.claude-harness/scripts/mcp-toggle.sh enable-all search # 启用整组
bash ~/.claude-harness/scripts/mcp-toggle.sh list              # 查看全部
```

### 智能工具路由

你说人话，路由器自动匹配工具。

| 你说... | 它用... |
|---------|---------|
| "帮我做个 PPT" | `pptx` skill |
| "写个落地页" | `frontend-design` skill |
| "给这个组件加动画" | `ui-animation` skill |
| "审查我的代码" | `code-reviewer` agent |
| "帮我写测试" | `tdd-guide` agent |
| "检查安全问题" | `security-reviewer` agent |
| "React 19 的 API 怎么用？" | `context7` MCP |
| "抓取那个网页" | `firecrawl` MCP |
| "设计一个 Logo" | `svg-logo-designer` skill |

### 降级容错

工具挂了不阻塞任务，自动降级。

| 工具故障 | 自动降级 |
|----------|---------|
| `context7` 超时 | WebSearch + 手动读文档 |
| `playwright` 挂了 | `webapp-testing` skill |
| `github` MCP 失败 | 原生 `git` 命令 |
| `firecrawl` 超时 | `WebFetch` |
| 任何 search MCP | `WebSearch` |
| 任何 Agent | 手动完成 |

### 防吃灰系统

长期不用的工具被标记，不浪费上下文窗口。

### 项目模板

新项目一键获得专业 CLAUDE.md。

```bash
cp ~/.claude-harness/templates/project-claude-md/react.md ./CLAUDE.md
```

模板：`react` · `python` · `node` · `nextjs` · `generic`

### 健康检查 + 性能基线

```bash
bash ~/.claude-harness/scripts/mcp-health.sh
```

输出：活跃 MCP 列表、冷启动耗时、Token 状态、运行时版本。

---

## 架构

```
                    ┌─────────────────────────────┐
                    │     CLAUDE.md（路由器）       │
                    │   "用户想要什么？"            │
                    └─────────────┬───────────────┘
                                  │
          ┌───────────────────────┼───────────────────────┐
          │                       │                       │
          ▼                       ▼                       ▼
   ┌──────────────┐      ┌──────────────┐      ┌──────────────┐
   │  8 核心 MCP  │      │  23 Skills   │      │  30 Agents   │
   │  （自动加载）│      │  （按需调用） │      │  （按需调用） │
   └──────────────┘      └──────────────┘      └──────────────┘
          │                       │                       │
          └───────────────────────┼───────────────────────┘
                                  │
                          ┌───────▼────────┐
                          │   降级映射表    │
                          │  工具A↓ → B    │
                          └────────────────┘
```

---

## 文件结构

```
claude-code-harness/
├── README.md                   ← 英文版
├── README_ZH.md                ← 你在这里
├── LICENSE                     ← MIT
├── .gitignore                  ← 保护你的密钥
├── CLAUDE.md                   ← 路由器（复制到 ~/.claude/）
├── settings.template.json      ← MCP 配置模板
├── scripts/
│   ├── install.sh              ← 一键安装
│   ├── mcp-toggle.sh           ← MCP 开关
│   └── mcp-health.sh           ← 健康检查
├── mcp-configs/
│   └── on-demand-mcps.json     ← 17 个按需 MCP 目录
├── templates/
│   └── project-claude-md/      ← 项目级 CLAUDE.md 模板
└── docs/
    ├── architecture.md
    ├── agents-catalog.md
    └── screenshots/
```

---

## 环境要求

- **Claude Code** v2.1.150+（全平台）
- **Node.js** 18+（npx MCP 需要）
- **Git**（github MCP 需要）
- **Python 3**（mcp-toggle.sh 需要）

### 可选 Token（完整功能需要）

| Token | 用途 | 获取地址 |
|-------|------|---------|
| `DEEPSEEK_API_KEY` | 使用 DeepSeek 代理 | platform.deepseek.com |
| `GITHUB_PAT` | GitHub MCP | github.com/settings/tokens |
| `FIRECRAWL_API_KEY` | 网页抓取 | firecrawl.dev |

---

## 安全说明

- **绝对不要提交 `settings.json`** — 它包含 API 密钥。使用 `settings.template.json`。
- 所有 MCP 命令在本地运行。数据不会离开你的机器（除非你显式配置的 API）。
- API 密钥从环境变量读取（模板中不硬编码）。
- `.gitignore` 阻止 `settings.json`、`.env`、备份文件、个人目录被提交。

---

## 常见问题

**Q: 这会覆盖我现有的 CLAUDE.md 吗？**
A: 不会。Harness 的 CLAUDE.md 放在 `~/.claude/CLAUDE.md`（全局），你的项目 CLAUDE.md 仍在项目根目录。两者都会被加载。

**Q: 我已经配了一些 MCP，怎么办？**
A: install.sh 会先备份你现有的 `settings.json`，再生成新的。

**Q: 能删掉不需要的 MCP 吗？**
A: 能。`mcp-toggle.sh disable <名字>` 干净移除。或者直接编辑 `settings.json`。

**Q: 能用 Anthropic 官方 API 吗？**
A: 能。在 `settings.json` 顶层 `env` 里设置 `ANTHROPIC_BASE_URL` 和 `ANTHROPIC_AUTH_TOKEN` 即可。

---

## 贡献

见 [CONTRIBUTING.md](CONTRIBUTING.md)。

欢迎提交新的 MCP、Skill、路由规则。开 Issue 或 PR。

---

## 许可证

MIT — 随便用、随便改、随便发布。

---

<p align="center">
  <sub>为想让 Claude Code 一启动就满血的开发者而生。</sub>
</p>
