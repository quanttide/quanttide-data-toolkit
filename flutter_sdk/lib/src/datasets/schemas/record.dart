/// 数据记录

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'record.freezed.dart';
part 'record.g.dart';


@freezed
class DataRecord with _$DataRecord {
  factory DataRecord({
    required String id,
    List<DataRecordItem>? items,
    // Add other fields as needed
  }) = _DataRecord;

  factory DataRecord.fromJson(Map<String, dynamic> json) => _$DataRecordFromJson(json);
}


@freezed
class DataRecordItem with _$DataRecordItem {
  factory DataRecordItem({
    required String key,
    required dynamic value,
    // Add other fields as needed
  }) = _DataRecordItem;

  factory DataRecordItem.fromJson(Map<String, dynamic> json) => _$DataRecordItemFromJson(json);
}