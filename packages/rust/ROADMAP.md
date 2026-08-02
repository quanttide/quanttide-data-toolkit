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

### 阶段 1：纯加法（并行模型，零破坏）→ v0.1.1

- [ ] 新增 `specification/mod.rs` 的 `Specification`：envelope（api_version/kind/metadata）+ contract/blueprint/pipeline 三分
- [ ] 新增 `PipelineState` 状态机：`start_at` + `states`（type/from/to/desc/resource/next|end/condition），与旧 `Pipeline`（列表）并存
- [ ] 投影：`Pipeline::from_blueprint(&Blueprint)`（steps 数据流语义 → states 控制流语义）
- [ ] 旧 `Blueprint` 原样不动，36+ tests 全绿，发 v0.1.1（非破坏）

### 阶段 2：切换（旧字段保留 + 读取兼容）→ v0.2.0

- [ ] `Blueprint` 收敛：contract/pipeline/status/timeline/cloud/deliverables 保留但 `#[serde(default)]`（旧 YAML 可读）
- [ ] 内部逻辑迁移到 `Specification` 三分结构（新结构为主）
- [ ] 废弃仅文档标注（不标 `#[deprecated]` 属性，防下游 -D warnings 挂）
- [ ] 旧 blueprint YAML 读入不炸；CLI 领域模型下沉（`Specification` envelope + wrap/validate、`Volume`、`Job`）随 cli v0.3.0
- [ ] 发布 v0.2.0（破坏性标记，兼容读取）

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
