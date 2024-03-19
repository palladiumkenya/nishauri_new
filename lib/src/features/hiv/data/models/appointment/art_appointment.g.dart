// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'art_appointment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ARTAppointmentImpl _$$ARTAppointmentImplFromJson(Map<String, dynamic> json) =>
    _$ARTAppointmentImpl(
      id: json['id'] as String?,
      ccc_no: json['ccc_no'] as String,
      appointment_type: json['appointment_type'] as String,
      appointment_date: json['appointment_date'] as String,
      appointment: json['appointment'] as String,
      nextAppointmentDate: json['nextAppointmentDate'] as String?,
    );

Map<String, dynamic> _$$ARTAppointmentImplToJson(
        _$ARTAppointmentImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'ccc_no': instance.ccc_no,
      'appointment_type': instance.appointment_type,
      'appointment_date': instance.appointment_date,
      'appointment': instance.appointment,
      'nextAppointmentDate': instance.nextAppointmentDate,
    };
