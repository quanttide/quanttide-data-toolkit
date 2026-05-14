/// 数据集就绪状态。
///
/// 四个值在同一维度上描述"数据集是否可用及可用程度"：
/// `pending` → `ready` → `outdated`，`failed` 是任意节点的异常终止。
///
/// 属性包括：
/// - 名称 `name`（`String`）：枚举标识，由枚举值名提供。
/// - 标签 [label]（`String`）：人类可读的状态名，如 `等待中`、`已就绪`。
/// - 颜色 [color]（`int`）：灰度上 [pending]（浅灰）与 [outdated]（中灰）
///   共用灰色系、明度不同；[ready] 绿色；[failed] 红色。
enum DatasetStatus {
  pending('等待中', 0xFF9CA3AF),
  ready('已就绪', 0xFF16A34A),
  outdated('已过时', 0xFF6B7280),
  failed('异常', 0xFFDC2626);

  /// 中文展示标签。
  final String label;

  /// 色系 hex 的原始 int 值。
  final int color;

  const DatasetStatus(this.label, this.color);
}

/// 数据集。
///
/// 数据集是经采集或处理后可供使用的数据单元。
/// Dataset 是独立聚合根，不依附于其他实体。
///
/// 标识
/// - 标识 [id]（`String`）：唯一标识。
/// - 标识名 [name]（`String`）：URL 路径风格，程序化寻址。
/// - 标题 [title]（`String`）：中文标题，人读展示。
/// - 描述 [description]（`String`）：详细说明，默认 `''`。
///
/// 状态
/// - 状态 [status]（`DatasetStatus`）：数据集就绪状态，默认 [DatasetStatus.pending]。
///
/// 审计
/// - 创建时间 [createdAt]（`DateTime?`）：创建时间。
/// - 更新时间 [updatedAt]（`DateTime?`）：最后更新时间。
class Dataset {
  final String id;
  final String name;
  final String title;
  final String description;
  final DatasetStatus status;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const Dataset({
    required this.id,
    required this.name,
    required this.title,
    this.description = '',
    this.status = DatasetStatus.pending,
    this.createdAt,
    this.updatedAt,
  });
}
