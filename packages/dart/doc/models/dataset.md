# 数据集`Dataset`

数据集是经采集或处理后可供使用的数据单元，带有结构定义（Schema）。Dataset 作为独立聚合根存在，不依附于其他实体。

标识
- 标识`id`（`String`）：唯一标识。
- 标识名`name`（`String`）：URL 路径风格，程序化寻址，如 `sales-orders-202605`。
- 标题`title`（`String`）：中文标题，人读展示。
- 描述`description`（`String`）：详细说明，默认 `''`。

结构
- 模式标识`schemaId`（`String`）：关联的 Schema 标识。通过 ID 而非名称引用，避免 Schema 改名时引用断裂。

状态
- 状态`status`（`DatasetStatus`）：数据集就绪状态，默认 `pending`。

审计
- 创建时间`createdAt`（`DateTime?`）：创建时间。
- 更新时间`updatedAt`（`DateTime?`）：最后更新时间。
- 刷新时间`refreshedAt`（`DateTime?`）：最后一次成功刷新的时间。调用方可据此判断数据集是否过时，而非仅依赖 `outdated` 状态标记。

---

## 数据集状态`DatasetStatus`

枚举值。四个值在同一维度上描述数据集就绪生命周期的完整阶段。

### 维度说明

DatasetStatus 的单一维度是**"数据集是否可用及可用程度"**：

```
pending ──→ ready ──→ outdated
  │                     │
  └──→ failed ←─────────┘
```

- `pending`：数据正在准备中，尚不可用。
- `ready`：数据已就绪，可用。
- `outdated`：数据已过时，需要刷新。`outdated` 不表示数据被销毁——若业务允许降级读取，可读取旧数据并附带"数据已过时"警告，系统不应将其作为新鲜数据使用。
- `failed`：数据准备失败。

`failed` 可从前置阶段（`pending`）或稳态阶段（`ready`/`outdated`）进入，是任意阶段都可能发生的异常终止。

### 与 TaskStatus 的区别

| 维度 | TaskStatus | DatasetStatus |
|------|-----------|---------------|
| 描述对象 | 任务执行到什么阶段 | 数据集是否可用 |
| 值数量 | 6 | 4 |
| 正面状态 | pending → inProgress → completed | pending → ready |
| 负面状态 | failed / rejected / cancelled | failed / outdated |
| 执行者 | 机器 / AI / 人 | 系统 |

二者服务于不同聚合根，枚举值不可混用。DatasetStatus 没有 `inProgress`（数据集准备不应暴露内部步骤）、没有 `rejected`/`cancelled`（数据集不存在"被驳回"或"被取消"）。

属性包括：

- 名称`name`（`String`）：枚举标识，由枚举值名提供。
- 标签`label`（`String`）：人类可读的状态名，如 `等待中`、`已就绪`。
- 颜色`color`（`int`）：灰度上 `pending`（浅灰，未激活）与 `outdated`（中灰，需关注）共用灰色系、明度不同；正面 `ready` 用绿色系；负面 `failed` 用红色系。

标准属性如下：

| `name` | `label` | `color` |
|--------|---------|---------|
| `pending` | 等待中 | `0xFF9CA3AF` |
| `ready` | 已就绪 | `0xFF16A34A` |
| `outdated` | 已过时 | `0xFF6B7280` |
| `failed` | 异常 | `0xFFDC2626` |
