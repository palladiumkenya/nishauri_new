import 'package:freezed_annotation/freezed_annotation.dart';

part 'appointment.freezed.dart';
part 'appointment.g.dart';

@Freezed()
class Appointment with _$Appointment {
  const factory Appointment({
    String? id,
    String? ccc_no,
    String? program_name,
    String? appointment_type,
    required String appointment_date,
    String? appointment,
    String? nextAppointmentDate,
    String? appt_status,
    String? visit_date,
  }) = _Appointment;

  factory Appointment.fromJson(Map<String, dynamic> json)=> _$AppointmentFromJson(json);
}