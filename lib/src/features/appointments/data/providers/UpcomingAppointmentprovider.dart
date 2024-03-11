import 'package:flutter_riverpod/flutter_riverpod.dart';  
import 'package:nishauri/src/features/appointments/data//services/UpcomingAppointmentService.dart';
import 'package:nishauri/src/features/appointments/data/models/upcoming_appointment.dart';
final UpcomingAppointmentprovider = FutureProvider<List<Appointment>>((ref) async {

  
  UpcomingAppointmentService service = UpcomingAppointmentService();
  return await service.getUpcomingAppointments();
});
