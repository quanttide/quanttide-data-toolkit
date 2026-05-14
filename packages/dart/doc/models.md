# 领域模型

## 管道`Pipeline`

标识
- 标识`id`(`String`): 唯一标识。
- 标识名`name`(`String`): URL路径风格，程序化寻址，如 `order-data-pipeline`。
- 标题`title`(`String`): 中文标题，人读展示。
- 描述`description`(`String`): 详细说明，默认 `''`。

内容
- 任务列表`tasks`(`List<Task>`): 所属任务列表。


## 任务`Task`

标识
- 标识`id`(`String`): 唯一标识。
- 标识名`name`(`String`): URL路径风格，如 `import/sales-orders`。
- 标题`title`(`String`): 中文标题，人读展示。
- 描述`description`(`String`): 详细说明，默认 `''`。

状态
- 状态`status`(`TaskStatus`): 任务状态，默认 `pending`。

### 任务状态`TaskStatus`

枚举值。属性包括：

- 名称`name`（`String`）：采用通用项目管理风格，不绑定特定执行者类型——用 `inProgress` 而非 `running` 以覆盖机器、AI、人三种场景，用 `failed`/`rejected` 区分系统执行错误与业务结果不达标。
- 标签`label`（`String`）：人类可读的状态名，如 `就绪`、`进行中`、`达标`、`异常`、`驳回`、`取消`。
- 颜色`color` （`int`）：。灰度设计上 `pending`（浅灰，未激活）与 `cancelled`（深灰，已结束）共用灰色系、明度不同；三种负面状态用不同色相：`failed` 红（错误）、`rejected` 橙（否决）、`cancelled` 灰（取消）。widget 层按需转为 `Color(color)` 并自行计算透明度。

标准属性如下：

| `name` | `label` | `color` |
|--------|---------|---------|
| `pending` | 就绪 | `0xFF9CA3AF` |
| `inProgress` | 进行中 | `0xFF2563EB` |
| `completed` | 达标 | `0xFF16A34A` |
| `failed` | 异常 | `0xFFDC2626` |
| `rejected` | 驳回 | `0xFFD97706` |
| `cancelled` | 取消 | `0xFF6B7280` |
