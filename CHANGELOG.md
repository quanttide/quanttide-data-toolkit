# CHANGELOG

## [v0.1.0] - 2026-05-14

初始版本。monorepo 结构，包含以下子包：

### 结构整理

- 目录 `*_sdk/` → `packages/*/`
- 废弃 django 包
- python src layout + uv + hatchling
- 根级 AGENTS.md、CHANGELOG.md、ROADMAP.md
- CI workflows 拆分与 tag 前缀过滤

### packages/python (v0.1.0)

- 初始版本
- 增加 `BaseCrawler` 类
- 增加 `BaseProcessor` 类
- 回退版本号 `0.2.0-alpha.1` → `0.1.0`

### packages/flutter (v0.1.0)

- 初始版本
- 数据集 schema (Dataset, Schema, Record)
- BLoC 状态管理 (DatasetListBloc, SchemaBloc, RecordBloc)
- Repository 模式 (DatasetRepository, SchemaRepository, RecordRepository)
- UI 组件 (DatasetTable, SchemaTable, DatasetView, RecordForm)
- 版本统一 `0.1.0-alpha.3` → `0.1.0`，发布到 pub.dev