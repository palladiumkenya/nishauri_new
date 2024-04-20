// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'art_appointment.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ARTAppointment _$ARTAppointmentFromJson(Map<String, dynamic> json) {
  return _ARTAppointment.fromJson(json);
}

/// @nodoc
mixin _$ARTAppointment {
  String? get id => throw _privateConstructorUsedError;
  String get ccc_no => throw _privateConstructorUsedError;
  String? get appointment_type => throw _privateConstructorUsedError;
  String get appointment_date => throw _privateConstructorUsedError;
  String? get appointment => throw _privateConstructorUsedError;
  String? get nextAppointmentDate => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ARTAppointmentCopyWith<ARTAppointment> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ARTAppointmentCopyWith<$Res> {
  factory $ARTAppointmentCopyWith(
          ARTAppointment value, $Res Function(ARTAppointment) then) =
      _$ARTAppointmentCopyWithImpl<$Res, ARTAppointment>;
  @useResult
  $Res call(
      {String? id,
      String ccc_no,
      String? appointment_type,
      String appointment_date,
      String? appointment,
      String? nextAppointmentDate});
}

/// @nodoc
class _$ARTAppointmentCopyWithImpl<$Res, $Val extends ARTAppointment>
    implements $ARTAppointmentCopyWith<$Res> {
  _$ARTAppointmentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? ccc_no = null,
    Object? appointment_type = freezed,
    Object? appointment_date = null,
    Object? appointment = freezed,
    Object? nextAppointmentDate = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      ccc_no: null == ccc_no
          ? _value.ccc_no
          : ccc_no // ignore: cast_nullable_to_non_nullable
              as String,
      appointment_type: freezed == appointment_type
          ? _value.appointment_type
          : appointment_type // ignore: cast_nullable_to_non_nullable
              as String?,
      appointment_date: null == appointment_date
          ? _value.appointment_date
          : appointment_date // ignore: cast_nullable_to_non_nullable
              as String,
      appointment: freezed == appointment
          ? _value.appointment
          : appointment // ignore: cast_nullable_to_non_nullable
              as String?,
      nextAppointmentDate: freezed == nextAppointmentDate
          ? _value.nextAppointmentDate
          : nextAppointmentDate // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ARTAppointmentImplCopyWith<$Res>
    implements $ARTAppointmentCopyWith<$Res> {
  factory _$$ARTAppointmentImplCopyWith(_$ARTAppointmentImpl value,
          $Res Function(_$ARTAppointmentImpl) then) =
      __$$ARTAppointmentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      String ccc_no,
      String? appointment_type,
      String appointment_date,
      String? appointment,
      String? nextAppointmentDate});
}

/// @nodoc
class __$$ARTAppointmentImplCopyWithImpl<$Res>
    extends _$ARTAppointmentCopyWithImpl<$Res, _$ARTAppointmentImpl>
    implements _$$ARTAppointmentImplCopyWith<$Res> {
  __$$ARTAppointmentImplCopyWithImpl(
      _$ARTAppointmentImpl _value, $Res Function(_$ARTAppointmentImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? ccc_no = null,
    Object? appointment_type = freezed,
    Object? appointment_date = null,
    Object? appointment = freezed,
    Object? nextAppointmentDate = freezed,
  }) {
    return _then(_$ARTAppointmentImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      ccc_no: null == ccc_no
          ? _value.ccc_no
          : ccc_no // ignore: cast_nullable_to_non_nullable
              as String,
      appointment_type: freezed == appointment_type
          ? _value.appointment_type
          : appointment_type // ignore: cast_nullable_to_non_nullable
              as String?,
      appointment_date: null == appointment_date
          ? _value.appointment_date
          : appointment_date // ignore: cast_nullable_to_non_nullable
              as String,
      appointment: freezed == appointment
          ? _value.appointment
          : appointment // ignore: cast_nullable_to_non_nullable
              as String?,
      nextAppointmentDate: freezed == nextAppointmentDate
          ? _value.nextAppointmentDate
          : nextAppointmentDate // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ARTAppointmentImpl
    with DiagnosticableTreeMixin
    implements _ARTAppointment {
  const _$ARTAppointmentImpl(
      {this.id,
      required this.ccc_no,
      this.appointment_type,
      required this.appointment_date,
      this.appointment,
      this.nextAppointmentDate});

  factory _$ARTAppointmentImpl.fromJson(Map<String, dynamic> json) =>
      _$$ARTAppointmentImplFromJson(json);

  @override
  final String? id;
  @override
  final String ccc_no;
  @override
  final String? appointment_type;
  @override
  final String appointment_date;
  @override
  final String? appointment;
  @override
  final String? nextAppointmentDate;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ARTAppointment(id: $id, ccc_no: $ccc_no, appointment_type: $appointment_type, appointment_date: $appointment_date, appointment: $appointment, nextAppointmentDate: $nextAppointmentDate)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ARTAppointment'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('ccc_no', ccc_no))
      ..add(DiagnosticsProperty('appointment_type', appointment_type))
      ..add(DiagnosticsProperty('appointment_date', appointment_date))
      ..add(DiagnosticsProperty('appointment', appointment))
      ..add(DiagnosticsProperty('nextAppointmentDate', nextAppointmentDate));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ARTAppointmentImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.ccc_no, ccc_no) || other.ccc_no == ccc_no) &&
            (identical(other.appointment_type, appointment_type) ||
                other.appointment_type == appointment_type) &&
            (identical(other.appointment_date, appointment_date) ||
                other.appointment_date == appointment_date) &&
            (identical(other.appointment, appointment) ||
                other.appointment == appointment) &&
            (identical(other.nextAppointmentDate, nextAppointmentDate) ||
                other.nextAppointmentDate == nextAppointmentDate));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, ccc_no, appointment_type,
      appointment_date, appointment, nextAppointmentDate);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ARTAppointmentImplCopyWith<_$ARTAppointmentImpl> get copyWith =>
      __$$ARTAppointmentImplCopyWithImpl<_$ARTAppointmentImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ARTAppointmentImplToJson(
      this,
    );
  }
}

abstract class _ARTAppointment implements ARTAppointment {
  const factory _ARTAppointment(
      {final String? id,
      required final String ccc_no,
      final String? appointment_type,
      required final String appointment_date,
      final String? appointment,
      final String? nextAppointmentDate}) = _$ARTAppointmentImpl;

  factory _ARTAppointment.fromJson(Map<String, dynamic> json) =
      _$ARTAppointmentImpl.fromJson;

  @override
  String? get id;
  @override
  String get ccc_no;
  @override
  String? get appointment_type;
  @override
  String get appointment_date;
  @override
  String? get appointment;
  @override
  String? get nextAppointmentDate;
  @override
  @JsonKey(ignore: true)
  _$$ARTAppointmentImplCopyWith<_$ARTAppointmentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
