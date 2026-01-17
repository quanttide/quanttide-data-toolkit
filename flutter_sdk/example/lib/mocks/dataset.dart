/// 数据集Mock
import 'package:flutter_quanttide_data/flutter_quanttide_data.dart';
import 'package:mocktail/mocktail.dart';

class MockDataSetRepository extends Mock implements DataSetRepository {}

MockDataSetRepository datasetRepository = MockDataSetRepository();

final List<DataSet> datasets = [
  DataSet(id: '1', name: 'university', verboseName: '高校数据集', readme: '高校及其院系信息'),
  DataSet(id: '2', name: 'weibo', verboseName: '微博数据集', readme: '上市公司微博简介'),
];

final DataSet dataset = datasets[0];

final List<Map<String, dynamic>> datasetsJson = [
  {'id': '1', 'name': 'university', 'verboseName': '高校数据集', 'readme': '高校及其院系信息'},
  {'id': '2', 'name': 'weibo', 'verboseName': '微博数据集', 'readme': '上市公司微博简介'},
];

final Map<String, dynamic> datasetJson = datasetsJson[0];
