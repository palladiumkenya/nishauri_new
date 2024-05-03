import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nishauri/src/features/hiv/data/models/appointment/art_appointment.dart';
import 'package:nishauri/src/features/hiv/data/repositories/art_appointment_repository.dart';

class ARTAppointmentController
    extends StateNotifier<AsyncValue<List<ARTAppointment>>> {
  final ARTAppointmentRepository _repository;

  ARTAppointmentController(this._repository)
      : super(const AsyncValue.loading()) {
    getAppointments();
  }

  Future<void> getAppointments() async {
    state = const AsyncValue.loading();
    try {
      final appointments = await _repository.getAppointments();
      state = AsyncValue.data(appointments);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<String> rescheduleAppointment(Map<String, dynamic> data) async {
    try {
      final message = await _repository.rescheduleAppointment(data);
      await getAppointments();
      return message;
    } catch (e) {
      rethrow;
    }
  }
}
