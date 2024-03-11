
import 'dart:convert';
import 'package:nishauri/src/features/appointments/data/models/upcoming_appointment.dart';
import 'package:nishauri/src/shared/interfaces/HTTPService.dart';
import 'package:nishauri/src/utils/helpers.dart';

class UpcomingAppointmentService extends HTTPService {
  Future<List<Appointment>> getUpcomingAppointments() async {
    final data = await loadJsonData('assets/data/upcoming_appointment.json');
    final List<dynamic> jsonList = jsonDecode(data)['data']; // Access the 'data' array
    final upcomingAppointments = jsonList.map((json) => Appointment.fromJson(json)).toList();
    return upcomingAppointments;
  }

  
}