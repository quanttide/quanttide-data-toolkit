import 'task.dart';

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
