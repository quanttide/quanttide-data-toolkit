part of  'dataset_list_bloc.dart';

/// 数据集列表事件
sealed class DataSetListEvent extends Equatable {
  const DataSetListEvent();

  @override
  List<Object?> get props => [];
}

/// 请求数据集列表事件
class DataSetListing extends DataSetListEvent {}

/// 请求创建数据集事件
class DataSetCreating extends DataSetListEvent {
  final DataSet dataset;

  const DataSetCreating(this.dataset);

  @override
  List<Object?> get props => [dataset];
}

/// 请求读取数据集事件
class DataSetRetrieving extends DataSetListEvent {
  final DataSet dataset;

  const DataSetRetrieving(this.dataset);

  @override
  List<Object?> get props => [dataset];
}

/// 请求更新数据集事件
class DataSetUpdating extends DataSetListEvent {
  final DataSet dataset;

  const DataSetUpdating(this.dataset);

  @override
  List<Object?> get props => [dataset];
}

/// 请求删除数据集事件
class DataSetDeleting extends DataSetListEvent {
  final DataSet dataset;

  const DataSetDeleting(this.dataset);

  @override
  List<Object?> get props => [dataset];
}
