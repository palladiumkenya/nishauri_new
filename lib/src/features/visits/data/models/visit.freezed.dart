// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'visit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Visit _$VisitFromJson(Map<String, dynamic> json) {
  return _Visit.fromJson(json);
}

/// @nodoc
mixin _$Visit {
  String get uuid => throw _privateConstructorUsedError;
  List<Allergy> get allergies => throw _privateConstructorUsedError;
  List<Complaint> get complaints => throw _privateConstructorUsedError;
  List<Condition> get conditions => throw _privateConstructorUsedError;
  List<Diagnosis> get diagnosis => throw _privateConstructorUsedError;
  List<LabResult> get labResults => throw _privateConstructorUsedError;
  List<Vital> get vitals => throw _privateConstructorUsedError;
  String get visitDate => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $VisitCopyWith<Visit> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VisitCopyWith<$Res> {
  factory $VisitCopyWith(Visit value, $Res Function(Visit) then) =
      _$VisitCopyWithImpl<$Res, Visit>;
  @useResult
  $Res call(
      {String uuid,
      List<Allergy> allergies,
      List<Complaint> complaints,
      List<Condition> conditions,
      List<Diagnosis> diagnosis,
      List<LabResult> labResults,
      List<Vital> vitals,
      String visitDate});
}

/// @nodoc
class _$VisitCopyWithImpl<$Res, $Val extends Visit>
    implements $VisitCopyWith<$Res> {
  _$VisitCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uuid = null,
    Object? allergies = null,
    Object? complaints = null,
    Object? conditions = null,
    Object? diagnosis = null,
    Object? labResults = null,
    Object? vitals = null,
    Object? visitDate = null,
  }) {
    return _then(_value.copyWith(
      uuid: null == uuid
          ? _value.uuid
          : uuid // ignore: cast_nullable_to_non_nullable
              as String,
      allergies: null == allergies
          ? _value.allergies
          : allergies // ignore: cast_nullable_to_non_nullable
              as List<Allergy>,
      complaints: null == complaints
          ? _value.complaints
          : complaints // ignore: cast_nullable_to_non_nullable
              as List<Complaint>,
      conditions: null == conditions
          ? _value.conditions
          : conditions // ignore: cast_nullable_to_non_nullable
              as List<Condition>,
      diagnosis: null == diagnosis
          ? _value.diagnosis
          : diagnosis // ignore: cast_nullable_to_non_nullable
              as List<Diagnosis>,
      labResults: null == labResults
          ? _value.labResults
          : labResults // ignore: cast_nullable_to_non_nullable
              as List<LabResult>,
      vitals: null == vitals
          ? _value.vitals
          : vitals // ignore: cast_nullable_to_non_nullable
              as List<Vital>,
      visitDate: null == visitDate
          ? _value.visitDate
          : visitDate // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$VisitImplCopyWith<$Res> implements $VisitCopyWith<$Res> {
  factory _$$VisitImplCopyWith(
          _$VisitImpl value, $Res Function(_$VisitImpl) then) =
      __$$VisitImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String uuid,
      List<Allergy> allergies,
      List<Complaint> complaints,
      List<Condition> conditions,
      List<Diagnosis> diagnosis,
      List<LabResult> labResults,
      List<Vital> vitals,
      String visitDate});
}

