import 'package:quanttide_data/quanttide_data.dart';

abstract class PipelineRepository {
  Future<Pipeline> fetch(String id);
}
