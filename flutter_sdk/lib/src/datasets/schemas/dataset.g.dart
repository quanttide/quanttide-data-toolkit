// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dataset.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DataSetImpl _$$DataSetImplFromJson(Map<String, dynamic> json) =>
    _$DataSetImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      verboseName: json['verboseName'] as String? ?? '',
      readme: json['readme'] as String? ?? '',
    );

Map<String, dynamic> _$$DataSetImplToJson(_$DataSetImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'verboseName': instance.verboseName,
      'readme': instance.readme,
    };