/// @nodoc
class __$$VisitImplCopyWithImpl<$Res>
    extends _$VisitCopyWithImpl<$Res, _$VisitImpl>
    implements _$$VisitImplCopyWith<$Res> {
  __$$VisitImplCopyWithImpl(
      _$VisitImpl _value, $Res Function(_$VisitImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uuid = null,
    Object? allergies = null,
    Object? complaints = null,
    Object? conditions = null,
    Object? diagnosis = null,
    Object? labResults = null,
    Object? vitals = null,
    Object? visitDate = null,
  }) {
    return _then(_$VisitImpl(
      uuid: null == uuid
          ? _value.uuid
          : uuid // ignore: cast_nullable_to_non_nullable
              as String,
      allergies: null == allergies
          ? _value._allergies
          : allergies // ignore: cast_nullable_to_non_nullable
              as List<Allergy>,
      complaints: null == complaints
          ? _value._complaints
          : complaints // ignore: cast_nullable_to_non_nullable
              as List<Complaint>,
      conditions: null == conditions
          ? _value._conditions
          : conditions // ignore: cast_nullable_to_non_nullable
              as List<Condition>,
      diagnosis: null == diagnosis
          ? _value._diagnosis
          : diagnosis // ignore: cast_nullable_to_non_nullable
              as List<Diagnosis>,
      labResults: null == labResults
          ? _value._labResults
          : labResults // ignore: cast_nullable_to_non_nullable
              as List<LabResult>,
      vitals: null == vitals
          ? _value._vitals
          : vitals // ignore: cast_nullable_to_non_nullable
              as List<Vital>,
      visitDate: null == visitDate
          ? _value.visitDate
          : visitDate // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$VisitImpl with DiagnosticableTreeMixin implements _Visit {
  const _$VisitImpl(
      {required this.uuid,
      final List<Allergy> allergies = const [],
      final List<Complaint> complaints = const [],
      final List<Condition> conditions = const [],
      final List<Diagnosis> diagnosis = const [],
      final List<LabResult> labResults = const [],
      final List<Vital> vitals = const [],
      required this.visitDate})
      : _allergies = allergies,
        _complaints = complaints,
        _conditions = conditions,
        _diagnosis = diagnosis,
        _labResults = labResults,
        _vitals = vitals;

  factory _$VisitImpl.fromJson(Map<String, dynamic> json) =>
      _$$VisitImplFromJson(json);

  @override
  final String uuid;
  final List<Allergy> _allergies;
  @override
  @JsonKey()
  List<Allergy> get allergies {
    if (_allergies is EqualUnmodifiableListView) return _allergies;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_allergies);
  }

  final List<Complaint> _complaints;
  @override
  @JsonKey()
  List<Complaint> get complaints {
    if (_complaints is EqualUnmodifiableListView) return _complaints;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_complaints);
  }

  final List<Condition> _conditions;
  @override
  @JsonKey()
  List<Condition> get conditions {
    if (_conditions is EqualUnmodifiableListView) return _conditions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_conditions);
  }

  final List<Diagnosis> _diagnosis;
  @override
  @JsonKey()
  List<Diagnosis> get diagnosis {
    if (_diagnosis is EqualUnmodifiableListView) return _diagnosis;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_diagnosis);
  }

  final List<LabResult> _labResults;
  @override
  @JsonKey()
  List<LabResult> get labResults {
    if (_labResults is EqualUnmodifiableListView) return _labResults;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_labResults);
  }

  final List<Vital> _vitals;
  @override
  @JsonKey()
  List<Vital> get vitals {
    if (_vitals is EqualUnmodifiableListView) return _vitals;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_vitals);
  }

  @override
  final String visitDate;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Visit(uuid: $uuid, allergies: $allergies, complaints: $complaints, conditions: $conditions, diagnosis: $diagnosis, labResults: $labResults, vitals: $vitals, visitDate: $visitDate)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Visit'))
      ..add(DiagnosticsProperty('uuid', uuid))
      ..add(DiagnosticsProperty('allergies', allergies))
      ..add(DiagnosticsProperty('complaints', complaints))
      ..add(DiagnosticsProperty('conditions', conditions))
      ..add(DiagnosticsProperty('diagnosis', diagnosis))
      ..add(DiagnosticsProperty('labResults', labResults))
      ..add(DiagnosticsProperty('vitals', vitals))
      ..add(DiagnosticsProperty('visitDate', visitDate));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VisitImpl &&
            (identical(other.uuid, uuid) || other.uuid == uuid) &&
            const DeepCollectionEquality()
                .equals(other._allergies, _allergies) &&
            const DeepCollectionEquality()
                .equals(other._complaints, _complaints) &&
            const DeepCollectionEquality()
                .equals(other._conditions, _conditions) &&
            const DeepCollectionEquality()
                .equals(other._diagnosis, _diagnosis) &&
            const DeepCollectionEquality()
                .equals(other._labResults, _labResults) &&
            const DeepCollectionEquality().equals(other._vitals, _vitals) &&
            (identical(other.visitDate, visitDate) ||
                other.visitDate == visitDate));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      uuid,
      const DeepCollectionEquality().hash(_allergies),
      const DeepCollectionEquality().hash(_complaints),
      const DeepCollectionEquality().hash(_conditions),
      const DeepCollectionEquality().hash(_diagnosis),
      const DeepCollectionEquality().hash(_labResults),
      const DeepCollectionEquality().hash(_vitals),
      visitDate);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$VisitImplCopyWith<_$VisitImpl> get copyWith =>
      __$$VisitImplCopyWithImpl<_$VisitImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$VisitImplToJson(
      this,
    );
  }
}

abstract class _Visit implements Visit {
  const factory _Visit(
      {required final String uuid,
      final List<Allergy> allergies,
      final List<Complaint> complaints,
      final List<Condition> conditions,
      final List<Diagnosis> diagnosis,
      final List<LabResult> labResults,
      final List<Vital> vitals,
      required final String visitDate}) = _$VisitImpl;

  factory _Visit.fromJson(Map<String, dynamic> json) = _$VisitImpl.fromJson;

  @override
  String get uuid;
  @override
  List<Allergy> get allergies;
  @override
  List<Complaint> get complaints;
  @override
  List<Condition> get conditions;
  @override
  List<Diagnosis> get diagnosis;
  @override
  List<LabResult> get labResults;
  @override
  List<Vital> get vitals;
  @override
  String get visitDate;
  @override
  @JsonKey(ignore: true)
  _$$VisitImplCopyWith<_$VisitImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
