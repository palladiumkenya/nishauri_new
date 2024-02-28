// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'art_appointment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ARTAppointmentImpl _$$ARTAppointmentImplFromJson(Map<String, dynamic> json) =>
    _$ARTAppointmentImpl(
      id: json['id'] as String?,
      cccNumber: json['cccNumber'] as String,
      appointmentType: json['appointmentType'] as String,
      appointmentDate: json['appointmentDate'] as String,
      nextAppointmentDate: json['nextAppointmentDate'] as String?,
    );

Map<String, dynamic> _$$ARTAppointmentImplToJson(
        _$ARTAppointmentImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'cccNumber': instance.cccNumber,
      'appointmentType': instance.appointmentType,
      'appointmentDate': instance.appointmentDate,
      'nextAppointmentDate': instance.nextAppointmentDate,
    };
