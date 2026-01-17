# 量潮数据工具包（QuantTide Data Toolkit）

多语言数据工具包单仓，提供统一的数据操作接口和领域模型。

## 概述

本项目是一个 monorepo，包含多个语言的数据工具包 SDK，用于访问和操作 QuantTide 数据云服务。

## SDK 列表

### Python SDK (`python_sdk/`)

Python 数据工具包，提供核心的数据操作功能。

- **包名**: `quanttide-data`
- **主要功能**:
  - 数据集管理（Datasets）
  - 数据记录管理（Records）
  - 数据爬取器（Crawlers）
  - 数据处理器（Processors）
  - 配置管理（Config）

- **技术栈**: Python 3.8+, PDM

### Flutter SDK (`flutter_sdk/`)

Flutter 移动端数据工具包，用于移动应用集成。

- **包名**: `flutter_quanttide_data`
- **主要功能**:
  - 数据集管理
  - 数据记录操作
  - 移动端数据同步

- **技术栈**: Flutter, Dart

### Django SDK (`django_sdk/`)

Django Web 应用数据工具包，提供 Web 后端集成。

- **包名**: `django-quanttide-data`
- **主要功能**:
  - Django 模型定义
  - REST API 序列化器
  - 管理后台集成
  - 测试用例

- **技术栈**: Django, Python 3.8+, Poetry

## 项目结构

```
toolkit/
├── python_sdk/           # Python SDK
│   ├── quanttide_data/
│   ├── docs/
│   ├── examples/
│   ├── tests/
│   ├── pyproject.toml
│   └── pdm.lock
├── flutter_sdk/          # Flutter SDK
│   ├── lib/
│   ├── android/
│   ├── ios/
│   ├── pubspec.yaml
│   └── ...
├── django_sdk/           # Django SDK
│   ├── django_quanttide_data/
│   ├── example/
│   ├── tests/
│   ├── pyproject.toml
│   └── poetry.lock
├── .github/
├── LICENSE
└── README.md
```

## 快速开始

### Python SDK

```bash
cd python_sdk
pdm install
pdm run python -m quanttide_data
```

### Flutter SDK

```bash
cd flutter_sdk
flutter pub get
flutter run
```

### Django SDK

```bash
cd django_sdk/example
poetry install
python manage.py migrate
python manage.py runserver
```

## 开发指南

### SDK 管理

各 SDK 的代码已集成到此 monorepo 中，不再使用 subtree 或 submodule 方式管理。如果需要同步变更到原仓库，请手动复制相关文件。

### 版本管理

各 SDK 保持独立的版本管理，遵循语义化版本规范（SemVer）。

## 许可证

Apache License 2.0

## 联系方式

- **组织**: QuantTide Inc.
- **邮箱**: opensource@quanttide.com
- **GitHub**: https://github.com/quanttide/quanttide-data-toolkit
