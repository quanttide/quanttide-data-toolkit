import 'package:test/test.dart';
import 'package:quanttide_data/quanttide_data.dart';

void main() {
  group('TaskStatus', () {
    test('pending is the first value', () {
      expect(TaskStatus.pending.index, 0);
    });

    test('values contain all six statuses in order', () {
      expect(TaskStatus.values, [
        TaskStatus.pending,
        TaskStatus.inProgress,
        TaskStatus.completed,
        TaskStatus.failed,
        TaskStatus.rejected,
        TaskStatus.cancelled,
      ]);
    });

    group('label', () {
      test('pending label is 就绪', () {
        expect(TaskStatus.pending.label, '就绪');
      });
      test('inProgress label is 进行中', () {
        expect(TaskStatus.inProgress.label, '进行中');
      });
      test('completed label is 达标', () {
        expect(TaskStatus.completed.label, '达标');
      });
      test('failed label is 异常', () {
        expect(TaskStatus.failed.label, '异常');
      });
      test('rejected label is 驳回', () {
        expect(TaskStatus.rejected.label, '驳回');
      });
      test('cancelled label is 取消', () {
        expect(TaskStatus.cancelled.label, '取消');
      });
    });

    group('color', () {
      test('pending color', () {
        expect(TaskStatus.pending.color, 0xFF9CA3AF);
      });
      test('inProgress color', () {
        expect(TaskStatus.inProgress.color, 0xFF2563EB);
      });
      test('completed color', () {
        expect(TaskStatus.completed.color, 0xFF16A34A);
      });
      test('failed color', () {
        expect(TaskStatus.failed.color, 0xFFDC2626);
      });
      test('rejected color', () {
        expect(TaskStatus.rejected.color, 0xFFD97706);
      });
      test('cancelled color', () {
        expect(TaskStatus.cancelled.color, 0xFF6B7280);
      });
    });
  });

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

    test('default createdAt and updatedAt are null', () {
      final task = Task(id: '1', name: 't', title: 'T');
      expect(task.createdAt, isNull);
      expect(task.updatedAt, isNull);
    });

    test('can be created with timestamps', () {
      final now = DateTime(2026, 5, 14);
      final task = Task(
        id: '1', name: 't', title: 'T',
        createdAt: now,
        updatedAt: now,
      );
      expect(task.createdAt, now);
      expect(task.updatedAt, now);
    });
  });

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

    test('default createdAt and updatedAt are null', () {
      final pipeline = Pipeline(
        id: '1', name: 'p', title: 'P', tasks: [],
      );
      expect(pipeline.createdAt, isNull);
      expect(pipeline.updatedAt, isNull);
    });

    test('can be created with timestamps', () {
      final now = DateTime(2026, 5, 14);
      final pipeline = Pipeline(
        id: '1', name: 'p', title: 'P', tasks: [],
        createdAt: now,
        updatedAt: now,
      );
      expect(pipeline.createdAt, now);
      expect(pipeline.updatedAt, now);
    });
  });
}
