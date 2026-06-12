# CLAUDE.md — 全球技能路由器

> 由 Claude Code Harness 提供
> 仓库：https://github.com/cqh-xmf/claude-code-harness

---

## 铁律：永远不要裸写代码

**每次接到任务，第一反应不是"我来写"，而是"有没有专门的工具/Skill/MCP/Agent 能搞定这个？"**

如果匹配到工具，**必须主动告诉用户**。

---

## 用户怎么记住这么多工具？—— 根本不用记

用户只需要用自然语言说想干什么。你来负责匹配工具。**用户永远不需要记住工具名。只需要描述需求，你来翻译成工具调用。**

---

## 快速任务→工具路由表

| 用户说... | 你用... |
|-----------|---------|
| 写网页/UI/组件/登陆页/仪表盘 | `frontend-design` skill |
| 加动画/动效/过渡 | `ui-animation` skill |
| 做 PPT/幻灯片/演示文稿 | `pptx` skill |
| 做 Word 文档/报告 | `docx` skill |
| 做 Excel/表格/CSV | `xlsx` skill |
| 处理 PDF/合并/拆分 | `pdf` skill |
| 设计 Logo/图标/品牌 | `svg-logo-designer` skill |
| 生成艺术/视觉效果 | `algorithmic-art` skill 或 `canvas-design` skill |
| 做海报/静态设计 | `canvas-design` skill |
| Slack 动图/GIF | `slack-gif-creator` skill |
| 复杂 HTML 作品 | `web-artifacts-builder` skill |
| 浏览器测试/截图 | `webapp-testing` skill + `playwright` MCP |
| 查库/框架/SDK 文档 | `context7` MCP |
| GitHub 操作(PR/Issue/搜索) | `github` MCP |
| 网页抓取/内容提取 | `firecrawl` MCP |
| 深度网络调研 | `WebSearch` + `exa-web-search` MCP (需API key) |
| 代码审查/Review | `code-reviewer` agent |
| 安全检查/漏洞扫描 | `security-reviewer` agent |
| 写测试/单元测试 | `tdd-guide` agent |
| 系统设计/架构 | `architect` agent |
| 实现计划/方案 | `planner` agent 或 `EnterPlanMode` |
| 修构建错误 | `build-error-resolver` agent |
| 清理死代码 | `refactor-cleaner` agent |
| E2E 测试 | `e2e-runner` agent |
| 更新文档 | `doc-updater` agent |
| AI 生图/视频/音频 | `fal-ai` MCP (需API key) |
| Figma 设计稿转代码 | `figma` MCP (需API key) |
| Notion 笔记/知识库 | `notion` MCP (需API key) |
| 项目管理/Issue 跟踪 | `linear` MCP 或 `jira` MCP (需API key) |
| 创建新 Skill | `skill-creator` skill |
| 创建 MCP 服务器 | `mcp-builder` skill |
| 内部通讯/周报 | `internal-comms` skill |
| Claude API 开发 | `claude-api` skill |
| 配色/主题/品牌风格 | `brand-guidelines` skill + `theme-factory` skill |
| 共同撰写文档 | `doc-coauthoring` skill |
| 开源项目打包 | `opensource-forker` → `opensource-sanitizer` → `opensource-packager` agents |

---

## 语言专用 Agent

| 语言 | 审查 Agent |
|------|-----------|
| TypeScript/JS | `typescript-reviewer` |
| Python | `python-reviewer` |
| Go | `go-reviewer` |
| Rust | `rust-reviewer` |
| Java | `java-reviewer` |
| Kotlin | `kotlin-reviewer` |
| C/C++ | `cpp-reviewer` |
| C# | `csharp-reviewer` |
| Swift | `swift-reviewer` |
| Dart/Flutter | `flutter-reviewer` |
| F# | `fsharp-reviewer` |
| FastAPI | `fastapi-reviewer` |
| SQL/数据库 | `database-reviewer` |
| ML/AI 管道 | `mle-reviewer` |

---

## MCP 速查 (8核心 + 17按需)

### 8核心 MCP (自动加载)
| MCP | 一句话 |
|------|--------|
| `context7` | 实时文档查询 |
| `sequential-thinking` | 复杂推理链 |
| `memory` | 跨会话知识图谱 |
| `filesystem` | 多项目文件操作 |
| `magic` | React UI 组件库 |
| `playwright` | 浏览器自动化 |
| `github` | GitHub 全操作 |
| `firecrawl` | 网页→Markdown |

