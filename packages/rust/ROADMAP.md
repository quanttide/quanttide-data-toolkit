# ROADMAP — Blueprint 数据模型 (Rust)

> 对应包：`quanttide-data-core` | 状态：规划中

## 目标

在 Rust 中实现 Blueprint 的核心数据模型，作为 CLI (`qtcloud-data`) 和平台的共享类型层。

## 类型定义

对应 specification 和 GHTorrent blueprint.cue 中已验证的 `#Blueprint` 类型体系：

### 核心类型

| 类型 | 来源 | 说明 |
|------|------|------|
| `Blueprint` | `#Blueprint` | 顶层实体，含 metadata / requirements / pipeline / cloud / deliverables / status |
| `Step` | `#Step` | 管道步骤：name / from / to / desc / depends |
| `Pipeline` | `#Pipeline` | 有序步骤列表 |
| `Contract` | `#Contract` | 输入输出结构约束：schema / format / rules |
| `PanelSpec` | `#PanelSpec` | 输出规格：format / primary_key / columns / column_count |

### 辅助类型

| 类型 | 说明 |
|------|------|
| `ColumnDef` | 变量名 + 描述 |
| `SourceTable` | 数据源表：table / format / content |
| `UserFilter` | 用户过滤条件 |
| `CloudServer` | 云服务器规格 |
| `CloudPlan` | 上云方案 |
| `Deliverable` | 交付物描述 |
| `Status` | 状态枚举：draft / submitted / confirmed / rejected |
| `TimelineEntry` | 时间线条目 |

## 序列化支持

- CUE → Rust struct（解析 `.cue` 文件）
- Rust struct → CUE（`formalize` 命令输出）
- JSON / YAML 中间格式（与其他包互操作）

## 与其他包的关系

```
packages/rust/    ← Blueprint 数据模型（本包）
    ↓ 被引用
apps/qtcloud-data/src/cli/  ← CLI formalize 命令
```

## 实现顺序

1. 定义核心 struct（`Blueprint`, `Pipeline`, `Step`, `Contract`）with serde
2. 实现 `Blueprint::from_cue(path)` — 解析 .cue 文件
3. 实现 `Blueprint::to_cue()` — 序列化为 .cue 格式
4. 单元测试（用 profile 中的真实 blueprint 文件作为 fixture）
5. 集成到 CLI 的 `formalize` 命令

## 参考

- `docs/specification/blueprint.md` — Blueprint 规范定义
- `data/profile/ghtorrent/blueprint.cue` — 实际 Blueprint 实例（已脱敏）
- `apps/qtcloud-data/src/cli/ROADMAP.md` — CLI 侧的实现计划
