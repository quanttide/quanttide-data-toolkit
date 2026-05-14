import 'package:test/test.dart';
import 'package:quanttide_data/quanttide_data.dart';

void main() {
  group('DatasetStatus', () {
    test('values contain all four statuses in order', () {
      expect(DatasetStatus.values, [
        DatasetStatus.pending,
        DatasetStatus.ready,
        DatasetStatus.outdated,
        DatasetStatus.failed,
      ]);
    });

    group('label', () {
      test('pending label is 等待中', () {
        expect(DatasetStatus.pending.label, '等待中');
      });
      test('ready label is 已就绪', () {
        expect(DatasetStatus.ready.label, '已就绪');
      });
      test('outdated label is 已过时', () {
        expect(DatasetStatus.outdated.label, '已过时');
      });
      test('failed label is 异常', () {
        expect(DatasetStatus.failed.label, '异常');
      });
    });

    group('color', () {
      test('pending color', () {
        expect(DatasetStatus.pending.color, 0xFF9CA3AF);
      });
      test('ready color', () {
        expect(DatasetStatus.ready.color, 0xFF16A34A);
      });
      test('outdated color', () {
        expect(DatasetStatus.outdated.color, 0xFF6B7280);
      });
      test('failed color', () {
        expect(DatasetStatus.failed.color, 0xFFDC2626);
      });
    });
  });

  group('Dataset', () {
    test('default status is pending', () {
      final ds = Dataset(id: '1', name: 'ds1', title: 'DS 1');
      expect(ds.status, DatasetStatus.pending);
    });

    test('default description is empty string', () {
      final ds = Dataset(id: '1', name: 'ds1', title: 'DS 1');
      expect(ds.description, '');
    });

    test('default timestamps are null', () {
      final ds = Dataset(id: '1', name: 'ds1', title: 'DS 1');
      expect(ds.createdAt, isNull);
      expect(ds.updatedAt, isNull);
    });

    test('can be created with custom status', () {
      final ds = Dataset(
        id: '1', name: 'ds1', title: 'DS 1',
        status: DatasetStatus.ready,
      );
      expect(ds.status, DatasetStatus.ready);
    });

    test('all fields are accessible', () {
      final now = DateTime(2026, 5, 14);
      final ds = Dataset(
        id: 'd1',
        name: 'sales-orders-202605',
        title: '销售订单数据集',
        description: '2026年5月销售订单数据',
        status: DatasetStatus.ready,
        createdAt: now,
        updatedAt: now,
      );
      expect(ds.id, 'd1');
      expect(ds.name, 'sales-orders-202605');
      expect(ds.title, '销售订单数据集');
      expect(ds.description, '2026年5月销售订单数据');
      expect(ds.status, DatasetStatus.ready);
      expect(ds.createdAt, now);
      expect(ds.updatedAt, now);
    });
  });
}
