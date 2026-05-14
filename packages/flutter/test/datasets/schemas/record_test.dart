import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_quanttide_data/flutter_quanttide_data.dart';


void main() {
  group('DataRecord', () {
    test('init', () {
      final dataRecord = DataRecord(
        id: '1',
        items: [
          DataRecordItem(key: 'name', value: 'John'),
          DataRecordItem(key: 'age', value: 25),
        ],
      );

      expect(dataRecord, isA<DataRecord>());
      expect(dataRecord.id, '1');
      expect(dataRecord.items, isA<List<DataRecordItem>>());
      expect(dataRecord.items!.length, 2);
      expect(dataRecord.items![0].key, 'name');
      expect(dataRecord.items![0].value, 'John');
      expect(dataRecord.items![1].key, 'age');
      expect(dataRecord.items![1].value, 25);
    });

    test('fromJson', () {
      final jsonMap = {
        'id': '1',
        'items': [
          {'key': 'name', 'value': 'John'},
          {'key': 'age', 'value': 25},
        ],
      };

      final dataRecordFromJson = DataRecord.fromJson(jsonMap);

      expect(dataRecordFromJson, isA<DataRecord>());
      expect(dataRecordFromJson.id, '1');
      expect(dataRecordFromJson.items, isA<List<DataRecordItem>>());
      expect(dataRecordFromJson.items!.length, 2);
      expect(dataRecordFromJson.items![0].key, 'name');
      expect(dataRecordFromJson.items![0].value, 'John');
      expect(dataRecordFromJson.items![1].key, 'age');
      expect(dataRecordFromJson.items![1].value, 25);
    });
  });
}
