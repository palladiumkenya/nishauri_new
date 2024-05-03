import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nishauri/src/features/appointments/data/models/appointment.dart';
import 'package:nishauri/src/features/appointments/data/repository/appointment_repository.dart';

class AppointmentController extends StateNotifier<AsyncValue<List<Appointment>>> {
  final AppointmentRepository _repository;
  final bool _isPrevious;

  AppointmentController(this._repository, this._isPrevious)
      : super(const AsyncValue.loading()) {
    getAppointments();
  }

  Future<void> getAppointments() async {
    state = const AsyncValue.loading();
    try {
      final appointments = await _repository.getAppointments(_isPrevious);
      state = AsyncValue.data(appointments);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
  Future<String> rescheduleAppointment(Map<String, dynamic> data) async {
    try {
      final message = await _repository.rescheduleARTAppointment(data);
      await getAppointments();
      return message;
    } catch (e) {
      rethrow;
    }
  }
}
