import 'dart:convert';
import 'dart:developer';

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


  Future<String> rescheduleAppointment(
      Map<String, dynamic> data) async {
    StreamedResponse response =
    await call<Map<String, dynamic>>(rescheduleAppointment_, data);
    final responseString = await response.stream.bytesToString();
    // {"success":false,"msg":"Appointment Reschedule Request Record Already Exist"}
    final responseData = jsonDecode(responseString);
    if(responseData["success"] == false){
      throw responseData["msg"];
    }
    return responseData["msg"];
  }

  Future<StreamedResponse> rescheduleAppointment_(
      Map<String, dynamic> data) async {
    final tokenPair = await getCachedToken();
    final id = await _repository.getUserId();
    var headers = {
      'Authorization': 'Bearer ${tokenPair.accessToken}',
      'Content-Type': 'application/json',
    };
    var url = '${Constants.BASE_URL_NEW}reschedule';
    final response = request(url: url, token: tokenPair, method: 'POST', requestHeaders: headers, data: data, userId: id);
    // var request = Request(
    //     'POST', Uri.parse('${Constants.BASE_URL_NEW}reschedule'));
    // request.body = json.encode(data);
    // request.headers.addAll(headers);
    // StreamedResponse response = await request.send();
    return response;
  }

}
