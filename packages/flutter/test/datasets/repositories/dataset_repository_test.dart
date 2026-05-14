import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_quanttide/flutter_quanttide.dart';

import 'package:flutter_quanttide_data/flutter_quanttide_data.dart';

class MockApiClient extends Mock implements ApiClient {}


void main() {
  late DataSetRepository dataSetRepository;
  final MockApiClient mockApiClient = MockApiClient();
  Map<String, dynamic> datasetJson = {'id': '1', 'name': 'dataset1', 'verboseName': 'DataSet1', 'readme': 'Readme1'};

  setUp(() {
    dataSetRepository = DataSetRepository(apiClient: mockApiClient);
  });

  group('DataSetRepository', () {
    test('list method returns a list of DataSet objects', () async {
      // Arrange
      when(() => mockApiClient.request(httpMethod: 'GET', apiPath: '/datasets'))
          .thenAnswer((_) async => [datasetJson]);

      // Act
      final dataSets = await dataSetRepository.list();

      // Assert
      expect(dataSets, isA<List<DataSet>>());
      expect(dataSets.length, 1);
      expect(dataSets[0].id, '1');
      expect(dataSets[0].name, 'dataset1');
    });

    test('retrieve method returns a DataSet object', () async {
      // Arrange
      const dataSetId = '1';
      when(() => mockApiClient.request(httpMethod: 'GET', apiPath: '/datasets/$dataSetId'))
          .thenAnswer((_) async => datasetJson);

      // Act
      final dataSet = await dataSetRepository.retrieve(dataSetId);

      // Assert
      expect(dataSet, isA<DataSet>());
      expect(dataSet.id, datasetJson['id']);
      expect(dataSet.name, datasetJson['name']);
    });

    test('createDataSet sends a POST request with the correct data', () async {
      // Arrange
      final dataSetToCreate = DataSet(id: '1', name: 'New DataSet', verboseName: '');
      when(() => mockApiClient.request(
        httpMethod: 'POST',
        apiPath: '/datasets',
        data: dataSetToCreate.toJson(),
      )).thenAnswer((_) async => {});

      // Act
      await dataSetRepository.create(dataSetToCreate);

      // Assert
      verify(() => mockApiClient.request(
        httpMethod: 'POST',
        apiPath: '/datasets',
        data: dataSetToCreate.toJson(),
      )).called(1);
    });

    test('deleteDataSet sends a DELETE request with the correct path', () async {
      // Arrange
      const dataSetIdToDelete = '1';
      when(() => mockApiClient.request(httpMethod: 'DELETE', apiPath: '/datasets/$dataSetIdToDelete'))
          .thenAnswer((_) async => {});

      // Act
      await dataSetRepository.delete(dataSetIdToDelete);

      // Assert
      verify(() => mockApiClient.request(httpMethod: 'DELETE', apiPath: '/datasets/$dataSetIdToDelete'))
          .called(1);
    });
  });
}
