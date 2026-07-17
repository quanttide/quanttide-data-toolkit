# TODO — Blueprint 数据模型 (Rust)

> 包名：`quanttide-data-core` | 测试覆盖率 ≥95%  
> 这是一个纯数据模型 crate，无 I/O 依赖（除 serde 序列化）

---

## 交付边界（必读）

### 允许创建/修改的文件

```
Cargo.toml               ← 新增
src/lib.rs               ← 新增，pub mod 导出所有子模块
src/types/mod.rs         ← 新增
src/types/blueprint.rs   ← 新增
src/types/pipeline.rs    ← 新增
src/types/contract.rs    ← 新增
src/types/datasource.rs  ← 新增
src/types/cloud.rs       ← 新增
src/types/status.rs      ← 新增
src/types/deliverable.rs ← 新增
src/serde/mod.rs         ← 新增
src/serde/cue/mod.rs     ← 新增
src/serde/cue/from_cue.rs← 新增
src/serde/cue/to_cue.rs  ← 新增
src/validate.rs          ← 新增
src/error.rs             ← 新增（CueParseError, ValidationError）
README.md                ← 新增
CHANGELOG.md             ← 新增
```

### 禁止操作

- **禁止创建** src/ 下的其他文件（不在上述列表的）
- **禁止修改** packages/flutter/、packages/dart/、packages/python/ 下的任何文件
- **禁止修改** 仓库根级文件（AGENTS.md、ROADMAP.md 等，交付时统一更新）
- **禁止创建** examples/、benches/ 目录（本期不需要）

### 测试 fixture 路径

测试使用只读 fixture，**禁止修改**这些文件：
- `../../data/profile/ghtorrent/blueprint.cue`
- `../../data/profile/sec-credit-agreement/blueprint.cue`

### 交付验证

每完成一个模块，运行 `cargo test && cargo clippy && cargo fmt --check && cargo doc` 确认通过。

---

## 1. 项目脚手架

- [ ] `Cargo.toml` — 包名、版本、依赖
  - [ ] `serde` + `serde_json` + `serde_yaml`（序列化）
  - [ ] `serde_derive`（宏）
  - [ ] 仅 dev 依赖：`serde_test`、`insta`（快照测试）
- [ ] `src/lib.rs` — crate 入口，`pub mod` 导出各模块
- [ ] `README.md` — 包说明、类型一览表、使用示例
- [ ] `CHANGELOG.md` — 初始版本记录

---

## 2. 核心类型定义（`src/types/`）

每个类型：struct + serde derive + `new()` + 单元测试 + 文档测试

### 2.1 `blueprint.rs` — 顶层实体

- [ ] `struct Blueprint`
  - [ ] `metadata: Metadata`
  - [ ] `original_requirements: OriginalRequirements`
  - [ ] `pipeline: Pipeline`
  - [ ] `cloud: CloudPlan`
  - [ ] `deliverables: Deliverables`
  - [ ] `status: Status`
  - [ ] `timeline: Option<Vec<TimelineEntry>>`
  - [ ] `created_at: Timestamp`
  - [ ] `updated_at: Timestamp`
- [ ] `struct Metadata` — `responsible: String`, `reviewer: Option<String>`, `repo: String`
- [ ] `struct OriginalRequirements` — `background: String`, `sources: DataSources`, `output: PanelSpec`
- [ ] `struct Deliverables` — `data: Deliverable`, `doc: Deliverable`
- [ ] 单元测试：从 JSON fixture 反序列化，字段完整性校验
- [ ] 文档测试：最小 Blueprint 构造示例

### 2.2 `pipeline.rs` — 管道与步骤

- [ ] `struct Pipeline` — `name: String`, `steps: Vec<Step>`
- [ ] `struct Step` — `name: String`, `from: String`, `to: String`, `desc: String`, `depends: Option<Vec<String>>`
- [ ] 单元测试：步骤列表反序列化、depends 字段可选

### 2.3 `contract.rs` — 输入输出契约

- [ ] `struct Contract` — `schema: String`, `format: Option<String>`, `rules: Option<Vec<String>>`
- [ ] `struct PanelSpec` — `format: String`, `primary_key: Vec<String>`, `columns: Vec<ColumnDef>`, `strict_columns: bool`, `column_count: u32`
- [ ] `struct ColumnDef` — `variable: String`, `description: String`
- [ ] 单元测试：PanelSpec 列数校验（`column_count` 与 `columns.len()` 一致）

### 2.4 `datasource.rs` — 数据源

