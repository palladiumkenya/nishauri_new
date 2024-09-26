import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nishauri/src/features/appointments/data/models/appointment.dart';
import 'package:nishauri/src/features/provider/appointment_management/data/repositories/appointment_management_repository.dart';
import 'package:nishauri/src/features/provider/appointment_management/data/services/appointment_management_service.dart';

final appointmentRescheduleProvider = FutureProvider<List<Appointment>>((ref) async {
  final service = AppointmentManagementService();
  final repo = AppointmentManagementRepository(service);
  return await repo.getAppointmentReschedule();
});