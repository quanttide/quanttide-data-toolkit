# 量潮数据工具包（QuantTide Data Toolkit）

多语言数据工具包单仓，提供统一的数据操作接口和领域模型。

## 概述

本项目是一个 monorepo，包含多个语言的数据工具包 SDK，用于访问和操作 QuantTide 数据云服务。

## SDK 列表

| 子包 | 包名 | 语言 | 定位 |
|------|------|------|------|
| `packages/python/` | `quanttide-data` | Python | 数据操作 SDK（Pydantic 模型） |
| `packages/flutter/` | `flutter_quanttide_data` | Dart/Flutter | 数据 UI 组件与 BLoC 状态管理 |

## 项目结构

```
quanttide-data-toolkit/
├── AGENTS.md
├── CHANGELOG.md
├── ROADMAP.md
├── README.md
├── packages/
│   ├── python/           # Python SDK
│   │   ├── quanttide_data/
│   │   ├── tests/
│   │   ├── examples/
│   │   ├── docs/
│   │   ├── pyproject.toml
│   │   └── pdm.lock
│   └── flutter/          # Flutter SDK
│       ├── lib/
│       ├── example/
│       ├── test/
│       ├── pubspec.yaml
│       └── ...
├── .github/
│   └── workflows/
└── .agents/
    └── skills/
```

## 快速开始

### Python SDK

```bash
cd packages/python
pdm install
pdm run python -m quanttide_data
```

### Flutter SDK

```bash
cd packages/flutter
flutter pub get
flutter run
```

## 开发指南

### SDK 管理

各 SDK 的代码已集成到此 monorepo 中，不再使用 subtree 或 submodule 方式管理。

### 版本管理

各 SDK 保持独立的版本管理，遵循语义化版本规范（SemVer）。

参见各子包 `AGENTS.md` 了解具体的提交消息规范和发布流程。

## 许可证

Apache License 2.0

## 联系方式

- **组织**: QuantTide Inc.
- **邮箱**: opensource@quanttide.com
- **GitHub**: https://github.com/quanttide/quanttide-data-toolkit