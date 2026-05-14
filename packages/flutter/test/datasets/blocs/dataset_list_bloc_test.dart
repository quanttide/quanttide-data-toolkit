import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:flutter_quanttide_data/flutter_quanttide_data.dart';

class MockDataSetRepository extends Mock implements DataSetRepository {}


void main() {
  group('DataSetListBloc', () {
    late DataSetListBloc datasetBloc;

    final DataSet dataset = DataSet(id: '1', name: 'test-dataset', verboseName: 'Test Dataset', readme: 'This is a test dataset.');
    final mockRepository = MockDataSetRepository();

    setUp(() {
      datasetBloc = DataSetListBloc(repository: mockRepository);
    });

    test('initial state', () {
      expect(datasetBloc.state, DataSetListInitial());
    });

    blocTest(
      'emits [DataSetWaiting, DataSetLoaded] when DataSetRetrieved is added',
      build: (){
        when(() => mockRepository.retrieve(dataset.id))
            .thenAnswer((_) async => dataset);
        return datasetBloc;
      },
      act: (bloc) => bloc.add(DataSetRetrieving(dataset)),
      expect: () => [DataSetListWaiting(), DataSetItemLoaded(dataset)],
    );
  });
}
