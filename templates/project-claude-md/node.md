# CLAUDE.md — {{PROJECT_NAME}}

> 项目类型：Node.js / TypeScript (通用)
> 生成于：{{DATE}}
> 模板：~/.claude/templates/project-claude-md/node.md

---

## 项目结构

```
src/
├── index.ts          # 入口
├── lib/              # 工具库
├── routes/           # 路由/控制器
├── services/         # 业务逻辑
├── types/            # TypeScript 类型
└── config.ts         # 配置
tests/
├── unit/
└── integration/
```

## 技术栈

- **运行时**: Node.js {{NODE_VERSION}}
- **语言**: TypeScript
- **包管理**: pnpm / npm / yarn
- **框架**: Express / Fastify / Hono
- **数据库**: Prisma / Drizzle
- **测试**: Vitest / Jest
- **Lint**: ESLint + Prettier

## 编码约定

- 文件 < 400 行，函数 < 50 行
- 不可变模式：spread、concat、filter，不用 push/splice
- 异步：async/await，不用回调
- 错误处理：永远不要 silent catch，显式处理或 re-throw
- 类型：禁止 `any`，优先用 `unknown` + narrowing
- 命名：PascalCase 组件/类型，camelCase 变量/函数，UPPER_CASE 常量

## 测试

- Vitest 或 Jest
- 覆盖率 80%+
- AAA 模式
- 集成测试用真实数据库或 Docker 容器

## 常用命令

```bash
pnpm dev          # 开发
pnpm build        # 构建
pnpm test         # 测试
pnpm lint         # ESLint
pnpm typecheck    # tsc --noEmit
```

## 可用的 Claude Code 工具

| 场景 | 工具 |
|------|------|
| 代码审查 | `typescript-reviewer` agent |
| 查 Node/库文档 | `context7` MCP |
| 网页抓取 | `firecrawl` MCP |
| GitHub 操作 | `github` MCP |
| 安全检查 | `security-reviewer` agent |
