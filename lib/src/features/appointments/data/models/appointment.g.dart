// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appointment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AppointmentImpl _$$AppointmentImplFromJson(Map<String, dynamic> json) =>
    _$AppointmentImpl(
      id: json['id'] as String?,
      ccc_no: json['ccc_no'] as String?,
      facility_name: json['facility_name'] as String?,
      program_name: json['program_name'] as String?,
      program_code: json['program_code'] as String?,
      program_status: json['program_status'] as String?,
      reschedule_status: json['reschedule_status'] as String?,
      appointment_type: json['appointment_type'] as String?,
      appointment_date: json['appointment_date'] as String,
      appointment: json['appointment'] as String?,
      nextAppointmentDate: json['nextAppointmentDate'] as String?,
      appt_status: json['appt_status'] as String?,
      appointment_status: (json['appointment_status'] as num?)?.toInt(),
      date_attended: json['date_attended'] as String?,
    );

Map<String, dynamic> _$$AppointmentImplToJson(_$AppointmentImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'ccc_no': instance.ccc_no,
      'facility_name': instance.facility_name,
      'program_name': instance.program_name,
      'program_code': instance.program_code,
      'program_status': instance.program_status,
      'reschedule_status': instance.reschedule_status,
      'appointment_type': instance.appointment_type,
      'appointment_date': instance.appointment_date,
      'appointment': instance.appointment,
      'nextAppointmentDate': instance.nextAppointmentDate,
      'appt_status': instance.appt_status,
      'appointment_status': instance.appointment_status,
      'date_attended': instance.date_attended,
    };
