import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';

import '../schemas/dataset.dart';
import '../repositories/dataset_repository.dart';

part 'dataset_list_event.dart';
part 'dataset_list_state.dart';


/// 数据集列表BLoC
class DataSetListBloc extends Bloc<DataSetListEvent, DataSetListState> {
  final DataSetRepository repository;

  DataSetListBloc({required this.repository}) : super(DataSetListInitial()) {
    on<DataSetListing>(_onDataSetListing);
    on<DataSetRetrieving>(_onDataSetRetrieving);
    on<DataSetCreating>(_onDataSetCreating);
    on<DataSetUpdating>(_onDataSetUpdating);
    on<DataSetDeleting>(_onDataSetDeleting);
  }

  /// Handles the [DataSetListing] event.
  void  _onDataSetListing(DataSetListing event, Emitter<DataSetListState> emit) async {
    // emit waiting state
    emit(DataSetListWaiting());
    // retrieve dataset
    try {
      List<DataSet> datasets = await repository.list();
      // emit success state
      emit(DataSetListLoaded(datasets));
    }
    catch (e) {
      // emit error state
      emit(DataSetListError(e.toString()));
    }
  }

  /// Handles the [DataSetCreating] event.
  void _onDataSetCreating(DataSetCreating event, Emitter<DataSetListState> emit) async {
    // emit waiting state
    emit(DataSetListWaiting());
    // create dataset
    try {
      await repository.create(event.dataset);
      // emit success state
      List<DataSet> datasets = await repository.list();
      emit(DataSetListLoaded(datasets));
    }
    catch (e) {
      // emit error state
      emit(DataSetListError(e.toString()));
    }
  }

  /// Handles the [DataSetRetrieving] event.
  void _onDataSetRetrieving(DataSetRetrieving event, Emitter<DataSetListState> emit) async {
    // emit waiting state
    emit(DataSetListWaiting());
    // retrieve dataset
    try {
      DataSet dataset = await repository.retrieve(event.dataset.id);
      // emit success state
      emit(DataSetItemLoaded(dataset));
    }
    catch (e) {
      // emit error state
      emit(DataSetListError(e.toString()));
    }
  }

  /// Handles the [DataSetUpdating] event.
  /// Returns to the new state
  void _onDataSetUpdating(DataSetUpdating event, Emitter<DataSetListState> emit) async {
    // emit waiting state
    emit(DataSetListWaiting());
    // update dataset
    try {
      await repository.create(event.dataset);
      // emit success state
      emit(DataSetItemLoaded(event.dataset));
    }
    catch (e) {
      // emit error state
      emit(DataSetListError(e.toString()));
    }
  }

  /// Handles the [DataSetDeleting] event.
  /// Returns to the initial state.
  void _onDataSetDeleting(DataSetDeleting event, Emitter<DataSetListState> emit) async {
    // emit waiting state
    emit(DataSetListWaiting());
    // delete dataset
    try {
      await repository.delete(event.dataset.id);
      // emit success state
      List<DataSet> datasets = await repository.list();
      emit(DataSetListLoaded(datasets));
    }
    catch (e) {
      // emit error state
      emit(DataSetListError(e.toString()));
    }
  }
}
