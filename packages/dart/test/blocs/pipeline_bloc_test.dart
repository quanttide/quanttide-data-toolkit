import 'package:test/test.dart';
import 'package:quanttide_data/quanttide_data.dart';

class _MockPipelineRepository implements PipelineRepository {
  @override
  Future<Pipeline> fetch(String id) async {
    return Pipeline(
      id: id,
      name: 'pipeline-$id',
      title: 'Pipeline $id',
      tasks: [Task(id: 't1', name: 'task1', title: 'Task 1')],
    );
  }
}

class _FailingPipelineRepository implements PipelineRepository {
  @override
  Future<Pipeline> fetch(String id) async {
    throw Exception('fetch failed');
  }
}

void main() {
  group('PipelineBloc', () {
    test('initial state is PipelineInitial', () {
      final bloc = PipelineBloc(repository: _MockPipelineRepository());
      expect(bloc.state, isA<PipelineInitial>());
      bloc.close();
    });

    test('LoadPipeline emits Loading then Loaded', () async {
      final bloc = PipelineBloc(repository: _MockPipelineRepository());

      bloc.add(LoadPipeline('1'));
      await expectLater(
        bloc.stream,
        emitsInOrder([
          isA<PipelineLoading>(),
          isA<PipelineLoaded>(),
        ]),
      );

      bloc.close();
    });

    test('PipelineLoadFailed stores message', () {
      final error = PipelineLoadFailed('test error');
      expect(error.message, 'test error');
    });

    test('LoadPipeline replaces existing state', () async {
      final repo = _MockPipelineRepository();
      final bloc = PipelineBloc(repository: repo);

      bloc.add(LoadPipeline('1'));
      await expectLater(
        bloc.stream,
        emitsInOrder([
          isA<PipelineLoading>(),
          isA<PipelineLoaded>(),
        ]),
      );

      bloc.add(LoadPipeline('2'));
      await expectLater(
        bloc.stream,
        emitsInOrder([
          isA<PipelineLoading>(),
          isA<PipelineLoaded>(),
        ]),
      );

      final loaded = bloc.state as PipelineLoaded;
      expect(loaded.pipeline.id, '2');

      bloc.close();
    });

    test('LoadPipeline emits LoadFailed on error', () async {
      final bloc = PipelineBloc(repository: _FailingPipelineRepository());

      bloc.add(LoadPipeline('1'));
      await expectLater(
        bloc.stream,
        emitsInOrder([
          isA<PipelineLoading>(),
          isA<PipelineLoadFailed>(),
        ]),
      );

      bloc.close();
    });

    test('RefreshPipeline emits Loading then Loaded', () async {
      final bloc = PipelineBloc(repository: _MockPipelineRepository());

      bloc.add(RefreshPipeline('1'));
      await expectLater(
        bloc.stream,
        emitsInOrder([
          isA<PipelineLoading>(),
          isA<PipelineLoaded>(),
        ]),
      );

      bloc.close();
    });

    test('RetryPipeline emits Loading then Loaded', () async {
      final bloc = PipelineBloc(repository: _MockPipelineRepository());

      bloc.add(RetryPipeline('1'));
      await expectLater(
        bloc.stream,
        emitsInOrder([
          isA<PipelineLoading>(),
          isA<PipelineLoaded>(),
        ]),
      );

      bloc.close();
    });
  });
}
