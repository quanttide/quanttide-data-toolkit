// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'record.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

DataRecord _$DataRecordFromJson(Map<String, dynamic> json) {
  return _DataRecord.fromJson(json);
}

/// @nodoc
mixin _$DataRecord {
  String get id => throw _privateConstructorUsedError;
  List<DataRecordItem>? get items => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DataRecordCopyWith<DataRecord> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DataRecordCopyWith<$Res> {
  factory $DataRecordCopyWith(
          DataRecord value, $Res Function(DataRecord) then) =
      _$DataRecordCopyWithImpl<$Res, DataRecord>;
  @useResult
  $Res call({String id, List<DataRecordItem>? items});
}

/// @nodoc
class _$DataRecordCopyWithImpl<$Res, $Val extends DataRecord>
    implements $DataRecordCopyWith<$Res> {
  _$DataRecordCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? items = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      items: freezed == items
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<DataRecordItem>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DataRecordImplCopyWith<$Res>
    implements $DataRecordCopyWith<$Res> {
  factory _$$DataRecordImplCopyWith(
          _$DataRecordImpl value, $Res Function(_$DataRecordImpl) then) =
      __$$DataRecordImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, List<DataRecordItem>? items});
}

/// @nodoc
class __$$DataRecordImplCopyWithImpl<$Res>
    extends _$DataRecordCopyWithImpl<$Res, _$DataRecordImpl>
    implements _$$DataRecordImplCopyWith<$Res> {
  __$$DataRecordImplCopyWithImpl(
      _$DataRecordImpl _value, $Res Function(_$DataRecordImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? items = freezed,
  }) {
    return _then(_$DataRecordImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      items: freezed == items
          ? _value._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<DataRecordItem>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DataRecordImpl implements _DataRecord {
  _$DataRecordImpl({required this.id, final List<DataRecordItem>? items})
      : _items = items;

  factory _$DataRecordImpl.fromJson(Map<String, dynamic> json) =>
      _$$DataRecordImplFromJson(json);

  @override
  final String id;
  final List<DataRecordItem>? _items;
  @override
  List<DataRecordItem>? get items {
    final value = _items;
    if (value == null) return null;
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'DataRecord(id: $id, items: $items)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DataRecordImpl &&
            (identical(other.id, id) || other.id == id) &&
            const DeepCollectionEquality().equals(other._items, _items));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, const DeepCollectionEquality().hash(_items));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DataRecordImplCopyWith<_$DataRecordImpl> get copyWith =>
      __$$DataRecordImplCopyWithImpl<_$DataRecordImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DataRecordImplToJson(
      this,
    );
  }
}

abstract class _DataRecord implements DataRecord {
  factory _DataRecord(
      {required final String id,
      final List<DataRecordItem>? items}) = _$DataRecordImpl;

  factory _DataRecord.fromJson(Map<String, dynamic> json) =
      _$DataRecordImpl.fromJson;

  @override
  String get id;
  @override
  List<DataRecordItem>? get items;
  @override
  @JsonKey(ignore: true)
  _$$DataRecordImplCopyWith<_$DataRecordImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

DataRecordItem _$DataRecordItemFromJson(Map<String, dynamic> json) {
  return _DataRecordItem.fromJson(json);
}

/// @nodoc
mixin _$DataRecordItem {
  String get key => throw _privateConstructorUsedError;
  dynamic get value => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DataRecordItemCopyWith<DataRecordItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DataRecordItemCopyWith<$Res> {
  factory $DataRecordItemCopyWith(
          DataRecordItem value, $Res Function(DataRecordItem) then) =
      _$DataRecordItemCopyWithImpl<$Res, DataRecordItem>;
  @useResult
  $Res call({String key, dynamic value});
}

/// @nodoc
class _$DataRecordItemCopyWithImpl<$Res, $Val extends DataRecordItem>
    implements $DataRecordItemCopyWith<$Res> {
  _$DataRecordItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? key = null,
    Object? value = freezed,
  }) {
    return _then(_value.copyWith(
      key: null == key
          ? _value.key
          : key // ignore: cast_nullable_to_non_nullable
              as String,
      value: freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DataRecordItemImplCopyWith<$Res>
    implements $DataRecordItemCopyWith<$Res> {
  factory _$$DataRecordItemImplCopyWith(_$DataRecordItemImpl value,
          $Res Function(_$DataRecordItemImpl) then) =
      __$$DataRecordItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String key, dynamic value});
}

/// @nodoc
class __$$DataRecordItemImplCopyWithImpl<$Res>
    extends _$DataRecordItemCopyWithImpl<$Res, _$DataRecordItemImpl>
    implements _$$DataRecordItemImplCopyWith<$Res> {
  __$$DataRecordItemImplCopyWithImpl(
      _$DataRecordItemImpl _value, $Res Function(_$DataRecordItemImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? key = null,
    Object? value = freezed,
  }) {
    return _then(_$DataRecordItemImpl(
      key: null == key
          ? _value.key
          : key // ignore: cast_nullable_to_non_nullable
              as String,
      value: freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DataRecordItemImpl implements _DataRecordItem {
  _$DataRecordItemImpl({required this.key, required this.value});

  factory _$DataRecordItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$DataRecordItemImplFromJson(json);

  @override
  final String key;
  @override
  final dynamic value;

  @override
  String toString() {
    return 'DataRecordItem(key: $key, value: $value)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DataRecordItemImpl &&
            (identical(other.key, key) || other.key == key) &&
            const DeepCollectionEquality().equals(other.value, value));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, key, const DeepCollectionEquality().hash(value));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DataRecordItemImplCopyWith<_$DataRecordItemImpl> get copyWith =>
      __$$DataRecordItemImplCopyWithImpl<_$DataRecordItemImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DataRecordItemImplToJson(
      this,
    );
  }
}

abstract class _DataRecordItem implements DataRecordItem {
  factory _DataRecordItem(
      {required final String key,
      required final dynamic value}) = _$DataRecordItemImpl;

  factory _DataRecordItem.fromJson(Map<String, dynamic> json) =
      _$DataRecordItemImpl.fromJson;

  @override
  String get key;
  @override
  dynamic get value;
  @override
  @JsonKey(ignore: true)
  _$$DataRecordItemImplCopyWith<_$DataRecordItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
