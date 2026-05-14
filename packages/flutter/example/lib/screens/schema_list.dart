import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_quanttide_data/flutter_quanttide_data.dart';


class DataSchemaTableScreen extends StatelessWidget {
  const DataSchemaTableScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DataSchemaBloc, DataSchemaState>(
      builder: (context, state) {
        if (state is DataSchemaWaiting) {
          return buildWaiting(context);
        } else if (state is DataSchemaListLoaded) {
          return buildSuccess(
              context,
              dataSchemaList: state.dataSchemaList
          );
        } else if (state is DataSchemaError) {
          return buildError(context, message: state.message);
        } else {
          return buildError(context, message: 'Unknown state');
        }
      },
    );
  }

  Widget buildSuccess(BuildContext context, {required dataSchemaList}) {
    return DataSchemaTableView(dataSchemaList: dataSchemaList,);
  }

  Widget buildWaiting(BuildContext context){
    return const Center(
        child: CircularProgressIndicator()
    );
  }

  Widget buildError(BuildContext context, {required message}){
    return Center(
      child: Text('Error: $message'),
    );
  }
}