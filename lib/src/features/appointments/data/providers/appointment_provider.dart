import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nishauri/src/features/appointments/data/models/appointment.dart';
import 'package:nishauri/src/features/appointments/data/repository/appointment_repository.dart';
import 'package:nishauri/src/features/appointments/data/services/appointment_services.dart';
import 'package:nishauri/src/features/appointments/presentation/controllers/appointment_controller.dart';

final appointmentProvider = StateNotifierProvider<AppointmentController,
    AsyncValue<List<Appointment>>>((ref) {
  final service = AppointmentService();
  final repository = AppointmentRepository(service);
  return AppointmentController(repository);
});
