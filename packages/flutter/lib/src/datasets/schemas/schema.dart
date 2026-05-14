/// 数据模型

import 'package:freezed_annotation/freezed_annotation.dart';

part 'schema.freezed.dart';
part 'schema.g.dart';


/// 数据模型
@freezed
class DataSchema with _$DataSchema {
  const factory DataSchema({
    required String id,
    required String name,
    @Default('') String? verboseName,
    @Default('') String? readme,
    String? type,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<DataSchemaField>? fields
  }) = _DataSchema;

  factory DataSchema.fromJson(Map<String,dynamic> json) =>
      _$DataSchemaFromJson(json);
}


/// 数据模型字段
@freezed
class DataSchemaField with _$DataSchemaField{
  const factory DataSchemaField({
    required String name,
    String? verboseName,
    String? type,
    String? defaultValue,
  }) = _DataSchemaField;

  factory DataSchemaField.fromJson(Map<String, dynamic> json) =>
      _$DataSchemaFieldFromJson(json);
}
