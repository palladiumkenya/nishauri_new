import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nishauri/src/features/appointments/data/models/appointment.dart';
import 'package:nishauri/src/features/appointments/data/repository/appointment_repository.dart';
import 'package:nishauri/src/features/appointments/data/services/appointment_services.dart';
import 'package:nishauri/src/features/appointments/presentation/controllers/appointment_controller.dart';

final appointmentProvider = StateNotifierProvider.family<
    AppointmentController,
    AsyncValue<List<Appointment>>,
    bool>((ref, isPrevious) {
  final service = AppointmentService();
  final repository = AppointmentRepository(service, isPrevious);
  return AppointmentController(repository, isPrevious);
});

