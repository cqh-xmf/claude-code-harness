# Claude Code Harness

<p align="right">
  <a href="README.md">English</a>
</p>

<p align="center">
  <img src="docs/logo-horizontal.svg" width="600" alt="Claude Code Harness">
</p>

<p align="center">
  <b>Claude Code 的操作系统。</b><br>
  意图映射 · 网状容错 · 工具腐化检测
</p>

<p align="center">
  <a href="LICENSE"><img src="https://img.shields.io/badge/license-MIT-blue"></a>
  <a href="#"><img src="https://img.shields.io/badge/platform-Windows%20%7C%20macOS%20%7C%20Linux-brightgreen"></a>
  <a href="CONTRIBUTING.md"><img src="https://img.shields.io/badge/PRs-welcome-brightgreen"></a>
  <img src="https://img.shields.io/badge/agents-91-blueviolet">
  <img src="https://img.shields.io/badge/MCPs-8核心_+_17按需-orange">
</p>

---

## Before vs After

|  | 裸 Claude Code | 装了 Harness |
|--|---------------|-------------|
| **安装配置** | 手动接线 MCP，3小时起步 | `bash install.sh`，一条命令 |
| **工具选择** | "做PPT该用哪个skill？" | **I2T 引擎** — 说人话就行 |
| **工具挂了** | 任务卡住，手动排查 | **网状容错** — 三层自动降级 |
| **闲置工具** | 永远占着上下文 | **工具腐化检测** — 自动标记清理 |
| **代码审查** | 手动选 agent | 14 种语言自动路由 |
| **新项目** | 从零写 CLAUDE.md | `cp templates/react.md ./CLAUDE.md` |
| **Token 预算** | 要么全加载要么裸奔 | 8核心自动 + 17按需 = 精细管理 |
| **过期检测** | 不知道哪些已经落后 | `mcp freshness` — 自动检查更新 |

---

## 为什么不一样

### I2T 引擎（意图→工具映射）

你说人话，它做推理。路由表本质上是一个 **自然语言编译器**——把人类意图翻译成工具执行链。

```
你：审查 src/auth.ts 的安全问题

I2T 引擎内部决策链：
  ├─ 检测到 TypeScript 文件 → 选用 typescript-reviewer
  ├─ 检测到 "auth"+"安全" 关键词 → 叠加 security-reviewer
  ├─ 检测到 src/ 路径 → 追加 code-reviewer
  └─ 三个 agent 并行执行 → 返回综合报告

你只说了一句话。三个 agent 自动运行。零工具名记忆。
```

### 网状容错

不是简单的"A坏了用B"。是 **三层深的网状降级**：

```
context7 超时 → WebSearch 搜文档 → 请求用户提供URL
playwright 挂了 → webapp-testing skill → 手写浏览器指令
github MCP 失败 → 原生 git CLI → gh CLI → 手动 git 命令
firecrawl 超时 → WebFetch → 请求用户提供页面内容
```

每个工具都有多层后路。任务绝不会因为一个 MCP 挂了就卡住。

### 工具腐化检测

就像死代码检测，但是给 AI 工具用的。长期未使用的 MCP 和 Agent 被标记，保持上下文窗口精简。

---

## 一条命令

```bash
git clone https://github.com/cqh-xmf/claude-code-harness.git ~/.claude-harness
bash ~/.claude-harness/scripts/install.sh
```

部署内容包括：
- **CLAUDE.md** — I2T 路由引擎
- **91 个 Agent** — 语言审查、安全审计、测试、规划...
- **29 条 Rules** — 编码规范、安全策略、测试标准
- **8 个核心 MCP** — context7, playwright, github, firecrawl, memory, filesystem, magic, sequential-thinking
- **17 个按需 MCP** — 一条命令启用：`mcp enable fal-ai`
- **5 套项目模板** — React, Python, Node, Next.js, 通用
- **管理 CLI** — `mcp list`, `mcp health`, `mcp freshness`, `mcp recipe`

---

## CLI 命令

