# CHANGELOG

## [Unreleased]

### Changed
- 规划 v0.2.0 模型重构（对齐四层框架）：Blueprint 收敛为 steps、Specification 三分平级（contract/blueprint/pipeline）、Pipeline 状态机（start_at/states）、运行态剥离。详见 ROADMAP.md。

## [0.1.0] - 2026-07-25

### Changed
- 包名 `quanttide-data-core` → `quanttide-data`（发布到 crates.io，CLI `qtcloud-data` 依赖该名）。
- 手写 CUE lexer + 递归下降 parser（`from_cue`/`to_cue`）移除，序列化迁移到 `serde_yaml`（CUE ↔ JSON/YAML 中间格式）。
- `Contract`/`ContractPair` 实现 `Default`，支持可选 YAML 反序列化（缺失字段安全降级）。

## [0.1.0-alpha.1] - 2026-07-17

### Added
- 7 个核心类型模块：Blueprint / Pipeline / Step / Contract / Datasource / Cloud / Status
- 手写 CUE lexer + 递归下降 parser（`from_cue`）
- CUE 序列化器（`to_cue`）
- 语义校验器（depends 存在性、必填字段、schema 非空）
- 99.34% 测试覆盖率（129 tests）
