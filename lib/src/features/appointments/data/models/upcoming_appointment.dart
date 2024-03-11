//import 'package:freezed_annotation/freezed_annotation.dart';

//part 'upcoming_appointment.dart';


class Appointment {
  final int id;
  final String appointmentType;
  final String appointmentDate;
  final String? dateAttended;
  final String apptStatus;
  final String rStatus;
  final String appointment;

  Appointment({
    required this.id,
    required this.appointmentType,
    required this.appointmentDate,
    this.dateAttended,
    required this.apptStatus,
    required this.rStatus,
    required this.appointment,
  });

  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
      id: json['id'] as int,
      appointmentType: json['appointment_type'] as String,
      appointmentDate: json['appointment_date'] as String,
      dateAttended: json['date_attended'] as String?,
      apptStatus: json['appt_status'] as String,
      rStatus: json['r_status'] as String,
      appointment: json['appointment'] as String,
    );
  }
}
