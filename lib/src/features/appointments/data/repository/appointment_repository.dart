import 'package:nishauri/src/features/appointments/data/models/appointment.dart';
import 'package:nishauri/src/features/appointments/data/services/appointment_services.dart';
import 'package:nishauri/src/features/hiv/data/repositories/art_appointment_repository.dart';

class AppointmentRepository {
  final AppointmentService _service;
  final ARTAppointmentRepository _artAppointmentRepository;
  final bool _isPrevious;

  AppointmentRepository(
      this._service, this._isPrevious, this._artAppointmentRepository);

  // TODO - Should get appointments from various programs
  Future<List<Appointment>> getAppointments(bool isPrevious) async {
    return _service.getAppointments(isPrevious);
  }
  Future<String> rescheduleARTAppointment(Map<String, dynamic> data) async {
    return await _artAppointmentRepository.rescheduleAppointment(data);
  }
  Future<void> saveAppointment() async {
    await _service.saveAppointment();
  }
}
