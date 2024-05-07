// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'art_regimen.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ARTRegimen _$ARTRegimenFromJson(Map<String, dynamic> json) {
  return _ARTRegimen.fromJson(json);
}

/// @nodoc
mixin _$ARTRegimen {
  String? get id => throw _privateConstructorUsedError;
  String get regimen => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String? get ccc_no => throw _privateConstructorUsedError;
  bool get isCurrent => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ARTRegimenCopyWith<ARTRegimen> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ARTRegimenCopyWith<$Res> {
  factory $ARTRegimenCopyWith(
          ARTRegimen value, $Res Function(ARTRegimen) then) =
      _$ARTRegimenCopyWithImpl<$Res, ARTRegimen>;
  @useResult
  $Res call(
      {String? id,
      String regimen,
      String? description,
      String? ccc_no,
      bool isCurrent});
}

/// @nodoc
class _$ARTRegimenCopyWithImpl<$Res, $Val extends ARTRegimen>
    implements $ARTRegimenCopyWith<$Res> {
  _$ARTRegimenCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? regimen = null,
    Object? description = freezed,
    Object? ccc_no = freezed,
    Object? isCurrent = null,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      regimen: null == regimen
          ? _value.regimen
          : regimen // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      ccc_no: freezed == ccc_no
          ? _value.ccc_no
          : ccc_no // ignore: cast_nullable_to_non_nullable
              as String?,
      isCurrent: null == isCurrent
          ? _value.isCurrent
          : isCurrent // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ARTRegimenImplCopyWith<$Res>
    implements $ARTRegimenCopyWith<$Res> {
  factory _$$ARTRegimenImplCopyWith(
          _$ARTRegimenImpl value, $Res Function(_$ARTRegimenImpl) then) =
      __$$ARTRegimenImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      String regimen,
      String? description,
      String? ccc_no,
      bool isCurrent});
}

/// @nodoc
class __$$ARTRegimenImplCopyWithImpl<$Res>
    extends _$ARTRegimenCopyWithImpl<$Res, _$ARTRegimenImpl>
    implements _$$ARTRegimenImplCopyWith<$Res> {
  __$$ARTRegimenImplCopyWithImpl(
      _$ARTRegimenImpl _value, $Res Function(_$ARTRegimenImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? regimen = null,
    Object? description = freezed,
    Object? ccc_no = freezed,
    Object? isCurrent = null,
  }) {
    return _then(_$ARTRegimenImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      regimen: null == regimen
          ? _value.regimen
          : regimen // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      ccc_no: freezed == ccc_no
          ? _value.ccc_no
          : ccc_no // ignore: cast_nullable_to_non_nullable
              as String?,
      isCurrent: null == isCurrent
          ? _value.isCurrent
          : isCurrent // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ARTRegimenImpl with DiagnosticableTreeMixin implements _ARTRegimen {
  const _$ARTRegimenImpl(
      {this.id,
      required this.regimen,
      this.description,
      this.ccc_no,
      this.isCurrent = false});

  factory _$ARTRegimenImpl.fromJson(Map<String, dynamic> json) =>
      _$$ARTRegimenImplFromJson(json);

  @override
  final String? id;
  @override
  final String regimen;
  @override
  final String? description;
  @override
  final String? ccc_no;
  @override
  @JsonKey()
  final bool isCurrent;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ARTRegimen(id: $id, regimen: $regimen, description: $description, ccc_no: $ccc_no, isCurrent: $isCurrent)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ARTRegimen'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('regimen', regimen))
      ..add(DiagnosticsProperty('description', description))
      ..add(DiagnosticsProperty('ccc_no', ccc_no))
      ..add(DiagnosticsProperty('isCurrent', isCurrent));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ARTRegimenImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.regimen, regimen) || other.regimen == regimen) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.ccc_no, ccc_no) || other.ccc_no == ccc_no) &&
            (identical(other.isCurrent, isCurrent) ||
                other.isCurrent == isCurrent));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, regimen, description, ccc_no, isCurrent);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ARTRegimenImplCopyWith<_$ARTRegimenImpl> get copyWith =>
      __$$ARTRegimenImplCopyWithImpl<_$ARTRegimenImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ARTRegimenImplToJson(
      this,
    );
  }
}

abstract class _ARTRegimen implements ARTRegimen {
  const factory _ARTRegimen(
      {final String? id,
      required final String regimen,
      final String? description,
      final String? ccc_no,
      final bool isCurrent}) = _$ARTRegimenImpl;

  factory _ARTRegimen.fromJson(Map<String, dynamic> json) =
      _$ARTRegimenImpl.fromJson;

  @override
  String? get id;
  @override
  String get regimen;
  @override
  String? get description;
  @override
  String? get ccc_no;
  @override
  bool get isCurrent;
  @override
  @JsonKey(ignore: true)
  _$$ARTRegimenImplCopyWith<_$ARTRegimenImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
