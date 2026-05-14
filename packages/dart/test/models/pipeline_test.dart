import 'package:test/test.dart';
import 'package:quanttide_data/quanttide_data.dart';

void main() {
  group('Pipeline', () {
    test('default description is empty string', () {
      final pipeline = Pipeline(
        id: '1',
        name: 'test-pipeline',
        title: 'Test Pipeline',
        tasks: [],
      );
      expect(pipeline.description, '');
    });

    test('can be created with tasks', () {
      final tasks = [
        Task(id: 't1', name: 'task1', title: 'Task 1'),
        Task(id: 't2', name: 'task2', title: 'Task 2'),
      ];
      final pipeline = Pipeline(
        id: '1',
        name: 'test-pipeline',
        title: 'Test Pipeline',
        tasks: tasks,
      );
      expect(pipeline.tasks, tasks);
      expect(pipeline.tasks.length, 2);
    });

    test('can be created with description', () {
      final pipeline = Pipeline(
        id: '1',
        name: 'test-pipeline',
        title: 'Test Pipeline',
        description: 'A test pipeline',
        tasks: [
          Task(id: 't1', name: 'task1', title: 'Task 1'),
        ],
      );
      expect(pipeline.description, 'A test pipeline');
    });

    test('all fields are accessible', () {
      final tasks = [
        Task(id: 't1', name: 'task1', title: 'Task 1'),
      ];
      final pipeline = Pipeline(
        id: 'p1',
        name: 'order-data-pipeline',
        title: '订单数据管道',
        description: '处理订单数据的完整流程',
        tasks: tasks,
      );
      expect(pipeline.id, 'p1');
      expect(pipeline.name, 'order-data-pipeline');
      expect(pipeline.title, '订单数据管道');
      expect(pipeline.description, '处理订单数据的完整流程');
      expect(pipeline.tasks, tasks);
    });
  });
}
