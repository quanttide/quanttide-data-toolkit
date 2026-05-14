import 'package:test/test.dart';
import 'package:quanttide_data/quanttide_data.dart';

class _MockDatasetRepository implements DatasetRepository {
  @override
  Future<Dataset> fetch(String id) async {
    return Dataset(id: id, name: 'ds-$id', title: 'Dataset $id');
  }
}

class _FailingDatasetRepository implements DatasetRepository {
  @override
  Future<Dataset> fetch(String id) async {
    throw Exception('fetch failed');
  }
}

void main() {
  group('DatasetBloc', () {
    test('initial state is DatasetInitial', () {
      final bloc = DatasetBloc(repository: _MockDatasetRepository());
      expect(bloc.state, isA<DatasetInitial>());
      bloc.close();
    });

    test('LoadDataset emits Loading then Loaded', () async {
      final bloc = DatasetBloc(repository: _MockDatasetRepository());

      bloc.add(LoadDataset('1'));
      await expectLater(
        bloc.stream,
        emitsInOrder([
          isA<DatasetLoading>(),
          isA<DatasetLoaded>(),
        ]),
      );

      bloc.close();
    });

    test('DatasetLoadFailed stores message', () {
      final error = DatasetLoadFailed('test error');
      expect(error.message, 'test error');
    });

    test('LoadDataset replaces existing state', () async {
      final repo = _MockDatasetRepository();
      final bloc = DatasetBloc(repository: repo);

      bloc.add(LoadDataset('1'));
      await expectLater(
        bloc.stream,
        emitsInOrder([
          isA<DatasetLoading>(),
          isA<DatasetLoaded>(),
        ]),
      );

      bloc.add(LoadDataset('2'));
      await expectLater(
        bloc.stream,
        emitsInOrder([
          isA<DatasetLoading>(),
          isA<DatasetLoaded>(),
        ]),
      );

      final loaded = bloc.state as DatasetLoaded;
      expect(loaded.dataset.id, '2');

      bloc.close();
    });

    test('LoadDataset emits LoadFailed on error', () async {
      final bloc = DatasetBloc(repository: _FailingDatasetRepository());

      bloc.add(LoadDataset('1'));
      await expectLater(
        bloc.stream,
        emitsInOrder([
          isA<DatasetLoading>(),
          isA<DatasetLoadFailed>(),
        ]),
      );

      bloc.close();
    });

    test('RefreshDataset emits Loading then Loaded', () async {
      final bloc = DatasetBloc(repository: _MockDatasetRepository());

      bloc.add(RefreshDataset('1'));
      await expectLater(
        bloc.stream,
        emitsInOrder([
          isA<DatasetLoading>(),
          isA<DatasetLoaded>(),
        ]),
      );

      bloc.close();
    });

    test('RetryDataset emits Loading then Loaded', () async {
      final bloc = DatasetBloc(repository: _MockDatasetRepository());

      bloc.add(RetryDataset('1'));
      await expectLater(
        bloc.stream,
        emitsInOrder([
          isA<DatasetLoading>(),
          isA<DatasetLoaded>(),
        ]),
      );

      bloc.close();
    });
  });
}
