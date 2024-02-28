import 'package:nishauri/src/features/hiv/data/services/art_appointments.dart';

import '../models/appointment/art_appointment.dart';

class ARTAppointmentRepository {
  final ARTAppointmentService _service;
  ARTAppointmentRepository(this._service);
  Future<List<ARTAppointment>> getAppointments() async{
   return _service.getAppointments();
  }

}