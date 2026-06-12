# 技能自动发现与路由

> 此规则确保宝贵的技能和 MCP 不被遗忘，在每次任务中都会被主动考虑。

## 强制任务前检查

**接到任何任务时，第一反应不是写代码，而是查路由表。**

步骤：
1. 扫描 `~/.claude/CLAUDE.md` 中的路由表 — 有专门的工具吗？
2. 有 → **主动宣告**："这个我用 XXX 来做，它专门做这个的" → 然后调用
3. 没有 → 考虑：是否可以用多个已有工具组合完成？
4. 实在没有 → 才手写代码

## 宣告模板

当匹配到工具时，用自然语言告知用户：

> "这个我用 **[工具名]** 来做 — 它是专门做 **[一句话功能]** 的。"

例如：
- "这个 PPT 我用 `pptx` skill 来做，专门做幻灯片。"
- "代码审查我用 `code-reviewer` agent，会检查安全/质量/性能。"
- "我先用 `context7` MCP 查一下这个库的最新文档。"

## 自动触发规则

以下场景必须自动使用对应工具，不需要用户显式要求：

| 场景 | 自动行动 |
|------|----------|
| 写了代码之后 | 主动提议用 `code-reviewer` agent 审查 |
| 涉及认证/支付/用户数据 | 主动提议用 `security-reviewer` agent |
| 用户提到某个库/框架/SDK | 主动用 `context7` MCP 查文档 |
| 用户要搜索/调研 | 优先用 `WebSearch`，深度的用 `exa-web-search` |
| 需要网页内容 | 用 `WebFetch` 或 `firecrawl` MCP |
| 复杂的多步骤推理 | 用 `sequential-thinking` MCP |
| 新建功能/修 Bug | 提议用 `tdd-guide` agent 先写测试 |
| 架构级决策 | 用 `architect` agent 或 `EnterPlanMode` |

## 语言代码自动审查

写完任何代码后，根据语言自动选择审查 Agent：

| 语言 | Agent |
|------|-------|
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
| SQL | `database-reviewer` |
| ML | `mle-reviewer` |

## 防吃灰原则

> **没用过的工具等于没装。** 如果一个工具连续多次会话都没被用到，要么是触发条件太窄，要么是用户根本不知道它的存在。你要主动在合适的场景下介绍它。
