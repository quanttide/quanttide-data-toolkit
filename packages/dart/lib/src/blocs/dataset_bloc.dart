import 'package:bloc/bloc.dart';
import 'package:quanttide_data/quanttide_data.dart';

sealed class DatasetEvent {}

class LoadDataset extends DatasetEvent {
  final String datasetId;
  LoadDataset(this.datasetId);
}

class RefreshDataset extends DatasetEvent {
  final String datasetId;
  RefreshDataset(this.datasetId);
}

class RetryDataset extends DatasetEvent {
  final String datasetId;
  RetryDataset(this.datasetId);
}

sealed class DatasetState {}

class DatasetInitial extends DatasetState {}

class DatasetLoading extends DatasetState {}

class DatasetLoaded extends DatasetState {
  final Dataset dataset;
  DatasetLoaded(this.dataset);
}

class DatasetLoadFailed extends DatasetState {
  final String message;
  DatasetLoadFailed(this.message);
}

class DatasetBloc extends Bloc<DatasetEvent, DatasetState> {
  final DatasetRepository _repository;

  DatasetBloc({required DatasetRepository repository})
    : _repository = repository,
      super(DatasetInitial()) {
    on<LoadDataset>(_onLoadDataset);
    on<RefreshDataset>(_onRefreshDataset);
    on<RetryDataset>(_onRetryDataset);
  }

  Future<void> _onLoadDataset(
    LoadDataset event,
    Emitter<DatasetState> emit,
  ) async {
    emit(DatasetLoading());
    try {
      final dataset = await _repository.fetch(event.datasetId);
      emit(DatasetLoaded(dataset));
    } catch (e) {
      emit(DatasetLoadFailed(e.toString()));
    }
  }

  Future<void> _onRefreshDataset(
    RefreshDataset event,
    Emitter<DatasetState> emit,
  ) async {
    emit(DatasetLoading());
    try {
      final dataset = await _repository.fetch(event.datasetId);
      emit(DatasetLoaded(dataset));
    } catch (e) {
      emit(DatasetLoadFailed(e.toString()));
    }
  }

  Future<void> _onRetryDataset(
    RetryDataset event,
    Emitter<DatasetState> emit,
  ) async {
    emit(DatasetLoading());
    try {
      final dataset = await _repository.fetch(event.datasetId);
      emit(DatasetLoaded(dataset));
    } catch (e) {
      emit(DatasetLoadFailed(e.toString()));
    }
  }
}
