import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_quanttide/flutter_quanttide.dart';

import '../schemas/schema.dart';
import '../repositories/schema_repository.dart';

part 'schema_event.dart';
part 'schema_state.dart';


class DataSchemaBloc extends Bloc<DataSchemaEvent, DataSchemaState> {
  final DataSchemaRepository repository = DataSchemaRepository(apiClient: ApiClient(apiRoot: ''));

  DataSchemaBloc() : super(DataSchemaInitial()) {
    on<DataSchemaRetrieved>(_onDataSchemaRetrieved);
    on<DataSchemaCreated>(_onDataSchemaCreated);
    on<DataSchemaUpdated>(_onDataSchemaUpdated);
    on<DataSchemaDeleted>(_onDataSchemaDeleted);
    on<DataSchemaListed>(_onDataSchemaListed);
  }

  void _onDataSchemaRetrieved(DataSchemaRetrieved event, Emitter<DataSchemaState> emit) async {
    emit(DataSchemaWaiting());
    try {
      DataSchema dataSchema = await repository.retrieve('');
      emit(DataSchemaLoaded(dataSchema));
    } catch (e) {
      emit(DataSchemaError(e.toString()));
    }
  }

  void _onDataSchemaCreated(DataSchemaCreated event, Emitter<DataSchemaState> emit) async {
    // TODO: implement logic to create data schema
  }

  void _onDataSchemaUpdated(DataSchemaUpdated event, Emitter<DataSchemaState> emit) async {
    // TODO: implement logic to update data schema
  }

  void _onDataSchemaDeleted(DataSchemaDeleted event, Emitter<DataSchemaState> emit) async {
    // TODO: implement logic to delete data schema
  }

  void _onDataSchemaListed(DataSchemaListed event, Emitter<DataSchemaState> emit) async {
    emit(DataSchemaWaiting());
    try {
      List<DataSchema> dataSchemas = await repository.list();
      emit(DataSchemaListLoaded(dataSchemas));
    } catch (error) {
      emit(DataSchemaError(error.toString()));
    }
  }
}

