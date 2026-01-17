part of 'dataset_list_bloc.dart';

sealed class DataSetListState extends Equatable {
  const DataSetListState();

  @override
  List<Object?> get props => [];
}

/// 数据集列表初始状态
class DataSetListInitial extends DataSetListState {}


/// 数据集列表加载中状态
class DataSetListWaiting extends DataSetListState {}

/// 数据集列表加载异常状态
class DataSetListError extends DataSetListState {
  final String message;

  const DataSetListError(this.message);

  @override
  List<Object?> get props => [message];
}

/// 数据集列表已加载状态
class DataSetListLoaded extends DataSetListState {
  final List<DataSet> datasets;

  const DataSetListLoaded(this.datasets);

  @override
  List<Object?> get props => [datasets];
}

/// 数据集已加载状态
class DataSetItemLoaded extends DataSetListState {
  final DataSet dataset;

  const DataSetItemLoaded(this.dataset);

  @override
  List<Object?> get props => [dataset];
}

/// 数据集编辑中状态
class DataSetItemEditing extends DataSetListState {
  final DataSet dataset;

  const DataSetItemEditing(this.dataset);

  @override
  List<Object?> get props => [dataset];
}
