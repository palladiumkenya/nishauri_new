// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'care_giver.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

CareGiver _$CareGiverFromJson(Map<String, dynamic> json) {
  return _CareGiver.fromJson(json);
}

/// @nodoc
mixin _$CareGiver {
  String get name => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CareGiverCopyWith<CareGiver> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CareGiverCopyWith<$Res> {
  factory $CareGiverCopyWith(CareGiver value, $Res Function(CareGiver) then) =
      _$CareGiverCopyWithImpl<$Res, CareGiver>;
  @useResult
  $Res call({String name});
}

/// @nodoc
class _$CareGiverCopyWithImpl<$Res, $Val extends CareGiver>
    implements $CareGiverCopyWith<$Res> {
  _$CareGiverCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CareGiverImplCopyWith<$Res>
    implements $CareGiverCopyWith<$Res> {
  factory _$$CareGiverImplCopyWith(
          _$CareGiverImpl value, $Res Function(_$CareGiverImpl) then) =
      __$$CareGiverImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name});
}

/// @nodoc
class __$$CareGiverImplCopyWithImpl<$Res>
    extends _$CareGiverCopyWithImpl<$Res, _$CareGiverImpl>
    implements _$$CareGiverImplCopyWith<$Res> {
  __$$CareGiverImplCopyWithImpl(
      _$CareGiverImpl _value, $Res Function(_$CareGiverImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
  }) {
    return _then(_$CareGiverImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CareGiverImpl implements _CareGiver {
  const _$CareGiverImpl({required this.name});

  factory _$CareGiverImpl.fromJson(Map<String, dynamic> json) =>
      _$$CareGiverImplFromJson(json);

  @override
  final String name;

  @override
  String toString() {
    return 'CareGiver(name: $name)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CareGiverImpl &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, name);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CareGiverImplCopyWith<_$CareGiverImpl> get copyWith =>
      __$$CareGiverImplCopyWithImpl<_$CareGiverImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CareGiverImplToJson(
      this,
    );
  }
}

abstract class _CareGiver implements CareGiver {
  const factory _CareGiver({required final String name}) = _$CareGiverImpl;

  factory _CareGiver.fromJson(Map<String, dynamic> json) =
      _$CareGiverImpl.fromJson;

  @override
  String get name;
  @override
  @JsonKey(ignore: true)
  _$$CareGiverImplCopyWith<_$CareGiverImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
