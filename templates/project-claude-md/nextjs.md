# CLAUDE.md — {{PROJECT_NAME}}

> 项目类型：Next.js / React 全栈
> 生成于：{{DATE}}
> 模板：~/.claude/templates/project-claude-md/nextjs.md

---

## 项目结构

```
src/
├── app/              # App Router (Next.js 13+)
│   ├── layout.tsx
│   ├── page.tsx
│   └── api/          # API Routes
├── components/       # UI 组件
│   └── ui/           # shadcn/ui 组件
├── lib/              # 工具、API 客户端
├── hooks/            # 自定义 hooks
└── styles/           # 全局样式
```

## 技术栈

- **框架**: Next.js {{NEXTJS_VERSION}}
- **语言**: TypeScript
- **样式**: Tailwind CSS / shadcn/ui
- **数据**: TanStack Query / Server Components
- **数据库**: Prisma / Drizzle + PostgreSQL
- **认证**: NextAuth.js / Clerk
- **测试**: Vitest + Playwright

## 编码约定

- 优先用 Server Components，只在需要交互时用 `'use client'`
- 数据获取用 Server Components 的 async/await，不用 useEffect
- URL 做状态：search params 存筛选、排序、分页
- 组件文件 < 300 行
- 不可变数据，用 spread 不用 mutation

## 测试

- 单元：Vitest
- E2E：Playwright
- 视觉回归：Playwright 截图
- 覆盖率：80%+

## 常用命令

```bash
pnpm dev          # next dev
pnpm build        # next build
pnpm test         # vitest
pnpm e2e          # playwright test
pnpm lint         # next lint
```

## 可用的 Claude Code 工具

| 场景 | 工具 |
|------|------|
| 写页面/组件 | `frontend-design` skill |
| 加动画 | `ui-animation` skill |
| 现成 UI 组件 | `magic` MCP |
| 代码审查 | `typescript-reviewer` agent |
| E2E 测试 | `e2e-runner` agent |
| 浏览器截图 | `playwright` MCP |
| 部署到 Vercel | `vercel` MCP (需按需启用) |
| 查 Next.js 文档 | `context7` MCP |
