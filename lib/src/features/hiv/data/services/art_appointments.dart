import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:nishauri/src/features/auth/data/respositories/auth_repository.dart';
import 'package:nishauri/src/features/auth/data/services/AuthApiService.dart';
import 'package:nishauri/src/features/hiv/data/models/appointment/art_appointment.dart';
import 'package:nishauri/src/shared/interfaces/HTTPService.dart';
import '../../../../utils/constants.dart';

class ARTAppointmentService extends HTTPService {
  final AuthRepository _repository = AuthRepository(AuthApiService());
  Future<List<ARTAppointment>> getAppointments() async{
    final response = await call(getAppointments_, null);
    final responseString = await response.stream.bytesToString();
    final Map<String, dynamic> appointmentsData = json.decode(responseString);
    final programs = (appointmentsData["data"] as List<dynamic>)
        .map((e) => ARTAppointment.fromJson(e))
        .toList();
    return programs;
  }

  Future<StreamedResponse> getAppointments_(dynamic args) async {
    final id = await _repository.getUserId();
    final tokenPair = await getCachedToken();
    var headers = {'Authorization': 'Bearer ${tokenPair.accessToken}'};
    var request =
    Request('GET', Uri.parse('${Constants.BASE_URL_NEW}/patient_details?user_id=$id'));
    request.headers.addAll(headers);
    return await request.send();
  }
}
