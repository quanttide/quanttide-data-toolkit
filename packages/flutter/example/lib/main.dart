import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_quanttide_data/flutter_quanttide_data.dart';
import 'package:mocktail/mocktail.dart';

import 'mocks/dataset.dart';
import 'screens/dataset_list.dart';
import 'screens/dataset_detail.dart';
import 'screens/schema_detail.dart';


void main() {
  runApp(const ExampleApp());
}


class ExampleApp extends StatelessWidget {
  const ExampleApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // mock
    when(() => datasetRepository.list())
        .thenAnswer((_) async {
          // 模拟延迟，例如 2 秒
          await Future.delayed(const Duration(seconds: 2));
          return datasets;
        });
    // app
    return MaterialApp(
      title: '量潮数据工程',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routes: {
        '/': (context) => BlocProvider(
          create: (context) => DataSetListBloc(repository: datasetRepository)..add(DataSetListing()),
          child: const DataSetListScreen(),
        ),
        '/dataset': (context) => const DataSetDetailScreen(),
        '/schema': (context) => const DataSchemaScreen(),
      }
    );
  }
}
