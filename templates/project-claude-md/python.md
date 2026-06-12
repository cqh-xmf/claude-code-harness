# CLAUDE.md — {{PROJECT_NAME}}

> 项目类型：Python
> 生成于：{{DATE}}
> 模板：~/.claude/templates/project-claude-md/python.md

---

## 项目结构

```
src/
├── __init__.py
├── main.py           # 入口
├── models/           # 数据模型
├── services/         # 业务逻辑
├── routes/           # API 路由 (FastAPI/Flask)
├── utils/            # 工具函数
└── config.py         # 配置
tests/
├── unit/
├── integration/
└── conftest.py       # fixtures
```

## 技术栈

- **语言**: Python {{PYTHON_VERSION}}
- **包管理**: uv / pip / poetry
- **Web 框架**: FastAPI / Flask / Django
- **数据库**: SQLAlchemy / SQLModel
- **测试**: pytest + pytest-cov
- **Lint**: ruff / black / mypy

## 编码约定

- 遵循 PEP 8
- snake_case 命名函数和变量
- PascalCase 命名类
- UPPER_CASE 命名常量
- 类型注解：所有公开函数必须有
- 用 dataclass / Pydantic 做数据模型
- 不可变模式：创建新对象，不修改旧对象

## 测试

- 框架：pytest
- 覆盖率：80%+
- AAA 模式：Arrange → Act → Assert
- conftest.py 放共享 fixtures
- 不 mock 数据库，用真实测试库

## 常用命令

```bash
pytest --cov=src --cov-report=term-missing  # 测试 + 覆盖率
ruff check .                                 # Lint
mypy src/                                    # 类型检查
python -m src.main                           # 运行
```

## 可用的 Claude Code 工具

| 场景 | 工具 |
|------|------|
| 写新功能 | `tdd-guide` agent (先写测试) |
| 代码审查 | `python-reviewer` agent |
| FastAPI 审查 | `fastapi-reviewer` agent |
| 查 Python/库文档 | `context7` MCP |
| 安全检查 | `security-reviewer` agent |
| GitHub 操作 | `github` MCP |
