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
    try{
      final response = await call(getAppointments_, null);
      if (response.statusCode == 200) {
        final responseString = await response.stream.bytesToString();
        final List<dynamic> appointmentData = json.decode(responseString)["data"];
        return appointmentData.map((e) => userUpcomingAppointments(e)).toList();
      } else {
        throw "Something Went Wrong Contact Try Again";
      }
    } catch (e) {
      throw "Please check your internet connection";
    }
  }

  ARTAppointment userUpcomingAppointments(Map<String, dynamic> json) {
    return ARTAppointment(
      id:json["appointment_id"].toString(),
      ccc_no: json["ccc_no"],
      appointment_type: json["appointment_type"],
      appointment_date: json["appointment_date"],
      appointment: json["appointment"],
    );
  }


  Future<StreamedResponse> getAppointments_(dynamic args) async {
    final id = await _repository.getUserId();
    final tokenPair = await getCachedToken();
    var headers = {'Authorization': 'Bearer ${tokenPair.accessToken}'};
    var request =
    Request('GET', Uri.parse('${Constants.BASE_URL_NEW}/upcoming_appointment?user_id=$id'));
    request.headers.addAll(headers);
    return await request.send();
  }
}
