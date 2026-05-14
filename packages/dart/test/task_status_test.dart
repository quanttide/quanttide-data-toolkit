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
}
