import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
part 'appointment.freezed.dart';
part 'appointment.g.dart';

@Freezed()
class Appointment with _$Appointment {
  const factory Appointment({
    String? id,
    required String cccNumber,
    required String appointmentType,
    required String appointmentDate,
    String? nextAppointmentDate,
  }) = _Appointment;

  factory Appointment.fromJson(Map<String, dynamic> json)=> _$AppointmentFromJson(json);
}