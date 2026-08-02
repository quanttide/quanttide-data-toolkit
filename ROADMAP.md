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

## v0.2.0 — 模型重构（对齐四层框架）

> 背景：实测确认现有模型与四层框架不符（contract 嵌套 blueprint / pipeline 列表非状态机 / 运行态混入设计态），
> 且 CLI `spec wrap` 静默丢规格。详见 `docs/roadmap/quanttide-data-toolkit/rust.md`。

- [ ] `packages/rust/` Blueprint 收敛为 `steps`（剥离 contract/pipeline/status/timeline/cloud/deliverables）
- [ ] 新增 `types/specification.rs`：Specification envelope = **contract + blueprint + pipeline 三分平级**
- [ ] `types/pipeline.rs` 重构为状态机（`start_at` + `states` + `condition` 分支），提供 `Pipeline::from_blueprint` 投影
- [ ] 运行态剥离：`Status`/`Timeline` 移出 Blueprint（后续独立 `Execution`/实例类型）
- [ ] 交付方案剥离：`CloudPlan`/`Deliverable` 独立类型
- [ ] CLI 领域模型下沉：`Specification`（envelope + wrap/validate）、`Volume`（catalog）、`Job`（jobs.json）
- [ ] 跨语言契约测试：同一 Specification YAML 各语言（rust/python/flutter/dart）解析一致
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
