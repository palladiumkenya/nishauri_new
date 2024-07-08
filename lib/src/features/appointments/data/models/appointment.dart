import 'package:freezed_annotation/freezed_annotation.dart';

part 'appointment.freezed.dart';
part 'appointment.g.dart';

@Freezed()
class Appointment with _$Appointment {
  const factory Appointment({
    String? id,
    String? ccc_no,
    String? facility_name,
    String? program_name,
    String? program_code,
    String? program_status,
    String? reschedule_status,
    String? appointment_type,
    required String appointment_date,
    String? appointment,
    String? nextAppointmentDate,
    String? appt_status,
    int? appointment_status,
    String? date_attended,
  }) = _Appointment;

  factory Appointment.fromJson(Map<String, dynamic> json)=> _$AppointmentFromJson(json);
}
