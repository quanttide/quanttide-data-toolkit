import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quanttide_data/flutter_quanttide_data.dart';


class DataSetListScreen extends StatelessWidget {
  const DataSetListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('数据集列表'),
      ),
      body: BlocBuilder<DataSetListBloc, DataSetListState>(
          builder: (context, state) {
            if (state is DataSetListInitial) {
              return const Center(child: Text('初始状态'));
            }
            else if (state is DataSetListWaiting) {
              return const Center(child: CircularProgressIndicator());
            }
            else if (state is DataSetListError){
              return const Center(child: Text('加载数据集失败'));
            }
            else if (state is DataSetListLoaded) {
              return DataSetTableView(datasets: state.datasets);
            }
            else {
              throw Exception("Unknown state: ${state.runtimeType}");
            }
          }
      )
    );
  }
}
