import 'package:nishauri/src/features/appointments/data/models/appointment.dart';
import 'package:nishauri/src/features/provider/appointment_management/data/services/appointment_management_service.dart';

class AppointmentManagementRepository {
  final AppointmentManagementService _service;

  AppointmentManagementRepository(this._service);

  Future<List<Appointment>> getAppointmentReschedule() async {
    return await _service.getRescheduleRequests();
  }
}