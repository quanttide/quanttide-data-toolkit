import 'task.dart';

/// 数据管道，一组有序 Task 的容器。
///
/// Pipeline 不自持状态，不提供 derivedStatus。
/// 需要时由调用方自行聚合。
///
/// 标识
/// - 标识 `id`（`String`）：唯一标识。
/// - 标识名 [name]（`String`）：URL 路径风格，程序化寻址，
///   如 `order-data-pipeline`。
/// - 标题 [title]（`String`）：中文标题，人读展示。
/// - 描述 [description]（`String`）：详细说明，默认 `''`。
///
/// 内容
/// - 任务列表 [tasks]（`List<Task>`）：所属任务列表。
class Pipeline {
  final String id;
  final String name;
  final String title;
  final String description;
  final List<Task> tasks;

  const Pipeline({
    required this.id,
    required this.name,
    required this.title,
    this.description = '',
    required this.tasks,
  });
}
