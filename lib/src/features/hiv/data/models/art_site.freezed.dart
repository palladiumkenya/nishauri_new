// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'art_site.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ARTSite _$ARTSiteFromJson(Map<String, dynamic> json) {
  return _ARTSite.fromJson(json);
}

/// @nodoc
mixin _$ARTSite {
  String get mflCode => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get type => throw _privateConstructorUsedError;
  String? get telephone => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ARTSiteCopyWith<ARTSite> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ARTSiteCopyWith<$Res> {
  factory $ARTSiteCopyWith(ARTSite value, $Res Function(ARTSite) then) =
      _$ARTSiteCopyWithImpl<$Res, ARTSite>;
  @useResult
  $Res call({String mflCode, String name, String? type, String? telephone});
}

/// @nodoc
class _$ARTSiteCopyWithImpl<$Res, $Val extends ARTSite>
    implements $ARTSiteCopyWith<$Res> {
  _$ARTSiteCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? mflCode = null,
    Object? name = null,
    Object? type = freezed,
    Object? telephone = freezed,
  }) {
    return _then(_value.copyWith(
      mflCode: null == mflCode
          ? _value.mflCode
          : mflCode // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      telephone: freezed == telephone
          ? _value.telephone
          : telephone // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ARTSiteImplCopyWith<$Res> implements $ARTSiteCopyWith<$Res> {
  factory _$$ARTSiteImplCopyWith(
          _$ARTSiteImpl value, $Res Function(_$ARTSiteImpl) then) =
      __$$ARTSiteImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String mflCode, String name, String? type, String? telephone});
}

/// @nodoc
class __$$ARTSiteImplCopyWithImpl<$Res>
    extends _$ARTSiteCopyWithImpl<$Res, _$ARTSiteImpl>
    implements _$$ARTSiteImplCopyWith<$Res> {
  __$$ARTSiteImplCopyWithImpl(
      _$ARTSiteImpl _value, $Res Function(_$ARTSiteImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? mflCode = null,
    Object? name = null,
    Object? type = freezed,
    Object? telephone = freezed,
  }) {
    return _then(_$ARTSiteImpl(
      mflCode: null == mflCode
          ? _value.mflCode
          : mflCode // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      telephone: freezed == telephone
          ? _value.telephone
          : telephone // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ARTSiteImpl with DiagnosticableTreeMixin implements _ARTSite {
  const _$ARTSiteImpl(
      {required this.mflCode, required this.name, this.type, this.telephone});

  factory _$ARTSiteImpl.fromJson(Map<String, dynamic> json) =>
      _$$ARTSiteImplFromJson(json);

  @override
  final String mflCode;
  @override
  final String name;
  @override
  final String? type;
  @override
  final String? telephone;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ARTSite(mflCode: $mflCode, name: $name, type: $type, telephone: $telephone)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ARTSite'))
      ..add(DiagnosticsProperty('mflCode', mflCode))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('type', type))
      ..add(DiagnosticsProperty('telephone', telephone));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ARTSiteImpl &&
            (identical(other.mflCode, mflCode) || other.mflCode == mflCode) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.telephone, telephone) ||
                other.telephone == telephone));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, mflCode, name, type, telephone);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ARTSiteImplCopyWith<_$ARTSiteImpl> get copyWith =>
      __$$ARTSiteImplCopyWithImpl<_$ARTSiteImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ARTSiteImplToJson(
      this,
    );
  }
}

abstract class _ARTSite implements ARTSite {
  const factory _ARTSite(
      {required final String mflCode,
      required final String name,
      final String? type,
      final String? telephone}) = _$ARTSiteImpl;

  factory _ARTSite.fromJson(Map<String, dynamic> json) = _$ARTSiteImpl.fromJson;

  @override
  String get mflCode;
  @override
  String get name;
  @override
  String? get type;
  @override
  String? get telephone;
  @override
  @JsonKey(ignore: true)
  _$$ARTSiteImplCopyWith<_$ARTSiteImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