```bash
mcp list              # 查看所有 MCP，按类别分组
mcp enable <名称>     # 启用任意按需 MCP
mcp disable <名称>    # 禁用（核心 MCP 受保护）
mcp enable-all search # 一次启用整组
mcp health            # 健康检查 + 冷启动耗时
mcp freshness         # 检查 MCP 更新 + 新发现
mcp recipe <配方名>   # 触发多工具组合工作流
mcp score             # 获取 Harness Score（0-100）
```

---

## 保鲜系统 — 活的配置

和静态配置合集不同，Harness 能检测过期：

```bash
$ mcp freshness

正在检查 25 个 MCP（npm registry）...
  context7:      @upstash/context7-mcp      ✅ 最新 (v2.1.0)
  firecrawl:     firecrawl-mcp              ⚠️  v1.2.0 → v1.3.1 可更新
  tavily:        @tavily/mcp-server-tavily  ✅ 最新
  ...

Agent (91):  检查上游 ECC 仓库...  3 个可更新
Rules (29):  检查上游 ECC 仓库...  已是最新

保鲜分: 84/100
  执行: mcp update 进行更新
```

再也不用猜工具是不是过时了。

---

## Harness Score

```bash
$ mcp score

  Claude Code Harness 评分: 87/100

  MCP 在线率:      8/8   (25 分) ✅
  Token 配置:      2/3   (12 分) ⚠️  FIRECRAWL_API_KEY 未设
  Agent 就绪:     91/91  (20 分) ✅
  Rules 生效:     29/29  (15 分) ✅
  保鲜度:          84%   (10 分) ⚠️  3 个可更新
  配方:             0/4   (0 分)  💡 试试: mcp recipe list
  模板:             5/5   (5 分)  ✅
```

晒分数、比分数、不断提升。

---

## 架构

```
你说："帮我做个落地页"
         │
         ▼
┌─────────────────────────────────┐
│       I2T 引擎 (CLAUDE.md)      │
│  意图 → 工具映射                 │
│  "落地页" → frontend-design      │
└─────────────┬───────────────────┘
              │
    ┌─────────┼─────────┐
    ▼         ▼         ▼
┌────────┐ ┌────────┐ ┌────────┐
│ 8 核心 │ │23 Skill│ │91 Agent│
│  MCP   │ │        │ │        │
└───┬────┘ └───┬────┘ └───┬────┘
    │          │          │
    └──────────┼──────────┘
               │
    ┌──────────▼──────────┐
    │     网状容错         │
    │  工具A↓ → B↓ → C    │
    └──────────┬──────────┘
               │
    ┌──────────▼──────────┐
    │    工具腐化检测      │
    │  闲置 → 标记 → 清理  │
    └─────────────────────┘
```

---

## 文件结构

```
claude-code-harness/
├── README.md + README_ZH.md    ← 中英双语
├── CLAUDE.md                    ← I2T 引擎（路由器）
├── settings.template.json       ← MCP 配置模板（无真实密钥）
├── LICENSE (MIT) + .gitignore
│
├── agents/                      ← 91 个 Agent
├── rules/                       ← 29 条 Rules (common/web/zh)
├── scripts/                     ← 管理脚本
├── mcp-configs/                 ← MCP 目录 + 工具配方
├── templates/project-claude-md/ ← 项目快速启动模板
└── docs/                        ← 架构文档 + Logo
```

---

## 常见问题

**这只是别人东西的合集吗？**
不是。I2T 引擎、网状容错、工具腐化检测是原创。MCP 配置、Agent、Rules 来自社区——由 Harness 组织、路由、保鲜。类比操作系统：内核是你的，驱动来自生态。

**能用 Anthropic 官方 API 吗？**
能。编辑 `settings.json` → `env.ANTHROPIC_BASE_URL` 改为 `https://api.anthropic.com`。

**能只用一部分吗？**
能。全部可选。只用 MCP 目录，或只用路由表，或全栈。

**怎么贡献？**
见 [CONTRIBUTING.md](CONTRIBUTING.md)。欢迎添加 MCP、Agent、配方，或改进路由表。

---

## 许可证

MIT — 随便用、随便改、随便发布。

---

<p align="center">
  <sub>让 Claude Code 从第一条命令开始就满血运行。</sub>
</p>
