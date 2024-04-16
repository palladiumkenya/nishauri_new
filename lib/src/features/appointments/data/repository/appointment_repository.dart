import 'package:nishauri/src/features/appointments/data/models/appointment.dart';
import 'package:nishauri/src/features/appointments/data/services/appointment_services.dart';

class AppointmentRepository {
  final AppointmentService _service;
  AppointmentRepository(this._service);
  Future<List<Appointment>> getAppointments() async{
    return _service.getAppointments();
  }
}