part of 'schema_bloc.dart';


sealed class DataSchemaState extends Equatable {
  const DataSchemaState();

  @override
  List<Object?> get props => [];
}

class DataSchemaInitial extends DataSchemaState {}

class DataSchemaWaiting extends DataSchemaState {}

class DataSchemaError extends DataSchemaState {
  final String message;

  const DataSchemaError(this.message);

  @override
  List<Object?> get props => [message];
}

class DataSchemaLoaded extends DataSchemaState {
  final DataSchema dataSchema;

  const DataSchemaLoaded(this.dataSchema);

  @override
  List<Object?> get props => [dataSchema];
}

class DataSchemaListLoaded extends DataSchemaState {
  final List<DataSchema> dataSchemaList;

  const DataSchemaListLoaded(this.dataSchemaList);

  @override
  List<Object?> get props => [dataSchemaList];
}
