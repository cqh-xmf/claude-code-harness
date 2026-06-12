# CLAUDE.md — {{PROJECT_NAME}}

> 项目类型：通用
> 生成于：{{DATE}}
> 模板：~/.claude/templates/project-claude-md/generic.md

---

## 项目信息

- **名称**: {{PROJECT_NAME}}
- **描述**: {{PROJECT_DESCRIPTION}}
- **语言/框架**: {{TECH_STACK}}

## 项目结构

```
# TODO: 补充实际项目结构
```

## 编码约定

- 函数 < 50 行，文件 < 800 行
- 不可变数据模式
- 显式错误处理
- 系统边界验证输入
- 不硬编码密钥和配置

## 测试

- 覆盖率目标：80%+
- AAA 模式：Arrange → Act → Assert

## 常用命令

```bash
# TODO: 补充开发命令
```

## 可用的 Claude Code 工具

请参考全局 CLAUDE.md (`~/.claude/CLAUDE.md`) 了解完整的工具路由表。

本项目的全局 CLAUDE.md 已经配置了：
- 8 个核心 MCP (context7, sequential-thinking, memory, filesystem, magic, playwright, github, firecrawl)
- 23+ Skills (frontend-design, pptx, docx, xlsx, pdf, ui-animation 等)
- 50+ Agents (code-reviewer, security-reviewer, tdd-guide, 语言专用 reviewer 等)
- 17 个按需 MCP (搜索、部署、平台集成等)

当前项目特别推荐的工具：

| 场景 | 推荐工具 |
|------|---------|
| 代码审查 | 根据语言选择合适的 reviewer agent |
| 写测试 | `tdd-guide` agent |
| 实现规划 | `planner` agent |
| 安全检查 | `security-reviewer` agent |
