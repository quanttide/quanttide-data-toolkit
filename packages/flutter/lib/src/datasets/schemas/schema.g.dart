// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schema.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DataSchemaImpl _$$DataSchemaImplFromJson(Map<String, dynamic> json) =>
    _$DataSchemaImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      verboseName: json['verboseName'] as String? ?? '',
      readme: json['readme'] as String? ?? '',
      type: json['type'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      fields: (json['fields'] as List<dynamic>?)
          ?.map((e) => DataSchemaField.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$DataSchemaImplToJson(_$DataSchemaImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'verboseName': instance.verboseName,
      'readme': instance.readme,
      'type': instance.type,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'fields': instance.fields,
    };

_$DataSchemaFieldImpl _$$DataSchemaFieldImplFromJson(
        Map<String, dynamic> json) =>
    _$DataSchemaFieldImpl(
      name: json['name'] as String,
      verboseName: json['verboseName'] as String?,
      type: json['type'] as String?,
      defaultValue: json['defaultValue'] as String?,
    );

Map<String, dynamic> _$$DataSchemaFieldImplToJson(
        _$DataSchemaFieldImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'verboseName': instance.verboseName,
      'type': instance.type,
      'defaultValue': instance.defaultValue,
    };
