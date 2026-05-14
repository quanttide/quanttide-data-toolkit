// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'schema.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

DataSchema _$DataSchemaFromJson(Map<String, dynamic> json) {
  return _DataSchema.fromJson(json);
}

/// @nodoc
mixin _$DataSchema {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get verboseName => throw _privateConstructorUsedError;
  String? get readme => throw _privateConstructorUsedError;
  String? get type => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  List<DataSchemaField>? get fields => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DataSchemaCopyWith<DataSchema> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DataSchemaCopyWith<$Res> {
  factory $DataSchemaCopyWith(
          DataSchema value, $Res Function(DataSchema) then) =
      _$DataSchemaCopyWithImpl<$Res, DataSchema>;
  @useResult
  $Res call(
      {String id,
      String name,
      String? verboseName,
      String? readme,
      String? type,
      DateTime? createdAt,
      DateTime? updatedAt,
      List<DataSchemaField>? fields});
}

/// @nodoc
class _$DataSchemaCopyWithImpl<$Res, $Val extends DataSchema>
    implements $DataSchemaCopyWith<$Res> {
  _$DataSchemaCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? verboseName = freezed,
    Object? readme = freezed,
    Object? type = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? fields = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      verboseName: freezed == verboseName
          ? _value.verboseName
          : verboseName // ignore: cast_nullable_to_non_nullable
              as String?,
      readme: freezed == readme
          ? _value.readme
          : readme // ignore: cast_nullable_to_non_nullable
              as String?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      fields: freezed == fields
          ? _value.fields
          : fields // ignore: cast_nullable_to_non_nullable
              as List<DataSchemaField>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DataSchemaImplCopyWith<$Res>
    implements $DataSchemaCopyWith<$Res> {
  factory _$$DataSchemaImplCopyWith(
          _$DataSchemaImpl value, $Res Function(_$DataSchemaImpl) then) =
      __$$DataSchemaImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String? verboseName,
      String? readme,
      String? type,
      DateTime? createdAt,
      DateTime? updatedAt,
      List<DataSchemaField>? fields});
}

/// @nodoc
class __$$DataSchemaImplCopyWithImpl<$Res>
    extends _$DataSchemaCopyWithImpl<$Res, _$DataSchemaImpl>
    implements _$$DataSchemaImplCopyWith<$Res> {
  __$$DataSchemaImplCopyWithImpl(
      _$DataSchemaImpl _value, $Res Function(_$DataSchemaImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? verboseName = freezed,
    Object? readme = freezed,
    Object? type = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? fields = freezed,
  }) {
    return _then(_$DataSchemaImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      verboseName: freezed == verboseName
          ? _value.verboseName
          : verboseName // ignore: cast_nullable_to_non_nullable
              as String?,
      readme: freezed == readme
          ? _value.readme
          : readme // ignore: cast_nullable_to_non_nullable
              as String?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      fields: freezed == fields
          ? _value._fields
          : fields // ignore: cast_nullable_to_non_nullable
              as List<DataSchemaField>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DataSchemaImpl implements _DataSchema {
  const _$DataSchemaImpl(
      {required this.id,
      required this.name,
      this.verboseName = '',
      this.readme = '',
      this.type,
      this.createdAt,
      this.updatedAt,
      final List<DataSchemaField>? fields})
      : _fields = fields;

  factory _$DataSchemaImpl.fromJson(Map<String, dynamic> json) =>
      _$$DataSchemaImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  @JsonKey()
  final String? verboseName;
  @override
  @JsonKey()
  final String? readme;
  @override
  final String? type;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;
  final List<DataSchemaField>? _fields;
  @override
  List<DataSchemaField>? get fields {
    final value = _fields;
    if (value == null) return null;
    if (_fields is EqualUnmodifiableListView) return _fields;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'DataSchema(id: $id, name: $name, verboseName: $verboseName, readme: $readme, type: $type, createdAt: $createdAt, updatedAt: $updatedAt, fields: $fields)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DataSchemaImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.verboseName, verboseName) ||
                other.verboseName == verboseName) &&
            (identical(other.readme, readme) || other.readme == readme) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            const DeepCollectionEquality().equals(other._fields, _fields));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, verboseName, readme,
      type, createdAt, updatedAt, const DeepCollectionEquality().hash(_fields));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DataSchemaImplCopyWith<_$DataSchemaImpl> get copyWith =>
      __$$DataSchemaImplCopyWithImpl<_$DataSchemaImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DataSchemaImplToJson(
      this,
    );
  }
}

abstract class _DataSchema implements DataSchema {
  const factory _DataSchema(
      {required final String id,
      required final String name,
      final String? verboseName,
      final String? readme,
      final String? type,
      final DateTime? createdAt,
      final DateTime? updatedAt,
      final List<DataSchemaField>? fields}) = _$DataSchemaImpl;

