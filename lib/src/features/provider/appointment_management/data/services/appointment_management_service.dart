import 'dart:convert';
import 'dart:developer';

import 'package:nishauri/src/features/appointments/data/models/appointment.dart';
import 'package:nishauri/src/shared/interfaces/HTTPService.dart';
import 'package:nishauri/src/utils/helpers.dart';

class AppointmentManagementService extends HTTPService {
  Future<List<Appointment>> getRescheduleRequests() async {
    final data = await loadJsonData("assets/data/reschedule.json");
    final json = jsonDecode(data);
    final appointments = json
        .map((an) => Appointment.fromJson(Map<String, dynamic>.from(an))).toList();

    log("$appointments");
    return [...appointments];
  }
}