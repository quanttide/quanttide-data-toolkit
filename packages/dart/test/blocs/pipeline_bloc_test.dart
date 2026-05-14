import 'package:test/test.dart';
import 'package:quanttide_data/quanttide_data.dart';

void main() {
  group('PipelineBloc', () {
    test('initial state is PipelineInitial', () {
      final bloc = PipelineBloc();
      expect(bloc.state, isA<PipelineInitial>());
      bloc.close();
    });

    test('LoadPipeline emits Loading then Loaded', () async {
      final bloc = PipelineBloc();
      final pipeline = Pipeline(
        id: '1',
        name: 'test-pipeline',
        title: 'Test Pipeline',
        tasks: [Task(id: 't1', name: 'task1', title: 'Task 1')],
      );

      bloc.add(LoadPipeline(pipeline));
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
      final bloc = PipelineBloc();
      final pipeline1 = Pipeline(
        id: '1',
        name: 'first',
        title: 'First',
        tasks: [Task(id: 't1', name: 'task1', title: 'Task 1')],
      );
      final pipeline2 = Pipeline(
        id: '2',
        name: 'second',
        title: 'Second',
        tasks: [Task(id: 't2', name: 'task2', title: 'Task 2')],
      );

      bloc.add(LoadPipeline(pipeline1));
      await expectLater(
        bloc.stream,
        emitsInOrder([
          isA<PipelineLoading>(),
          isA<PipelineLoaded>(),
        ]),
      );

      bloc.add(LoadPipeline(pipeline2));
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

    test('RefreshPipeline emits Loading then Loaded', () async {
      final bloc = PipelineBloc();
      final pipeline = Pipeline(
        id: '1',
        name: 'refresh-pipeline',
        title: 'Refreshed',
        tasks: [],
      );

      bloc.add(RefreshPipeline(pipeline));
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
      final bloc = PipelineBloc();
      final pipeline = Pipeline(
        id: '1',
        name: 'retry-pipeline',
        title: 'Retried',
        tasks: [],
      );

      bloc.add(RetryPipeline(pipeline));
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
