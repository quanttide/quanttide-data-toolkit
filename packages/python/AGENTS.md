# AGENTS

## 包信息

- **包名**: `quanttide-data`
- **目录**: `packages/python/`
- **语言**: Python 3.10+
- **包管理器**: uv
- **定位**: 数据操作 SDK（Pydantic 模型）

## 项目结构

```
packages/python/
├── src/
│   └── quanttide_data/    # 核心包
│       ├── __init__.py
│       ├── config.py         # 配置管理
│       ├── crawlers.py       # 数据爬取器
│       ├── processors.py     # 数据处理器
│       ├── datasets/         # 数据集模块
│       │   ├── __init__.py
│       │   ├── datasets.py
│       │   ├── records.py
│       │   └── schemas.py
│       └── default_settings.yml
├── tests/                # 测试
│   ├── datasets/
│   │   └── test_datasets.py
│   └── __init__.py
├── examples/             # 示例
│   ├── __init__.py
│   ├── catalog.py
│   └── mlscraper/
├── pyproject.toml
├── uv.lock
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

1. **更新版本号** → 改 `pyproject.toml`，跑 `uv lock` 同步 lock 文件
2. **写 CHANGELOG** → 更新 `CHANGELOG.md`
3. **提交** → `chore: bump quanttide-data to vX.Y.Z`
4. **打 tag** → `python/vX.Y.Z`
5. **推送** → CI 自动发布到 PyPI

## 命名约定

- 包名（PyPI）: `quanttide-data`
- 导入名: `quanttide_data`
- 仓库 tag 前缀: `python/`