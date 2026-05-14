import 'package:bloc/bloc.dart';
import 'package:quanttide_data/quanttide_data.dart';

sealed class PipelineEvent {}

class LoadPipeline extends PipelineEvent {
  final Pipeline pipeline;

  LoadPipeline(this.pipeline);
}

class RefreshPipeline extends PipelineEvent {
  final Pipeline pipeline;

  RefreshPipeline(this.pipeline);
}

class RetryPipeline extends PipelineEvent {
  final Pipeline pipeline;

  RetryPipeline(this.pipeline);
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
  PipelineBloc() : super(PipelineInitial()) {
    on<LoadPipeline>(_onLoadPipeline);
    on<RefreshPipeline>(_onRefreshPipeline);
    on<RetryPipeline>(_onRetryPipeline);
  }

  void _onLoadPipeline(LoadPipeline event, Emitter<PipelineState> emit) {
    emit(PipelineLoading());
    emit(PipelineLoaded(event.pipeline));
  }

  void _onRefreshPipeline(RefreshPipeline event, Emitter<PipelineState> emit) {
    emit(PipelineLoading());
    emit(PipelineLoaded(event.pipeline));
  }

  void _onRetryPipeline(RetryPipeline event, Emitter<PipelineState> emit) {
    emit(PipelineLoading());
    emit(PipelineLoaded(event.pipeline));
  }
}
