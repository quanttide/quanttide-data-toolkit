# TODO — quanttide-data（Rust 模型包）

> 对应包：`quanttide-data` | 版本路线见 [ROADMAP.md](ROADMAP.md)（渐进式 4 阶段）
> 原则：**加不加删、读取兼容、单一事实源先行、每步独立可发布**。

---

## 阶段 1：纯加法（并行模型，零破坏）→ v0.1.1

> 目标：新增 Specification 三分模型 + 状态机 Pipeline，旧 Blueprint 原样不动，CLI 零影响。

### 1.1 `Specification` 类型（`src/specification/mod.rs`）

- [ ] `Specification`：api_version / kind / metadata / spec（envelope）
- [ ] `SpecificationBody`：**contract + blueprint + pipeline 三分平级**
- [ ] `SpecificationMetadata`：name / generated_by / source_path
- [ ] 从三分构造（`Specification::new(contract, blueprint, pipeline)`）
- [ ] 单元测试：envelope 序列化/反序列化、三分组合往返

### 1.2 `PipelineState` 状态机（`src/specification/pipeline.rs`，与旧 Pipeline 并存）

- [ ] `Pipeline` 重构为新结构：`start_at` + `states: BTreeMap<String, PipelineState>`
- [ ] `PipelineState`：state_type（task/choice/parallel）/ from / to / desc / resource / next|end / condition
- [ ] `StateType` 枚举（task / choice / parallel，serde rename）
- [ ] 单元测试：状态机 YAML 序列化、分支（choice + condition）表达

### 1.3 投影：`Pipeline::from_blueprint`

- [ ] `from_blueprint(&Blueprint) -> Pipeline`：旧 steps → 新 states（顺序 next 串联，depends 分支补 condition）
- [ ] 单元测试：3 步顺序投影、depends 分支投影、空 steps

### 1.4 验证与发布

- [ ] 36+ tests 全绿（新增约 10 个）、clippy `-D warnings`、fmt
- [ ] 发 v0.1.1（非破坏，旧 API 不变）

---

## 阶段 2：切换（旧字段保留 + 读取兼容）→ v0.2.0

> 目标：Blueprint 收敛为 steps，旧字段 `#[serde(default)]` 兼容读取，内部迁移三分。

### 2.1 Blueprint 收敛

- [ ] `Blueprint` 保留 contract/pipeline/status/timeline/cloud/deliverables 但 `#[serde(default)]`（旧 YAML 可读）
- [ ] `Blueprint.steps`（若无则加）或直接消费新 `Pipeline`
- [ ] 旧字段**仅文档标注废弃**（不标 `#[deprecated]` 属性，防下游 -D warnings 挂）

### 2.2 内部迁移

- [ ] `validate.rs`：校验对象改为 `Specification`（contract/blueprint/pipeline 三分 + 投影一致性 steps↔states）
- [ ] lib.rs 导出：`Specification` 为主入口，`Blueprint` 保留兼容
- [ ] 旧 blueprint YAML（含 pipeline/status 字段）读入不炸（测试覆盖）

### 2.3 发布

- [ ] 发 v0.2.0（破坏性标记，兼容读取）
- [ ] CLI 领域模型下沉随 cli v0.3.0（Specification envelope + wrap/validate、Volume、Job）

---

## 已完成的维护（v0.1.x 期间）

- [x] 域目录划分对齐 CLI（specification/requirement/delivery/execution，无 types 层）
- [x] 错误分层：`BlueprintError` 统一接口在 error.rs，`ValidationError` 域内聚在 validate.rs
- [x] 删除 serde 占位模块与 CueParse 变体（from_cue 已迁移 serde_yaml）
- [x] CI：verify-rust（build/test/clippy/fmt）+ publish-rust（tag rust/v* → crates.io）
- [x] tag 补齐：rust/v0.1.0 + GitHub Release
