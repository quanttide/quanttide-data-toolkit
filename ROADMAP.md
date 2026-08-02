# ROADMAP

> 更新日期：2026-08-02 | 现状：多语言 monorepo（python/dart/flutter/rust），`packages/rust/` 已发布 v0.1.0

## 已完成的结构整理

- [x] 目录结构对齐：`*_sdk/` → `packages/*/`
- [x] 根级配置：AGENTS.md、CHANGELOG.md、ROADMAP.md、README.md
- [x] 废弃 django 包
- [x] python src layout + uv + hatchling
- [x] python 版本回退 `0.2.0-alpha.1` → `0.1.0`
- [x] flutter 版本统一 `0.1.0-alpha.3` → `0.1.0`，发布到 pub.dev
- [x] CI workflows 拆分与 tag 前缀过滤
- [x] 子包 AGENTS.md 规范
- [x] `packages/rust/` 创建：Blueprint 模型 + CUE/JSON/YAML 序列化 + validate + 单元测试，发布 `quanttide-data` v0.1.0（crates.io），CLI 已依赖

## v0.2.0 — 模型重构（对齐四层框架，渐进式 4 阶段）

> 背景：实测确认现有模型与四层框架不符（contract 嵌套 blueprint / pipeline 列表非状态机 / 运行态混入设计态），
> 且 CLI `spec wrap` 静默丢规格。详见 `docs/roadmap/quanttide-data-toolkit/rust.md`。
> 原则：**加不加删、读取兼容、单一事实源先行、每步独立可发布**。

### 阶段 1：纯加法（并行模型，零破坏）→ rust 包 v0.1.1

- [ ] 新增 `Specification` 类型：envelope + contract + blueprint + pipeline 三分平级（`specification/mod.rs`）
- [ ] 新增 `PipelineState` 状态机（`start_at`/`states`/`condition`），与旧 Pipeline（列表）并存
- [ ] `Pipeline::from_blueprint` 投影（旧 steps → 新 states）
- [ ] 旧 `Blueprint` 原样不动（CLI 零影响），测试全绿发 v0.1.1

### 阶段 2：toolkit 切换（旧字段保留 + 读取兼容）→ rust 包 v0.2.0

- [ ] `Blueprint` 收敛：contract/pipeline/status 等字段保留但 `#[serde(default)]`（旧 YAML 可读）
- [ ] 内部逻辑迁移到 Specification 三分结构（新结构为主）
- [ ] 废弃仅文档标注（**不标 `#[deprecated]` 属性**，避免下游 -D warnings 编译挂）
- [ ] 旧 blueprint YAML（含 pipeline/status）读入不炸，发 v0.2.0

### 阶段 3：CLI 跟随（每命令一提交）→ cli v0.3.0

- [ ] `spec/mod.rs`：SpecificationBody 改三分（消费新模型）
- [ ] `design`：产出三块（contract + blueprint.steps + pipeline.states 投影）
- [ ] `spec wrap`：组合三块（merge 补丁退役）
- [ ] `spec validate`：校验三块 + 投影一致性（steps ↔ states）
- [ ] `implement`：从 blueprint.steps 生成；`process`：消费 pipeline.states（状态机 + 分支）

### 阶段 4：清理 + 跨语言

- [ ] 删除旧字段（Blueprint 的 pipeline/status 等，主版本语义）
- [ ] python/flutter/dart 同步 Specification 三分模型
- [ ] 跨语言契约测试：同一 Specification YAML 各语言解析一致
- [ ] 重建 xmucpp 示例（无 merge 补丁）
- [ ] 文档同步：README SDK 表补 dart/rust；STATUS 补 rust 行

## 核心功能（保留，不阻塞模型重构）

- [ ] 数据集 CRUD API (Python SDK)
- [ ] 数据记录 CRUD API (Python SDK)
- [ ] Schema 验证器

## Flutter 增强

- [ ] 枚举类型（DataType, ValidationRule）
- [ ] 表单生成器
- [ ] 列表视图优化

## 跨平台

- [ ] FastAPI 服务端
- [ ] 跨语言契约测试（见 v0.2.0）
