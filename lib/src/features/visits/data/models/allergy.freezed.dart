// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'allergy.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Allergy _$AllergyFromJson(Map<String, dynamic> json) {
  return _Allergy.fromJson(json);
}

/// @nodoc
mixin _$Allergy {
  String get uuid => throw _privateConstructorUsedError;
  String get allergen => throw _privateConstructorUsedError;
  String get reaction => throw _privateConstructorUsedError;
  String? get onsetDate => throw _privateConstructorUsedError;
  String get dateRecorded => throw _privateConstructorUsedError;
  String get severity => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AllergyCopyWith<Allergy> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AllergyCopyWith<$Res> {
  factory $AllergyCopyWith(Allergy value, $Res Function(Allergy) then) =
      _$AllergyCopyWithImpl<$Res, Allergy>;
  @useResult
  $Res call(
      {String uuid,
      String allergen,
      String reaction,
      String? onsetDate,
      String dateRecorded,
      String severity});
}

/// @nodoc
class _$AllergyCopyWithImpl<$Res, $Val extends Allergy>
    implements $AllergyCopyWith<$Res> {
  _$AllergyCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uuid = null,
    Object? allergen = null,
    Object? reaction = null,
    Object? onsetDate = freezed,
    Object? dateRecorded = null,
    Object? severity = null,
  }) {
    return _then(_value.copyWith(
      uuid: null == uuid
          ? _value.uuid
          : uuid // ignore: cast_nullable_to_non_nullable
              as String,
      allergen: null == allergen
          ? _value.allergen
          : allergen // ignore: cast_nullable_to_non_nullable
              as String,
      reaction: null == reaction
          ? _value.reaction
          : reaction // ignore: cast_nullable_to_non_nullable
              as String,
      onsetDate: freezed == onsetDate
          ? _value.onsetDate
          : onsetDate // ignore: cast_nullable_to_non_nullable
              as String?,
      dateRecorded: null == dateRecorded
          ? _value.dateRecorded
          : dateRecorded // ignore: cast_nullable_to_non_nullable
              as String,
      severity: null == severity
          ? _value.severity
          : severity // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AllergyImplCopyWith<$Res> implements $AllergyCopyWith<$Res> {
  factory _$$AllergyImplCopyWith(
          _$AllergyImpl value, $Res Function(_$AllergyImpl) then) =
      __$$AllergyImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String uuid,
      String allergen,
      String reaction,
      String? onsetDate,
      String dateRecorded,
      String severity});
}

/// @nodoc
class __$$AllergyImplCopyWithImpl<$Res>
    extends _$AllergyCopyWithImpl<$Res, _$AllergyImpl>
    implements _$$AllergyImplCopyWith<$Res> {
  __$$AllergyImplCopyWithImpl(
      _$AllergyImpl _value, $Res Function(_$AllergyImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uuid = null,
    Object? allergen = null,
    Object? reaction = null,
    Object? onsetDate = freezed,
    Object? dateRecorded = null,
    Object? severity = null,
  }) {
    return _then(_$AllergyImpl(
      uuid: null == uuid
          ? _value.uuid
          : uuid // ignore: cast_nullable_to_non_nullable
              as String,
      allergen: null == allergen
          ? _value.allergen
          : allergen // ignore: cast_nullable_to_non_nullable
              as String,
      reaction: null == reaction
          ? _value.reaction
          : reaction // ignore: cast_nullable_to_non_nullable
              as String,
      onsetDate: freezed == onsetDate
          ? _value.onsetDate
          : onsetDate // ignore: cast_nullable_to_non_nullable
              as String?,
      dateRecorded: null == dateRecorded
          ? _value.dateRecorded
          : dateRecorded // ignore: cast_nullable_to_non_nullable
              as String,
      severity: null == severity
          ? _value.severity
          : severity // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AllergyImpl with DiagnosticableTreeMixin implements _Allergy {
  const _$AllergyImpl(
      {required this.uuid,
      required this.allergen,
      required this.reaction,
      this.onsetDate,
      required this.dateRecorded,
      required this.severity});

  factory _$AllergyImpl.fromJson(Map<String, dynamic> json) =>
      _$$AllergyImplFromJson(json);

  @override
  final String uuid;
  @override
  final String allergen;
  @override
  final String reaction;
  @override
  final String? onsetDate;
  @override
  final String dateRecorded;
  @override
  final String severity;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Allergy(uuid: $uuid, allergen: $allergen, reaction: $reaction, onsetDate: $onsetDate, dateRecorded: $dateRecorded, severity: $severity)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Allergy'))
      ..add(DiagnosticsProperty('uuid', uuid))
      ..add(DiagnosticsProperty('allergen', allergen))
      ..add(DiagnosticsProperty('reaction', reaction))
      ..add(DiagnosticsProperty('onsetDate', onsetDate))
      ..add(DiagnosticsProperty('dateRecorded', dateRecorded))
      ..add(DiagnosticsProperty('severity', severity));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AllergyImpl &&
            (identical(other.uuid, uuid) || other.uuid == uuid) &&
            (identical(other.allergen, allergen) ||
                other.allergen == allergen) &&
            (identical(other.reaction, reaction) ||
                other.reaction == reaction) &&
            (identical(other.onsetDate, onsetDate) ||
                other.onsetDate == onsetDate) &&
            (identical(other.dateRecorded, dateRecorded) ||
                other.dateRecorded == dateRecorded) &&
            (identical(other.severity, severity) ||
                other.severity == severity));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, uuid, allergen, reaction, onsetDate, dateRecorded, severity);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AllergyImplCopyWith<_$AllergyImpl> get copyWith =>
      __$$AllergyImplCopyWithImpl<_$AllergyImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AllergyImplToJson(
      this,
    );
  }
}

abstract class _Allergy implements Allergy {
  const factory _Allergy(
      {required final String uuid,
      required final String allergen,
      required final String reaction,
      final String? onsetDate,
      required final String dateRecorded,
      required final String severity}) = _$AllergyImpl;

  factory _Allergy.fromJson(Map<String, dynamic> json) = _$AllergyImpl.fromJson;

  @override
  String get uuid;
  @override
  String get allergen;
  @override
  String get reaction;
  @override
  String? get onsetDate;
  @override
  String get dateRecorded;
  @override
  String get severity;
  @override
  @JsonKey(ignore: true)
  _$$AllergyImplCopyWith<_$AllergyImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
