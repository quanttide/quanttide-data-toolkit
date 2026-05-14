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

枚举值

| 枚举值 | `label` | `color` | 语义 |
|--------|---------|---------|------|
| `pending` | 就绪 | `0xFF9CA3AF` | 未开始 |
| `inProgress` | 进行中 | `0xFF2563EB` | 执行中（机器/AI/人） |
| `completed` | 达标 | `0xFF16A34A` | 成功完成 |
| `failed` | 异常 | `0xFFDC2626` | 执行错误 |
| `rejected` | 驳回 | `0xFFD97706` | AI 输出不达标/人工退回 |
| `cancelled` | 取消 | `0xFF6B7280` | 主动取消 |

`color` 是原始 `int`，不依赖 Flutter `Color` 类。widget 层按需转为 `Color(color)` 并自行计算透明度（如边框用 20% 不透明度）。

设计要点：
- `pending` 和 `cancelled` 共用灰色系，明度不同。pending 较浅（未激活），cancelled 较深（已结束）。
- 三种负面状态用不同色相：`failed` 红（错误）、`rejected` 橙（否决）、`cancelled` 灰（取消）。
- `inProgress` 比 `running` 语义更广，覆盖机器/人/AI 三种执行者。
