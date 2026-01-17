import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_quanttide/flutter_quanttide.dart';

import 'package:flutter_quanttide_data/flutter_quanttide_data.dart';


class MockApiClient extends Mock implements ApiClient {}

void main() {
  late DataSchemaRepository repository;
  late MockApiClient mockApiClient;

  setUp(() {
    mockApiClient = MockApiClient();
    repository = DataSchemaRepository(apiClient: mockApiClient);
  });

  group('DataSchemaRepository', (){
    test(
        'listDataSchemas should return a list of DataSchema objects', () async {
      // Mock API response
      final apiResponse = [
        {'id': '1', 'name': 'Schema 1'},
        {'id': '2', 'name': 'Schema 2'},
      ];

      // Set up the mock API call
      when(() => mockApiClient.request(apiPath: "/schemas", httpMethod: "GET"))
          .thenAnswer((_) async => apiResponse);

      // Call the repository method
      final result = await repository.list();

      // Verify the API call was made with the correct parameters
      // verify(mockApiClient.listDataSchemas());

      // Verify the result is a list of DataSchema objects
      expect(result, isA<List<DataSchema>>());
      expect(result.length, equals(apiResponse.length));
    });
  });
}