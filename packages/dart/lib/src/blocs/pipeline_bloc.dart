import 'package:bloc/bloc.dart';
import 'package:quanttide_data/quanttide_data.dart';

sealed class PipelineEvent {}

class LoadPipeline extends PipelineEvent {
  final String pipelineId;
  LoadPipeline(this.pipelineId);
}

class RefreshPipeline extends PipelineEvent {
  final String pipelineId;
  RefreshPipeline(this.pipelineId);
}

class RetryPipeline extends PipelineEvent {
  final String pipelineId;
  RetryPipeline(this.pipelineId);
}

sealed class PipelineState {}

class PipelineInitial extends PipelineState {}

class PipelineLoading extends PipelineState {}

class PipelineLoaded extends PipelineState {
  final Pipeline pipeline;
  PipelineLoaded(this.pipeline);
}

class PipelineLoadFailed extends PipelineState {
  final String message;
  PipelineLoadFailed(this.message);
}

class PipelineBloc extends Bloc<PipelineEvent, PipelineState> {
  final PipelineRepository _repository;

  PipelineBloc({required PipelineRepository repository})
    : _repository = repository,
      super(PipelineInitial()) {
    on<LoadPipeline>(_onLoadPipeline);
    on<RefreshPipeline>(_onRefreshPipeline);
    on<RetryPipeline>(_onRetryPipeline);
  }

  Future<void> _onLoadPipeline(
    LoadPipeline event,
    Emitter<PipelineState> emit,
  ) async {
    emit(PipelineLoading());
    try {
      final pipeline = await _repository.fetch(event.pipelineId);
      emit(PipelineLoaded(pipeline));
    } catch (e) {
      emit(PipelineLoadFailed(e.toString()));
    }
  }

  Future<void> _onRefreshPipeline(
    RefreshPipeline event,
    Emitter<PipelineState> emit,
  ) async {
    emit(PipelineLoading());
    try {
      final pipeline = await _repository.fetch(event.pipelineId);
      emit(PipelineLoaded(pipeline));
    } catch (e) {
      emit(PipelineLoadFailed(e.toString()));
    }
  }

  Future<void> _onRetryPipeline(
    RetryPipeline event,
    Emitter<PipelineState> emit,
  ) async {
    emit(PipelineLoading());
    try {
      final pipeline = await _repository.fetch(event.pipelineId);
      emit(PipelineLoaded(pipeline));
    } catch (e) {
      emit(PipelineLoadFailed(e.toString()));
    }
  }
}
