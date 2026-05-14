# AGENTS

## 包信息

- **包名**: `django-quanttide-data`
- **目录**: `packages/django/`
- **语言**: Python 3.8+
- **包管理器**: Poetry
- **定位**: Django 模型与 REST API 序列化器

## 项目结构

```
packages/django/
├── django_quanttide_data/       # 核心包
│   ├── __init__.py
│   ├── apps.py
│   ├── models/
│   │   ├── __init__.py
│   │   └── entities/
│   │       ├── __init__.py
│   │       └── datasets.py
├── tests/                       # 测试
│   ├── __init__.py
│   ├── models.py
│   ├── settings.py
│   ├── test_apps.py
│   └── runtests.py
├── docs/                        # 文档
│   └── README.md
├── pyproject.toml
├── README.md
├── CHANGELOG.md
├── LICENSE
└── .gitignore
```

## 提交消息

- `feat:` — 新功能
- `chore:` — 版本号变更、配置更新
- `docs:` — 文档更新
- `fix:` — 修 bug

## 发布流程

遵循根目录 `.agents/skills/devops-release/SKILL.md`，关键流程：

1. **更新版本号** → 改 `pyproject.toml`
2. **写 CHANGELOG** → 更新 `CHANGELOG.md`
3. **提交** → `chore: bump django-quanttide-data to vX.Y.Z`
4. **打 tag** → `django/vX.Y.Z`
5. **推送** → CI 自动发布到 PyPI

## 命名约定

- 包名（PyPI）: `django-quanttide-data`
- 导入名: `django_quanttide_data`
- 仓库 tag 前缀: `django/`