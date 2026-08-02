# ROADMAP — quanttide-data（Rust 模型包）

> 对应包：`quanttide-data`（v0.1.0 已发布 crates.io）| 状态：已发布，v0.2.0 重构规划中
> 对应代码：`packages/rust/` | 详细设计：`docs/roadmap/quanttide-data-toolkit/rust.md`

## 目标

在 Rust 中实现量潮数据领域模型，作为 CLI（`qtcloud-data`）与平台的**单一事实源共享类型层**。

## 已发布（v0.1.0）

- [x] `Blueprint` 顶层实体（name/description/contract/pipeline/cloud/deliverables/status/timeline）
- [x] `Pipeline`/`Step`、`Contract`/`PanelSpec`/`ColumnDef`、`SourceTable`/`UserFilter`、`CloudServer`/`CloudPlan`、`Deliverable`、`Status`/`TimelineEntry`
- [x] CUE ↔ Rust struct ↔ JSON/YAML 序列化
- [x] `validate` 校验 + 单元测试

## v0.2.0 — 模型重构（对齐四层框架）

> 实测确认：模型与四层框架不符（Blueprint 聚合跨层/运行态字段、Pipeline 列表非状态机），
> 导致 CLI `spec wrap` 静默丢 `start_at/states`（单一事实源失效）。重构方向：

### 目标模型

```rust
// types/specification.rs（新）
pub struct Specification {
    pub api_version: String,
    pub kind: String,
    pub metadata: SpecificationMetadata,
    pub spec: SpecificationBody,   // contract + blueprint + pipeline 三分平级
}

// types/blueprint.rs（重构）
pub struct Blueprint {
    pub name: String,
    pub description: Option<String>,
    pub steps: Vec<Step>,          // 工作流步骤 = 蓝图自己的流程定义
}

// types/pipeline.rs（重构为状态机）
pub struct Pipeline {
    pub start_at: String,
    pub states: BTreeMap<String, PipelineState>,  // task/choice/parallel + condition
}
```

### 任务

- [ ] 新增 `types/specification.rs`：Specification envelope（api_version/kind/metadata + contract/blueprint/pipeline）
- [ ] `Blueprint` 收敛为 `steps`（剥离 contract → spec 平级、pipeline → spec 平级、status/timeline → 运行层、cloud/deliverables → 交付层）
- [ ] `Pipeline` 重构为状态机：`start_at` + `states`（type/from/to/desc/resource/next|end/condition）
- [ ] 投影：`Pipeline::from_blueprint(&Blueprint)`（steps 数据流语义 → states 控制流语义）
- [ ] 运行态剥离：`Status`/`Timeline` 移出 Blueprint（后续独立 `Execution` 类型）
- [ ] CLI 领域模型下沉：`Specification`（envelope + wrap/validate）、`Volume`（catalog）、`Job`（jobs.json）
- [ ] 兼容读取：旧 blueprint YAML（含 pipeline/status 字段）serde 兼容
- [ ] 契约测试：跨语言（rust/python/flutter/dart）同一 Specification YAML 解析一致
- [ ] 发布 v0.2.0（破坏性，CLI 依赖升级适配随 cli v0.3.0）

## 序列化支持（保持）

- CUE → Rust struct（解析 `.cue` 文件）
- Rust struct → CUE（`formalize` 命令输出）
- JSON / YAML 中间格式（与其他包互操作）

## 与其他包的关系

```
packages/rust/    ← 领域模型（本包，单一事实源）
    ↓ 被引用
apps/qtcloud-data/src/cli/  ← CLI（spec/design/implement/process 消费模型）
    ↓ 契约测试
packages/{python, flutter, dart}/  ← 各语言 SDK 同步模型
```

## 参考

- `docs/roadmap/quanttide-data-toolkit/rust.md` — 不一致分析与重构方案（详细）
- `docs/roadmap/qtcloud-data/spec.md` — CLI 侧 spec 域重构（依赖本包先行）
- `data/profile/ghtorrent/blueprint.cue` — 实际 Blueprint 实例（已脱敏）
