import 'package:nishauri/src/features/appointments/data/models/appointment.dart';
import 'package:nishauri/src/features/appointments/data/services/appointment_services.dart';

class AppointmentRepository {
  final AppointmentService _service;
  final bool _isPrevious;

  AppointmentRepository(this._service, this._isPrevious);

  Future<List<Appointment>> getAppointments(bool isPrevious) async {
    return _service.getAppointments(isPrevious);
  }
}
