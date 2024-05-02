import 'dart:convert';
import 'package:http/http.dart';
import 'package:nishauri/src/features/appointments/data/models/appointment.dart';
import 'package:nishauri/src/features/auth/data/respositories/auth_repository.dart';
import 'package:nishauri/src/features/auth/data/services/AuthApiService.dart';
import 'package:nishauri/src/shared/interfaces/HTTPService.dart';
import '../../../../utils/constants.dart';

class AppointmentService extends HTTPService {
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
            .map((e) => userAppointmentsFromJson(e))
            .toList();
      } else {
        throw "Failed to fetch appointments. Please try again later.";
      }
    } catch (e) {
      throw "Failed to connect. Please check your internet connection.";
    }
  }

  Appointment userAppointmentsFromJson(Map<String, dynamic> json) {
    return Appointment(
      id: json["appointment_id"].toString(),
      ccc_no: json["ccc_no"],
      appointment_type: json["appointment_type"],
      appointment_date: json["appointment_date"],
      appointment: json["appointment"],
      program_name: json["program_name"],
      appt_status: json["appt_status"],
    );
  }

  Future<StreamedResponse> getAppointments_(dynamic args) async {
    final id = await _repository.getUserId();
    final tokenPair = await getCachedToken();
    final headers = {'Authorization': 'Bearer ${tokenPair.accessToken}'};
    final request = Request('GET',
        Uri.parse('${Constants.BASE_URL_NEW}/upcoming_appointment?user_id=$id'));
    request.headers.addAll(headers);
    return await request.send();
  }

  Future<StreamedResponse> getPreviousAppointments_(dynamic args) async {
    final id = await _repository.getUserId();
    final tokenPair = await getCachedToken();
    final headers = {'Authorization': 'Bearer ${tokenPair.accessToken}'};
    final request = Request('GET',
        Uri.parse('${Constants.BASE_URL_NEW}/appointment_previous?user_id=$id'));
    request.headers.addAll(headers);
    return await request.send();
  }
}
