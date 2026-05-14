/// 数据集

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'dataset.freezed.dart';
part 'dataset.g.dart';

/// 数据集
@freezed
class DataSet with _$DataSet {
  factory DataSet({
    /// ID
    required String id,
    /// 标识
    required String name,
    /// 名称
    @Default('') String verboseName,
    /// 简介
    @Default('') String readme,
  }) = _DataSet;

  factory DataSet.fromJson(Map<String, dynamic> json) => _$DataSetFromJson(json);
}
