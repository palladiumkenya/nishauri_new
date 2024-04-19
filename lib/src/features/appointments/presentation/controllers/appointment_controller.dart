import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nishauri/src/features/appointments/data/models/appointment.dart';
import 'package:nishauri/src/features/appointments/data/repository/appointment_repository.dart';

class AppointmentController extends StateNotifier<AsyncValue<List<Appointment>>> {
  final AppointmentRepository _repository;

  AppointmentController(this._repository):super(const AsyncValue.loading()){
    getAppointments();
  }

  Future<void> getAppointments()async{
    state = const AsyncValue.loading();
    try{
      final appointments = await _repository.getAppointments();
      state = AsyncValue.data(appointments);
    }catch(e){
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
}