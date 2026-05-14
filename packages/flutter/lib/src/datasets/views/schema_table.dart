import 'package:flutter/material.dart';
import 'package:data_table_2/data_table_2.dart';

import '../schemas/schema.dart';


class DataSchemaTableView extends StatelessWidget {
  final List<DataSchema> dataSchemaList;

  const DataSchemaTableView({super.key, required this.dataSchemaList});

  @override
  Widget build(BuildContext context) {
    return DataTable2(
      columns: const [
        DataColumn(label: Text('标识')),
        DataColumn(label: Text('名称')),
      ],
      rows: dataSchemaList.map((dataSchema) {
        return DataRow(cells: [
          DataCell(Text(dataSchema.name)),
          DataCell(Text(dataSchema.verboseName!)),
        ]);
      }).toList(),
    );
  }
}
