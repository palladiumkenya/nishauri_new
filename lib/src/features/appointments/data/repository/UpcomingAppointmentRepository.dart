
import 'package:nishauri/src/features/appointments/presentation/pages/Appointments.dart';
import 'package:nishauri/src/features/appointments/data/services/UpcomingAppointmentService.dart';

class UpcomingAppointmentRepository {
  final UpcomingAppointmentRepository _service;

  UpcomingAppointmentRepository(this._service);

  Future<List<Appointments>> getUpcomingAppointemnts() async {
    final upcomingAppointment = await _service.getUpcomingAppointemnts();
    return upcomingAppointment;
  }
}