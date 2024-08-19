import 'dart:convert';
import 'package:http/http.dart';
import 'package:nishauri/src/features/appointments/data/models/appointment.dart';
import 'package:nishauri/src/features/auth/data/respositories/auth_repository.dart';
import 'package:nishauri/src/features/auth/data/services/AuthApiService.dart';
import 'package:nishauri/src/shared/interfaces/HTTPService.dart';
import '../../../../utils/constants.dart';

class AppointmentService extends HTTPService {
  // final AuthRepository _authRepository;
  final AuthRepository _repository = AuthRepository(AuthApiService());

  Future<List<Appointment>> getAppointments(bool isPrevious) async {
    try {
      final response = await call(
          isPrevious ? getPreviousAppointments_ : getAppointments_, null);
      if (response.statusCode == 200) {
        final responseString = await response.stream.bytesToString();
        final List<dynamic> appointmentData =
            json.decode(responseString)["data"];
        return appointmentData
            .map((e) => Appointment.fromJson({
                  ...e,
                  "id": e["appointment_id"].toString(),
                  "date_attended": e["visit_date"]
                }))
            .toList();
      } else {
        throw "Failed to fetch appointments. Please try again later.";
      }
    } catch (e) {
      throw e;
    }
  }

  Future<StreamedResponse> getAppointments_(dynamic args) async {
    final id = await _repository.getUserId();
    final tokenPair = await getCachedToken();
    final headers = {'Authorization': 'Bearer ${tokenPair.accessToken}'};
    var url = '${Constants.BASE_URL_NEW}/upcoming_appointment?user_id=$id';
    final response = request(url: url, token: tokenPair, method: 'GET', requestHeaders: headers, userId: id);
    return response;
  }

  Future<void> saveAppointment() async {
    try{
      final resp = await call(getAppointments_, null);
      if (resp.statusCode == 200) {
        final responseString = await resp.stream.bytesToString();
        final respData = json.decode(responseString);
        if (respData["success"] == true) {
          final appDate = respData["data"][0]["appointment"];
          await _repository.saveAppointment(appDate);
        }
        else{
          throw respData["msg"];
        }
      }
    } catch (e) {
      throw e;
    }
  }

  Future<StreamedResponse> getPreviousAppointments_(dynamic args) async {
    final id = await _repository.getUserId();
    final tokenPair = await getCachedToken();
    final headers = {'Authorization': 'Bearer ${tokenPair.accessToken}'};
    var url = '${Constants.BASE_URL_NEW}/appointment_previous?user_id=$id';
    final response = request(url: url, token: tokenPair, method: 'GET', requestHeaders: headers, userId: id);
    return response;
    // final request = Request(
    //     'GET',
    //     Uri.parse(
    //         '${Constants.BASE_URL_NEW}/appointment_previous?user_id=$id'));
    // request.headers.addAll(headers);
    // return await request.send();
  }
}
