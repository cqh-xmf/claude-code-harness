# CLAUDE.md — {{PROJECT_NAME}}

> 项目类型：React / TypeScript
> 生成于：{{DATE}}
> 模板：~/.claude/templates/project-claude-md/react.md

---

## 项目结构

```
src/
├── components/       # UI 组件，按功能组织
├── hooks/            # 自定义 hooks
├── lib/              # 工具函数、API 客户端
├── styles/           # 全局样式、CSS tokens
└── types/            # TypeScript 类型定义
```

## 技术栈

- **框架**: React {{REACT_VERSION}}
- **语言**: TypeScript
- **构建**: Vite / Next.js / CRA
- **样式**: Tailwind CSS / CSS Modules / styled-components
- **状态**: Zustand / Jotai / Context
- **请求**: TanStack Query / SWR / axios

## 编码约定

- 组件用 PascalCase：`UserProfile.tsx`
- Hooks 用 `use` 前缀：`useAuth.ts`
- 工具函数 camelCase：`formatDate.ts`
- 类型定义 PascalCase：`User.ts`
- 一个组件一个文件，控制在 300 行以内
- 用 compound components 模式处理复杂 UI
- 数据获取和展示分离 (container/presentational)

## 测试

- 单元测试：Vitest + React Testing Library
- E2E：Playwright
- 覆盖率目标：80%+
- 视觉组件用截图测试比快照更有意义

## 常用命令

```bash
pnpm dev          # 启动开发服务器
pnpm build        # 生产构建
pnpm test         # 运行测试
pnpm lint         # ESLint
pnpm typecheck    # TypeScript 类型检查
```

## 可用的 Claude Code 工具

本项目的 CLAUDE.md 与全局 CLAUDE.md 合并使用。React 项目特别推荐：

| 场景 | 工具 |
|------|------|
| 写新组件 | `frontend-design` skill |
| 加动画 | `ui-animation` skill |
| 代码审查 | `typescript-reviewer` agent |
| 查 React/TS 文档 | `context7` MCP |
| 浏览器测试 | `playwright` MCP |
| 现成 UI 组件 | `magic` MCP |
