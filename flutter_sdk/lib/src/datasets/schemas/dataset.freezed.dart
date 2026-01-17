// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dataset.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

DataSet _$DataSetFromJson(Map<String, dynamic> json) {
  return _DataSet.fromJson(json);
}

/// @nodoc
mixin _$DataSet {
  /// ID
  String get id => throw _privateConstructorUsedError;

  /// 标识
  String get name => throw _privateConstructorUsedError;

  /// 名称
  String get verboseName => throw _privateConstructorUsedError;

  /// 简介
  String get readme => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DataSetCopyWith<DataSet> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DataSetCopyWith<$Res> {
  factory $DataSetCopyWith(DataSet value, $Res Function(DataSet) then) =
      _$DataSetCopyWithImpl<$Res, DataSet>;
  @useResult
  $Res call({String id, String name, String verboseName, String readme});
}

/// @nodoc
class _$DataSetCopyWithImpl<$Res, $Val extends DataSet>
    implements $DataSetCopyWith<$Res> {
  _$DataSetCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? verboseName = null,
    Object? readme = null,
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
      verboseName: null == verboseName
          ? _value.verboseName
          : verboseName // ignore: cast_nullable_to_non_nullable
              as String,
      readme: null == readme
          ? _value.readme
          : readme // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DataSetImplCopyWith<$Res> implements $DataSetCopyWith<$Res> {
  factory _$$DataSetImplCopyWith(
          _$DataSetImpl value, $Res Function(_$DataSetImpl) then) =
      __$$DataSetImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String name, String verboseName, String readme});
}

/// @nodoc
class __$$DataSetImplCopyWithImpl<$Res>
    extends _$DataSetCopyWithImpl<$Res, _$DataSetImpl>
    implements _$$DataSetImplCopyWith<$Res> {
  __$$DataSetImplCopyWithImpl(
      _$DataSetImpl _value, $Res Function(_$DataSetImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? verboseName = null,
    Object? readme = null,
  }) {
    return _then(_$DataSetImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      verboseName: null == verboseName
          ? _value.verboseName
          : verboseName // ignore: cast_nullable_to_non_nullable
              as String,
      readme: null == readme
          ? _value.readme
          : readme // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DataSetImpl implements _DataSet {
  _$DataSetImpl(
      {required this.id,
      required this.name,
      this.verboseName = '',
      this.readme = ''});

  factory _$DataSetImpl.fromJson(Map<String, dynamic> json) =>
      _$$DataSetImplFromJson(json);

  /// ID
  @override
  final String id;

  /// 标识
  @override
  final String name;

  /// 名称
  @override
  @JsonKey()
  final String verboseName;

  /// 简介
  @override
  @JsonKey()
  final String readme;

  @override
  String toString() {
    return 'DataSet(id: $id, name: $name, verboseName: $verboseName, readme: $readme)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DataSetImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.verboseName, verboseName) ||
                other.verboseName == verboseName) &&
            (identical(other.readme, readme) || other.readme == readme));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, verboseName, readme);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DataSetImplCopyWith<_$DataSetImpl> get copyWith =>
      __$$DataSetImplCopyWithImpl<_$DataSetImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DataSetImplToJson(
      this,
    );
  }
}

abstract class _DataSet implements DataSet {
  factory _DataSet(
      {required final String id,
      required final String name,
      final String verboseName,
      final String readme}) = _$DataSetImpl;

  factory _DataSet.fromJson(Map<String, dynamic> json) = _$DataSetImpl.fromJson;

  @override

  /// ID
  String get id;
  @override

  /// 标识
  String get name;
  @override

  /// 名称
  String get verboseName;
  @override

  /// 简介
  String get readme;
  @override
  @JsonKey(ignore: true)
  _$$DataSetImplCopyWith<_$DataSetImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
