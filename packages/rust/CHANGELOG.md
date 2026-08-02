# CHANGELOG

## [0.2.0] - 2026-08-02

### Changed（破坏性）

- **Specification envelope 重构**：去除 apiVersion/kind 与 schema_version 头，最终为 `metadata`（name/version/description）+ `spec`（内容）；`SpecificationContent` = contract + blueprint（pipeline 由 blueprint 投影，不存文档）。
- **Blueprint 收敛**：剥离 contract/pipeline/status/timeline/cloud/deliverables，仅留 `steps`；名称/描述移入 Specification.metadata（单一事实源）。
- **Pipeline 移入实现层**：`implementation::pipeline`（状态机 start_at/states），`Pipeline::from_blueprint` 投影；`Step` 归规格层 `specification::blueprint`。
- **ContractPair** 移入 contract 域；旧 `BlueprintSteps` 删除。
- **错误分层**：`ValidationError` 移入 validate.rs（域内聚），`BlueprintError` 统一接口保留 error.rs。
- **validate_specification**：Specification 级校验（metadata.name + contract schema + blueprint steps/依赖）。

### Compatibility

- 旧 blueprint YAML（含 contract/pipeline/status 字段）读取：serde 忽略未知字段，`steps` 若存在仍可解析。

## [0.1.1] - 2026-08-02

### Added
- `Specification` envelope（K8s 风格：api_version/kind/metadata/spec），`spec` 为 `SpecificationContent`（contract + blueprint + pipeline **三分平级**）。
- `Pipeline` 重构为**状态机**（`start_at` + `states` + `condition` 分支，task/choice/parallel），旧列表模型更名 `BlueprintSteps`（v0.2.0 移除）。
- `Pipeline::from_blueprint`：蓝图工作流步骤 → 可执行状态机投影（顺序 next 串联，depends 补 condition）。
- `ContractPair` 从 blueprint 模块移入 contract 模块（契约域归属）。

### Changed
- `Blueprint.pipeline` 字段类型改为 `BlueprintSteps`（字段名与 `steps` 访问不变，兼容）。
- 旧 `Pipeline`（列表）更名 `BlueprintSteps`，`Step` 保留原名。

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
