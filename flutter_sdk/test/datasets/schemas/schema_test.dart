import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_quanttide_data/flutter_quanttide_data.dart';


void main() {
  group('DataSchema', () {
    test('Create DataSchema from JSON', () {
      final json = {
        'id': '1',
        'name': 'example',
        'verboseName': 'Example Data Schema',
        'readme': 'This is an example data schema.',
        'type': 'schema',
        'createdAt': '2022-01-01T00:00:00Z',
        'updatedAt': '2022-01-02T00:00:00Z',
        'fields': [
          {
            'name': 'field1',
            'verboseName': 'Field 1',
            'type': 'string',
            'defaultValue': 'default',
          },
          {
            'name': 'field2',
            'verboseName': 'Field 2',
            'type': 'number',
            'defaultValue': '0',
          },
        ],
      };

      final dataSchema = DataSchema.fromJson(json);

      expect(dataSchema.id, equals('1'));
      expect(dataSchema.name, equals('example'));
      expect(dataSchema.verboseName, equals('Example Data Schema'));
      expect(dataSchema.readme, equals('This is an example data schema.'));
      expect(dataSchema.type, equals('schema'));
      expect(dataSchema.createdAt, equals(DateTime.utc(2022, 1, 1)));
      expect(dataSchema.updatedAt, equals(DateTime.utc(2022, 1, 2)));
      expect(dataSchema.fields, hasLength(2));
      expect(dataSchema.fields?[0].name, equals('field1'));
      expect(dataSchema.fields?[0].verboseName, equals('Field 1'));
      expect(dataSchema.fields?[0].type, equals('string'));
      expect(dataSchema.fields?[0].defaultValue, equals('default'));
      expect(dataSchema.fields?[1].name, equals('field2'));
      expect(dataSchema.fields?[1].verboseName, equals('Field 2'));
      expect(dataSchema.fields?[1].type, equals('number'));
      expect(dataSchema.fields?[1].defaultValue, equals('0'));
    });
  });
  group('DataSchemaField', () {
    test('Create DataSchemaField from JSON', () {
      final json = {
        'name': 'field1',
        'verboseName': 'Field 1',
        'type': 'string',
        'defaultValue': 'default',
      };

      final dataSchemaField = DataSchemaField.fromJson(json);

      expect(dataSchemaField.name, equals('field1'));
      expect(dataSchemaField.verboseName, equals('Field 1'));
      expect(dataSchemaField.type, equals('string'));
      expect(dataSchemaField.defaultValue, equals('default'));
    });
  });
}
