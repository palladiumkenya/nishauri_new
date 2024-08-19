import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:nishauri/src/features/auth/data/respositories/auth_repository.dart';
import 'package:nishauri/src/features/auth/data/services/AuthApiService.dart';
import 'package:nishauri/src/features/clinic_card/data/models/program.dart';
import 'package:nishauri/src/shared/interfaces/HTTPService.dart';
import 'package:nishauri/src/utils/constants.dart';
import 'package:nishauri/src/utils/helpers.dart';


class ProgramService extends HTTPService {
  final AuthRepository _repository = AuthRepository(AuthApiService());
  Future<List<Program>> getPrograms() async {
    try{
      final response = await call(getPrograms_, null);
      if (response.statusCode == 200) {
        final responseString = await response.stream.bytesToString();
        final Map<String, dynamic> dataNew = json.decode(responseString);
          final List<dynamic> jsonList = dataNew['programs'];
          final programs = jsonList.map((json) => Program.fromJson(json))
              .toList();
          return programs;
      }
      else {
        throw 'Something went wrong';
      }

    } catch (e) {
      throw e.toString();
    }
  }

  Future<http.StreamedResponse> getPrograms_(dynamic args) async {
    final id = await _repository.getUserId();
    final tokenPair = await getCachedToken();
    var headers = {'Authorization':"Bearer ${tokenPair.accessToken}",
      'Content-Type': 'application/json'};
    var url = '${Constants.BASE_URL_NEW}/patient_clinic_new?user_id=$id';
    final response = request(url: url, token: tokenPair, method: "GET", requestHeaders: headers, userId: id);
    // var request =
    // http.Request('GET', Uri.parse('${Constants.BASE_URL_NEW}/patient_clinic_new?user_id=$id'));
    // request.headers.addAll(headers);
    // return await request.send();
    return response;
  }

  Future<void> saveRegimen() async {
    try{
      final resp = await call(getPrograms_, null);
      if (resp.statusCode == 200) {
        final responseString = await resp.stream.bytesToString();
        final respData = json.decode(responseString);
        var regimen;
        for (var program in respData['programs']) {
          for (var observation in program['patient_observations']) {
            if (observation['label'] == 'Regimen') {
              regimen = observation['value'];
              break;
            }
          }
        }
          await _repository.saveRegimen(regimen);
      }
    } catch (e) {
      throw e;
    }
  }
}
