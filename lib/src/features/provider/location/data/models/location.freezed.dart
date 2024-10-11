// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'location.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Location _$LocationFromJson(Map<String, dynamic> json) {
  return _Location.fromJson(json);
}

/// @nodoc
mixin _$Location {
  int? get county_id => throw _privateConstructorUsedError;
  int? get sub_county_id => throw _privateConstructorUsedError;
  String? get sub_county_name => throw _privateConstructorUsedError;
  String? get county_name => throw _privateConstructorUsedError;
  String? get facility_name => throw _privateConstructorUsedError;
  int? get mfl_code => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LocationCopyWith<Location> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LocationCopyWith<$Res> {
  factory $LocationCopyWith(Location value, $Res Function(Location) then) =
      _$LocationCopyWithImpl<$Res, Location>;
  @useResult
  $Res call(
      {int? county_id,
      int? sub_county_id,
      String? sub_county_name,
      String? county_name,
      String? facility_name,
      int? mfl_code});
}

/// @nodoc
class _$LocationCopyWithImpl<$Res, $Val extends Location>
    implements $LocationCopyWith<$Res> {
  _$LocationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? county_id = freezed,
    Object? sub_county_id = freezed,
    Object? sub_county_name = freezed,
    Object? county_name = freezed,
    Object? facility_name = freezed,
    Object? mfl_code = freezed,
  }) {
    return _then(_value.copyWith(
      county_id: freezed == county_id
          ? _value.county_id
          : county_id // ignore: cast_nullable_to_non_nullable
              as int?,
      sub_county_id: freezed == sub_county_id
          ? _value.sub_county_id
          : sub_county_id // ignore: cast_nullable_to_non_nullable
              as int?,
      sub_county_name: freezed == sub_county_name
          ? _value.sub_county_name
          : sub_county_name // ignore: cast_nullable_to_non_nullable
              as String?,
      county_name: freezed == county_name
          ? _value.county_name
          : county_name // ignore: cast_nullable_to_non_nullable
              as String?,
      facility_name: freezed == facility_name
          ? _value.facility_name
          : facility_name // ignore: cast_nullable_to_non_nullable
              as String?,
      mfl_code: freezed == mfl_code
          ? _value.mfl_code
          : mfl_code // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LocationImplCopyWith<$Res>
    implements $LocationCopyWith<$Res> {
  factory _$$LocationImplCopyWith(
          _$LocationImpl value, $Res Function(_$LocationImpl) then) =
      __$$LocationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? county_id,
      int? sub_county_id,
      String? sub_county_name,
      String? county_name,
      String? facility_name,
      int? mfl_code});
}

/// @nodoc
class __$$LocationImplCopyWithImpl<$Res>
    extends _$LocationCopyWithImpl<$Res, _$LocationImpl>
    implements _$$LocationImplCopyWith<$Res> {
  __$$LocationImplCopyWithImpl(
      _$LocationImpl _value, $Res Function(_$LocationImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? county_id = freezed,
    Object? sub_county_id = freezed,
    Object? sub_county_name = freezed,
    Object? county_name = freezed,
    Object? facility_name = freezed,
    Object? mfl_code = freezed,
  }) {
    return _then(_$LocationImpl(
      county_id: freezed == county_id
          ? _value.county_id
          : county_id // ignore: cast_nullable_to_non_nullable
              as int?,
      sub_county_id: freezed == sub_county_id
          ? _value.sub_county_id
          : sub_county_id // ignore: cast_nullable_to_non_nullable
              as int?,
      sub_county_name: freezed == sub_county_name
          ? _value.sub_county_name
          : sub_county_name // ignore: cast_nullable_to_non_nullable
              as String?,
      county_name: freezed == county_name
          ? _value.county_name
          : county_name // ignore: cast_nullable_to_non_nullable
              as String?,
      facility_name: freezed == facility_name
          ? _value.facility_name
          : facility_name // ignore: cast_nullable_to_non_nullable
              as String?,
      mfl_code: freezed == mfl_code
          ? _value.mfl_code
          : mfl_code // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LocationImpl implements _Location {
  const _$LocationImpl(
      {this.county_id,
      this.sub_county_id,
      this.sub_county_name,
      this.county_name,
      this.facility_name,
      this.mfl_code});

  factory _$LocationImpl.fromJson(Map<String, dynamic> json) =>
      _$$LocationImplFromJson(json);

  @override
  final int? county_id;
  @override
  final int? sub_county_id;
  @override
  final String? sub_county_name;
  @override
  final String? county_name;
  @override
  final String? facility_name;
  @override
  final int? mfl_code;

  @override
  String toString() {
    return 'Location(county_id: $county_id, sub_county_id: $sub_county_id, sub_county_name: $sub_county_name, county_name: $county_name, facility_name: $facility_name, mfl_code: $mfl_code)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LocationImpl &&
            (identical(other.county_id, county_id) ||
                other.county_id == county_id) &&
            (identical(other.sub_county_id, sub_county_id) ||
                other.sub_county_id == sub_county_id) &&
            (identical(other.sub_county_name, sub_county_name) ||
                other.sub_county_name == sub_county_name) &&
            (identical(other.county_name, county_name) ||
                other.county_name == county_name) &&
            (identical(other.facility_name, facility_name) ||
                other.facility_name == facility_name) &&
            (identical(other.mfl_code, mfl_code) ||
                other.mfl_code == mfl_code));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, county_id, sub_county_id,
      sub_county_name, county_name, facility_name, mfl_code);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LocationImplCopyWith<_$LocationImpl> get copyWith =>
      __$$LocationImplCopyWithImpl<_$LocationImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LocationImplToJson(
      this,
    );
  }
}

abstract class _Location implements Location {
  const factory _Location(
      {final int? county_id,
      final int? sub_county_id,
      final String? sub_county_name,
      final String? county_name,
      final String? facility_name,
      final int? mfl_code}) = _$LocationImpl;

  factory _Location.fromJson(Map<String, dynamic> json) =
      _$LocationImpl.fromJson;

  @override
  int? get county_id;
  @override
  int? get sub_county_id;
  @override
  String? get sub_county_name;
  @override
  String? get county_name;
  @override
  String? get facility_name;
  @override
  int? get mfl_code;
  @override
  @JsonKey(ignore: true)
  _$$LocationImplCopyWith<_$LocationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
