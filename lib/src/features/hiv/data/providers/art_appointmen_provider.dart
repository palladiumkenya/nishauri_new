import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nishauri/src/features/hiv/data/models/appointment/art_appointment.dart';
import 'package:nishauri/src/features/hiv/data/repositories/art_appointment_repository.dart';
import 'package:nishauri/src/features/hiv/data/services/art_appointments.dart';
import 'package:nishauri/src/features/hiv/presentation/controllers/ARTAppointmentsController.dart';

final artAppointmentProvider = StateNotifierProvider<ARTAppointmentController,
    AsyncValue<List<ARTAppointment>>>((ref) {
  final service = ARTAppointmentService();
  final repository = ARTAppointmentRepository(service);
  return ARTAppointmentController(repository);
});
