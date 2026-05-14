import 'package:quanttide_data/quanttide_data.dart';

abstract class DatasetRepository {
  Future<Dataset> fetch(String id);
}
