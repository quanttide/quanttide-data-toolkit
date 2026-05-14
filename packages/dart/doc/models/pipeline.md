# 数据管道`Pipeline`

数据管道，一组有序 Task 的容器。Pipeline 不自持状态，不提供 derivedStatus，需要时由调用方自行聚合 Task 状态。

标识
- 标识`id`（`String`）：唯一标识。
- 标识名`name`（`String`）：URL 路径风格，程序化寻址，如 `order-data-pipeline`。
- 标题`title`（`String`）：中文标题，人读展示。
- 描述`description`（`String`）：详细说明，默认 `''`。

内容
- 任务列表`tasks`（`List<Task>`）：所属任务列表。Pipeline 对 Task 是组合关系，Task 不独立于 Pipeline 存在。

审计
- 创建时间`createdAt`（`DateTime?`）：创建时间。
- 更新时间`updatedAt`（`DateTime?`）：最后更新时间。

---

## 数据任务`Task`

管道中的最小工作项。Task 作为 Pipeline 的值对象存在，不独立于 Pipeline 被查询或引用。

标识
- 标识`id`（`String`）：唯一标识。
- 标识名`name`（`String`）：URL 路径风格，如 `import/sales-orders`。
- 标题`title`（`String`）：中文标题，人读展示。
- 描述`description`（`String`）：详细说明，默认 `''`。

状态
- 状态`status`（`TaskStatus`）：任务状态，默认 `pending`。

审计
- 创建时间`createdAt`（`DateTime?`）：创建时间。
- 更新时间`updatedAt`（`DateTime?`）：最后更新时间。

---

### 数据任务状态`TaskStatus`

枚举值。六个值在同一维度上描述任务执行状态的完整生命周期。

采用通用项目管理风格，命名不绑定特定执行者类型——用 `inProgress` 而非 `running` 以覆盖机器、AI、人三种场景，用 `failed`/`rejected` 区分系统执行错误与业务结果不达标。

属性包括：

- 名称`name`（`String`）：枚举标识，由枚举值名提供。
- 标签`label`（`String`）：人类可读的状态名，如 `就绪`、`进行中`、`达标`、`异常`、`驳回`、`取消`。
- 颜色`color`（`int`）：灰度设计上 `pending`（浅灰，未激活）与 `cancelled`（深灰，已结束）共用灰色系、明度不同；三种负面状态用不同色相：`failed` 红（错误）、`rejected` 橙（否决）、`cancelled` 灰（取消）。widget 层按需转为 `Color(color)` 并自行计算透明度。

标准属性如下：

| `name` | `label` | `color` |
|--------|---------|---------|
| `pending` | 就绪 | `0xFF9CA3AF` |
| `inProgress` | 进行中 | `0xFF2563EB` |
| `completed` | 达标 | `0xFF16A34A` |
| `failed` | 异常 | `0xFFDC2626` |
| `rejected` | 驳回 | `0xFFD97706` |
| `cancelled` | 取消 | `0xFF6B7280` |

#### 设计说明

**为什么 TaskStatus 和 DatasetStatus 分开设计？**
TaskStatus 描述"任务执行到什么阶段"，六个值在同一维度。DatasetStatus 描述"数据集是否可用"，维度不同。二者各自为所属聚合服务，不共享枚举。混用会导致一个枚举承载多个语义维度（如 DatasetStatus 的 `pending/ready/outdated/failed` 混合了就绪度和新鲜度），失去类型系统的约束力。

**为什么 Task 不独立存在？**
Task 作为 Pipeline 的组成部分，没有脱离 Pipeline 的业务含义。如果将来需要独立查询和引用 Task，应将其提升为独立的聚合根，并改用 `taskId` 引用而非对象嵌套。
