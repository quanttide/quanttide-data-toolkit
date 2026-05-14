// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'record.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DataRecordImpl _$$DataRecordImplFromJson(Map<String, dynamic> json) =>
    _$DataRecordImpl(
      id: json['id'] as String,
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => DataRecordItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$DataRecordImplToJson(_$DataRecordImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'items': instance.items,
    };

_$DataRecordItemImpl _$$DataRecordItemImplFromJson(Map<String, dynamic> json) =>
    _$DataRecordItemImpl(
      key: json['key'] as String,
      value: json['value'],
    );

Map<String, dynamic> _$$DataRecordItemImplToJson(
        _$DataRecordItemImpl instance) =>
    <String, dynamic>{
      'key': instance.key,
      'value': instance.value,
    };
