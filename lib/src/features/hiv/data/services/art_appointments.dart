import 'dart:convert';

import 'package:http/http.dart';
import 'package:nishauri/src/features/hiv/data/models/appointment/art_appointment.dart';
import 'package:nishauri/src/shared/interfaces/HTTPService.dart';
import '../../../../utils/constants.dart';

class ARTAppointmentService extends HTTPService {
  Future<List<ARTAppointment>> getAppointments() async{
    final response = await call(getAppointments_, null);
    final responseString = await response.stream.bytesToString();
    final Map<String, dynamic> appointmentsData = json.decode(responseString);
    final programs = (appointmentsData["results"] as List<dynamic>)
        .map((e) => ARTAppointment.fromJson(e))
        .toList();
    return programs;
  }

  Future<StreamedResponse> getAppointments_(dynamic args) async {
    final tokenPair = await getCachedToken();
    var headers = {'x-access-token': tokenPair.accessToken};
    var request =
    Request('GET', Uri.parse('${Constants.BASE_URL}/hiv-program/appointments/'));
    request.headers.addAll(headers);
    return await request.send();
  }
}
