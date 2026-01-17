import 'package:flutter/material.dart';


class DataSchemaScreen extends StatelessWidget {

  const DataSchemaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('标题'),
      ),
      body: const Column(
        children: <Widget>[
          Text('描述'),
        ],
      ),
    );
  }
}