- [ ] `struct DataSources` — `mysql_dump: SourceTable`, `id_list: UserFilter`, `tables: HashMap<String, SourceTable>`
- [ ] `struct SourceTable` — `table: String`, `format: String`, `content: String`
- [ ] `struct UserFilter` — `file: String`, `fields: Vec<String>`, `count: u32`
- [ ] 单元测试：HashMap 反序列化

### 2.5 `cloud.rs` — 上云方案

- [ ] `struct CloudPlan` — `server: CloudServer`, `advantages: Vec<String>`, `upload: ChunkedUpload`
- [ ] `struct CloudServer` — `instance_type: String`, `vcpu: u32`, `memory_gb: u32`, `data_disk_gb: u32`, `region: String`, `provider: String`
- [ ] `struct ChunkedUpload` — `chunk_size_gb: u32`, `method: String`
- [ ] 单元测试：CloudServer 字段完整性

### 2.6 `status.rs` — 状态与时间线

- [ ] `enum Status` — `Draft`, `Submitted`, `Confirmed`, `Rejected`
  - [ ] `impl Serialize` / `impl Deserialize`（带 `#[serde(rename_all = "lowercase")]`）
- [ ] `struct TimelineEntry` — `action: TimelineAction`, `actor: String`, `timestamp: String`, `note: Option<String>`
- [ ] `enum TimelineAction` — `Submit`, `Confirm`, `Reject`, `Resubmit`
- [ ] 单元测试：Status 枚举序列化/反序列化、TimelineAction 往返测试

### 2.7 `deliverable.rs` — 交付物

- [ ] `struct Deliverable` — `description: String`, `supplement: Option<String>`

---

## 3. 序列化模块（`src/serde/`）

### 3.1 CUE 解析

- [ ] `src/serde/cue/from_cue.rs`
  - [ ] `fn parse_cue_file(path: &Path) -> Result<Blueprint>` — 解析 .cue 文件为 Blueprint 实例
  - [ ] 策略：调用 `cue export --out json` 得到 JSON，再 serde 反序列化
  - [ ] 错误处理：CUE 语法错误 → `CueParseError`
- [ ] 单元测试：
  - [ ] fixture: `data/profile/ghtorrent/blueprint.cue`（已脱敏）
  - [ ] fixture: `data/profile/sec-credit-agreement/blueprint.cue`
  - [ ] 测试无效 CUE 文件报错

### 3.2 CUE 生成

- [ ] `src/serde/cue/to_cue.rs`
  - [ ] `fn to_cue_string(blueprint: &Blueprint) -> Result<String>` — 将 Blueprint 序列化为 CUE 格式字符串
  - [ ] 策略：serde 序列化为 JSON → 转换为 CUE 文本格式
- [ ] 单元测试：
  - [ ] 构造 Blueprint → to_cue → from_cue 往返一致
  - [ ] 与已知 .cue fixture 对比（快照测试）

---

## 4. 验证模块（`src/validate.rs`）

- [ ] `fn validate(blueprint: &Blueprint) -> Result<(), Vec<ValidationError>>` — 语义校验
  - [ ] 步骤依赖存在性：`depends` 中引用的步骤名必须存在于 `steps` 中
  - [ ] 列数一致性：`column_count` == `columns.len()`
  - [ ] 必填字段非空：`name`、`pipeline.name` 等
  - [ ] 状态机约束：状态转换合法性
- [ ] 单元测试：
  - [ ] 正常 Blueprint 通过验证
  - [ ] depends 引用了不存在的步骤 → 报错
  - [ ] column_count 与 columns 不一致 → 报错
  - [ ] 缺失必填字段 → 报错

---

## 5. 文档

- [ ] `README.md` — crate 级文档
  - [ ] 类型一览表
  - [ ] 最小使用示例（构造 Blueprint + 序列化）
  - [ ] fixture 路径说明
- [ ] 每个 struct/enum 的 doc comment（`///`）
- [ ] `cargo doc --open` 通过且无 broken link

---

## 6. Build & CI

- [ ] `cargo build` 通过
- [ ] `cargo test` 全量通过
- [ ] `cargo clippy` 无 warning
- [ ] `cargo fmt` 检查通过
- [ ] `cargo doc` 无 warning
- [ ] CI workflow：`.github/workflows/rust-build.yml`（lint + test + coverage）
- [ ] 测试覆盖率 ≥95%（`cargo tarpaulin`）

---

## 覆盖率目标：≥95%

理由：纯数据模型 crate，无外部 I/O、无异步、无网络调用。所有逻辑都是 serde + 验证规则，天然可全覆盖。95% 的门槛要求"每一个 struct 构造、每种序列化路径、每条验证规则"都有测试。
