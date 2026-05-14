/// 任务状态。
///
/// 采用通用项目管理风格，名称不绑定特定执行者类型——用 [inProgress] 而非
/// "running" 以覆盖机器、AI、人三种场景，用 [failed]/[rejected] 区分
/// 系统执行错误与业务结果不达标。
///
/// 属性包括：
/// - 名称 `name`（`String`）：枚举标识，由枚举值名提供。
/// - 标签 [label]（`String`）：人类可读的状态名，如 `就绪`、`进行中`。
/// - 颜色 [color]（`int`）：原始 int 值，不依赖 Flutter Color 类。
///   灰度设计上 [pending]（浅灰，未激活）与 [cancelled]（深灰，已结束）
///   共用灰色系、明度不同；三种负面状态用不同色相：
///   [failed] 红（错误）、[rejected] 橙（否决）、[cancelled] 灰（取消）。
enum TaskStatus {
  pending('就绪', 0xFF9CA3AF),
  inProgress('进行中', 0xFF2563EB),
  completed('达标', 0xFF16A34A),
  failed('异常', 0xFFDC2626),
  rejected('驳回', 0xFFD97706),
  cancelled('取消', 0xFF6B7280);

  /// 中文展示标签。
  final String label;

  /// 色系 hex 的原始 int 值。
  final int color;

  const TaskStatus(this.label, this.color);
}

/// 管道中的最小工作项。
///
/// 标识
/// - 标识 `id`（`String`）：唯一标识。
/// - 标识名 [name]（`String`）：URL 路径风格，如 `import/sales-orders`。
/// - 标题 [title]（`String`）：中文标题，人读展示。
/// - 描述 [description]（`String`）：详细说明，默认 `''`。
///
/// 状态
/// - 状态 [status]（`TaskStatus`）：任务状态，默认 [TaskStatus.pending]。
class Task {
  final String id;
  final String name;
  final String title;
  final String description;
  final TaskStatus status;

  const Task({
    required this.id,
    required this.name,
    required this.title,
    this.description = '',
    this.status = TaskStatus.pending,
  });
}
