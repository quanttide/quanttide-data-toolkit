enum TaskStatus {
  pending('就绪', 0xFF9CA3AF),
  inProgress('进行中', 0xFF2563EB),
  completed('达标', 0xFF16A34A),
  failed('异常', 0xFFDC2626),
  rejected('驳回', 0xFFD97706),
  cancelled('取消', 0xFF6B7280);

  final String label;
  final int color;

  const TaskStatus(this.label, this.color);
}

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