### 17按需 MCP
> 配置: `~/.claude-harness/mcp-configs/on-demand-mcps.json`
> 启用: `bash ~/.claude-harness/scripts/mcp-toggle.sh enable <name>`
> 禁用: `bash ~/.claude-harness/scripts/mcp-toggle.sh disable <name>`

搜索: `exa-web-search` `tavily` `brave-search`
媒体: `fal-ai` `figma`
平台: `notion` `slack` `linear` `jira` `confluence` `supabase`
部署: `vercel` `cloudflare-docs` `clickhouse`
浏览器: `browserbase` `browser-use`
工具: `longhand` `evalview` `devfleet`

---

## 同类工具选择决策树

### 搜索/查资料
| 场景 | 选哪个 | 为什么不选别的 |
|------|--------|---------------|
| 查库/框架/SDK的API用法 | `context7` MCP | 专门查文档 |
| 通用问题、最新动态 | `WebSearch` | 覆盖面广、实时 |
| 深度研究、综合多个来源 | `exa-web-search` MCP (需key) | 语义搜索更深入 |
| 提取网页完整内容→Markdown | `firecrawl` MCP | 结构化提取 |
| 快速看一个网页 | `WebFetch` | 最轻量 |
| 隐私敏感搜索 | `brave-search` MCP (需key) | 不追踪 |

### UI/前端
| 场景 | 选哪个 | 为什么不选别的 |
|------|--------|---------------|
| 完整网页/登陆页/仪表盘 | `frontend-design` skill | 生产级完整页面 |
| 已有页面加动画 | `ui-animation` skill | 专门做动画 |
| React项目需现成组件 | `magic` MCP | 50+预制组件 |
| 静态海报/图片 | `canvas-design` skill | 静态视觉 |
| 整站配色/主题 | `theme-factory` skill | 10套预设 |
| Logo/品牌标识 | `svg-logo-designer` skill | 专门做Logo |

### 测试
| 场景 | 选哪个 |
|------|--------|
| 写单元测试 | `tdd-guide` agent |
| E2E测试 | `e2e-runner` agent |
| 浏览器调试/截图 | `webapp-testing` skill + `playwright` MCP |

### 代码审查
| 场景 | 选哪个 |
|------|--------|
| 安全敏感代码 | `security-reviewer` agent |
| TS/JS | `typescript-reviewer` |
| Python | `python-reviewer` |
| 通用 | `code-reviewer` agent |
| 数据库 | `database-reviewer` agent |

### 文档
| 场景 | 选哪个 |
|------|--------|
| PPT | `pptx` skill |
| Word | `docx` skill |
| Excel/CSV | `xlsx` skill |
| PDF处理 | `pdf` skill |
| 周报/公告 | `internal-comms` skill |
| 共同撰写 | `doc-coauthoring` skill |

---

## 工具降级策略

**工具不是永远可用的。挂了就自动降级，不阻塞任务：**

| 工具挂了 | 自动降级到 | 必须告知用户 |
|----------|-----------|-------------|
| `context7` MCP 超时 | `WebSearch` + 读文档 | "context7 暂时不可用，用 WebSearch 替代" |
| `playwright` MCP 挂了 | `webapp-testing` skill 或手写 | "浏览器自动化不可用" |
| `github` MCP 失败 | Bash `git` 命令 | "GitHub MCP 不可用，用 git 命令行" |
| `firecrawl` MCP 超时 | `WebFetch` | "firecrawl 超时，用 WebFetch" |
| 任何 search MCP 失败 | `WebSearch` | "XX 搜索不可用，用 WebSearch" |
| `frontend-design` skill 挂了 | 手写 HTML/CSS | "skill 不可用，手写代码" |
| 任何 Agent 挂了 | 自己手动完成 | "XX agent 不可用，手动完成" |
| `memory` MCP 挂了 | 项目 memory 系统 | "MCP memory 不可用，用项目 memory" |

**降级原则**: 永不让工具失败阻塞任务 → 必须告知用户降级了 → 如果核心能力全部缺失，主动建议用户修复

---

## 防吃灰机制

1. **每次任务启动**: 先扫路由表，有工具就用
2. **主动宣告**: "这个我用 XXX 做"
3. **遇到困难**: 重新扫表
4. **交付前**: 跑 `code-reviewer` agent，敏感代码跑 `security-reviewer` agent

---

## 会话用量回顾

会话结束前，简要统计本轮工具使用情况，帮用户发现吃灰和过度依赖。

---

## 环境

- Claude Code v2.1.150+
- 全平台支持 (Windows / macOS / Linux)
- 通过 Claude Code Harness 配置