  factory _DataSchema.fromJson(Map<String, dynamic> json) =
      _$DataSchemaImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String? get verboseName;
  @override
  String? get readme;
  @override
  String? get type;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;
  @override
  List<DataSchemaField>? get fields;
  @override
  @JsonKey(ignore: true)
  _$$DataSchemaImplCopyWith<_$DataSchemaImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

DataSchemaField _$DataSchemaFieldFromJson(Map<String, dynamic> json) {
  return _DataSchemaField.fromJson(json);
}

/// @nodoc
mixin _$DataSchemaField {
  String get name => throw _privateConstructorUsedError;
  String? get verboseName => throw _privateConstructorUsedError;
  String? get type => throw _privateConstructorUsedError;
  String? get defaultValue => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DataSchemaFieldCopyWith<DataSchemaField> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DataSchemaFieldCopyWith<$Res> {
  factory $DataSchemaFieldCopyWith(
          DataSchemaField value, $Res Function(DataSchemaField) then) =
      _$DataSchemaFieldCopyWithImpl<$Res, DataSchemaField>;
  @useResult
  $Res call(
      {String name, String? verboseName, String? type, String? defaultValue});
}

/// @nodoc
class _$DataSchemaFieldCopyWithImpl<$Res, $Val extends DataSchemaField>
    implements $DataSchemaFieldCopyWith<$Res> {
  _$DataSchemaFieldCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? verboseName = freezed,
    Object? type = freezed,
    Object? defaultValue = freezed,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      verboseName: freezed == verboseName
          ? _value.verboseName
          : verboseName // ignore: cast_nullable_to_non_nullable
              as String?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      defaultValue: freezed == defaultValue
          ? _value.defaultValue
          : defaultValue // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DataSchemaFieldImplCopyWith<$Res>
    implements $DataSchemaFieldCopyWith<$Res> {
  factory _$$DataSchemaFieldImplCopyWith(_$DataSchemaFieldImpl value,
          $Res Function(_$DataSchemaFieldImpl) then) =
      __$$DataSchemaFieldImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name, String? verboseName, String? type, String? defaultValue});
}

/// @nodoc
class __$$DataSchemaFieldImplCopyWithImpl<$Res>
    extends _$DataSchemaFieldCopyWithImpl<$Res, _$DataSchemaFieldImpl>
    implements _$$DataSchemaFieldImplCopyWith<$Res> {
  __$$DataSchemaFieldImplCopyWithImpl(
      _$DataSchemaFieldImpl _value, $Res Function(_$DataSchemaFieldImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? verboseName = freezed,
    Object? type = freezed,
    Object? defaultValue = freezed,
  }) {
    return _then(_$DataSchemaFieldImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      verboseName: freezed == verboseName
          ? _value.verboseName
          : verboseName // ignore: cast_nullable_to_non_nullable
              as String?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      defaultValue: freezed == defaultValue
          ? _value.defaultValue
          : defaultValue // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DataSchemaFieldImpl implements _DataSchemaField {
  const _$DataSchemaFieldImpl(
      {required this.name, this.verboseName, this.type, this.defaultValue});

  factory _$DataSchemaFieldImpl.fromJson(Map<String, dynamic> json) =>
      _$$DataSchemaFieldImplFromJson(json);

  @override
  final String name;
  @override
  final String? verboseName;
  @override
  final String? type;
  @override
  final String? defaultValue;

  @override
  String toString() {
    return 'DataSchemaField(name: $name, verboseName: $verboseName, type: $type, defaultValue: $defaultValue)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DataSchemaFieldImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.verboseName, verboseName) ||
                other.verboseName == verboseName) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.defaultValue, defaultValue) ||
                other.defaultValue == defaultValue));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, name, verboseName, type, defaultValue);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DataSchemaFieldImplCopyWith<_$DataSchemaFieldImpl> get copyWith =>
      __$$DataSchemaFieldImplCopyWithImpl<_$DataSchemaFieldImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DataSchemaFieldImplToJson(
      this,
    );
  }
}

abstract class _DataSchemaField implements DataSchemaField {
  const factory _DataSchemaField(
      {required final String name,
      final String? verboseName,
      final String? type,
      final String? defaultValue}) = _$DataSchemaFieldImpl;

  factory _DataSchemaField.fromJson(Map<String, dynamic> json) =
      _$DataSchemaFieldImpl.fromJson;

  @override
  String get name;
  @override
  String? get verboseName;
  @override
  String? get type;
  @override
  String? get defaultValue;
  @override
  @JsonKey(ignore: true)
  _$$DataSchemaFieldImplCopyWith<_$DataSchemaFieldImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
