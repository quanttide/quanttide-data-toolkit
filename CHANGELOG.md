# CHANGELOG

## [v0.1.1] - 2026-08-02

### Added

- 契约测试体系：主仓 `pyproject.toml` + pytest（`tests/` 契约 fixture，先 Rust 后跨语言扩展）
- `tests/contract/specification.yaml` 契约 fixture（metadata + spec{contract, blueprint}，pipeline 由 blueprint 投影）
- CI：`verify-rust`（build/test/clippy -D warnings/fmt）+ `publish-rust`（tag `rust/v*` → crates.io）+ `check-contract`（fixture 语法）

### Changed

- ROADMAP：v0.2.0 渐进式 4 阶段模型重构（对齐四层框架——contract/blueprint 平级、pipeline 状态机投影、运行态/交付层剥离）
- Rust 包 `quanttide-data`：v0.1.0 → v0.1.1（Specification envelope、Blueprint 收敛 steps、Pipeline 状态机、契约测试）
- 错误分层：统一接口 `BlueprintError`（error.rs）+ 域错误就近（`ValidationError` → validate.rs）
- 域目录划分：省略 `types/` 层，`specification/`/`implementation/`/`delivery/`/`execution/`/`requirement/` 对齐 CLI `src/` 结构

### Fixed

- 删除 serde 占位模块与 CueParse 变体（from_cue 已迁移 serde_yaml 的残留）
- 契约测试覆盖补全（可选字段/未知字段容忍、specification 三分、投影一致性守护）

### Rust 包发布（随本版）

- `quanttide-data` v0.1.0（crates.io）→ v0.1.1（阶段 1：Specification + Pipeline 状态机 + from_blueprint 投影）

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