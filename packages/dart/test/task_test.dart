import 'package:test/test.dart';
import 'package:quanttide_data/quanttide_data.dart';

void main() {
  group('Task', () {
    test('default status is pending', () {
      final task = Task(id: '1', name: 'task1', title: 'Task 1');
      expect(task.status, TaskStatus.pending);
    });

    test('default description is empty string', () {
      final task = Task(id: '1', name: 'task1', title: 'Task 1');
      expect(task.description, '');
    });

    test('can be created with custom status', () {
      final task = Task(
        id: '1',
        name: 'task1',
        title: 'Task 1',
        status: TaskStatus.inProgress,
      );
      expect(task.status, TaskStatus.inProgress);
    });

    test('can be created with description', () {
      final task = Task(
        id: '1',
        name: 'task1',
        title: 'Task 1',
        description: 'A test task',
      );
      expect(task.description, 'A test task');
    });

    test('all fields are accessible', () {
      final task = Task(
        id: 't1',
        name: 'import/sales-orders',
        title: '导入销售订单',
        description: '从 ERP 导入销售订单数据',
        status: TaskStatus.inProgress,
      );
      expect(task.id, 't1');
      expect(task.name, 'import/sales-orders');
      expect(task.title, '导入销售订单');
      expect(task.description, '从 ERP 导入销售订单数据');
      expect(task.status, TaskStatus.inProgress);
    });
  });
}
