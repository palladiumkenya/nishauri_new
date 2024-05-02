// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appointment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AppointmentImpl _$$AppointmentImplFromJson(Map<String, dynamic> json) =>
    _$AppointmentImpl(
      id: json['id'] as String?,
      ccc_no: json['ccc_no'] as String?,
      program_name: json['program_name'] as String?,
      appointment_type: json['appointment_type'] as String?,
      appointment_date: json['appointment_date'] as String,
      appointment: json['appointment'] as String?,
      nextAppointmentDate: json['nextAppointmentDate'] as String?,
      appt_status: json['appt_status'] as String?,
      visit_date: json['visit_date'] as String?,
    );

Map<String, dynamic> _$$AppointmentImplToJson(_$AppointmentImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'ccc_no': instance.ccc_no,
      'program_name': instance.program_name,
      'appointment_type': instance.appointment_type,
      'appointment_date': instance.appointment_date,
      'appointment': instance.appointment,
      'nextAppointmentDate': instance.nextAppointmentDate,
      'appt_status': instance.appt_status,
      'visit_date': instance.visit_date,
    };
