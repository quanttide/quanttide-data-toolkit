import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_quanttide_data/flutter_quanttide_data.dart';


void main() {
  group('DataSet', () {
    test('can be created', () {
      final dataset = DataSet(
        id: 'some_id',
        name: 'Some Name',
        verboseName: 'Verbose Name',
        readme: 'Some Description',
      );

      expect(dataset, isA<DataSet>());
      expect(dataset.id, 'some_id');
      expect(dataset.name, 'Some Name');
      expect(dataset.verboseName, 'Verbose Name');
      expect(dataset.readme, 'Some Description');
    });

    test('fromJson and toJson', () {
      final jsonMap = {
        'id': 'some_id',
        'name': 'Some Name',
        'verboseName': 'Verbose Name',
        'readme': 'Some Description',
      };

      final datasetFromJson = DataSet.fromJson(jsonMap);

      expect(datasetFromJson, isA<DataSet>());
      expect(datasetFromJson.id, 'some_id');
      expect(datasetFromJson.name, 'Some Name');
      expect(datasetFromJson.verboseName, 'Verbose Name');
      expect(datasetFromJson.readme, 'Some Description');

      final jsonFromDataset = datasetFromJson.toJson();

      expect(jsonFromDataset, isA<Map<String, dynamic>>());
      expect(jsonFromDataset, jsonMap);
    });
  });
}
