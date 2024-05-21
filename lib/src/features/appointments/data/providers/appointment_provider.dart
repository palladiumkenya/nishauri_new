import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nishauri/src/features/appointments/data/models/appointment.dart';
import 'package:nishauri/src/features/appointments/data/repository/appointment_repository.dart';
import 'package:nishauri/src/features/appointments/data/services/appointment_services.dart';
import 'package:nishauri/src/features/appointments/presentation/controllers/appointment_controller.dart';
import 'package:nishauri/src/features/hiv/data/repositories/art_appointment_repository.dart';
import 'package:nishauri/src/features/hiv/data/services/art_appointments.dart';
import 'package:nishauri/src/features/user_programs/data/providers/program_provider.dart';

final appointmentProvider = StateNotifierProvider.family<AppointmentController,
    AsyncValue<List<Appointment>>, bool>((ref, isPrevious) {
  ref.watch(userProgramProvider);
  final service = AppointmentService();
  final artAppointmentRepository =
      ARTAppointmentRepository(ARTAppointmentService());
  final repository =
      AppointmentRepository(service, isPrevious, artAppointmentRepository);
  return AppointmentController(repository, isPrevious);
});
