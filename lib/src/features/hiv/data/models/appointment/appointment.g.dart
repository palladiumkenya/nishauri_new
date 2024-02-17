// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appointment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AppointmentImpl _$$AppointmentImplFromJson(Map<String, dynamic> json) =>
    _$AppointmentImpl(
      id: json['id'] as String?,
      cccNumber: json['cccNumber'] as String,
      appointmentType: json['appointmentType'] as String,
      appointmentDate: json['appointmentDate'] as String,
      nextAppointmentDate: json['nextAppointmentDate'] as String?,
    );

Map<String, dynamic> _$$AppointmentImplToJson(_$AppointmentImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'cccNumber': instance.cccNumber,
      'appointmentType': instance.appointmentType,
      'appointmentDate': instance.appointmentDate,
      'nextAppointmentDate': instance.nextAppointmentDate,
    };
