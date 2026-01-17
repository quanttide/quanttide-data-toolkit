/// 数据集表格视图
import 'package:flutter/material.dart';
import 'package:data_table_2/data_table_2.dart';

import '../schemas/dataset.dart';


/// 数据集表格视图
class DataSetTableView extends StatelessWidget {
  /// 数据集列表
  final List<DataSet> datasets;

  const DataSetTableView({super.key, required this.datasets});

  @override
  Widget build(BuildContext context) {
    final List<String> columns = ["ID", "标识", '名称', '描述'];
    return DataTable2(
      // minWidth: 600,
      columns: columns.map((column) =>
        DataColumn(label: Text(column))
      ).toList(),
      rows: datasets.map((dataset) =>
        DataRow(cells: [
          DataCell(Text(dataset.id)),
          DataCell(Text(dataset.name)),
          DataCell(Text(dataset.verboseName)),
          DataCell(Text(dataset.readme)),
        ])
      ).toList(),
    );
  }
}
