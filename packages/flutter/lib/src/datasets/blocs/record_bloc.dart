import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'record_event.dart';
part 'record_state.dart';

class DataRecordBloc extends Bloc<DataRecordEvent, DataRecordState> {
  DataRecordBloc() : super(DataRecordInitial()) {
    on<DataRecordEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
