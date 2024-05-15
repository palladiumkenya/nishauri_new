import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:nishauri/src/features/auth/data/respositories/auth_repository.dart';
import 'package:nishauri/src/features/auth/data/services/AuthApiService.dart';
import 'package:nishauri/src/features/clinic_card/data/models/program.dart';
import 'package:nishauri/src/shared/interfaces/HTTPService.dart';
import 'package:nishauri/src/utils/constants.dart';
import 'package:nishauri/src/utils/helpers.dart';


class ProgramService extends HTTPService {
  // final AuthRepository _repository = AuthRepository(AuthApiService());
  // Future<List<Program>> getPrograms() async {
  //   try {
  //     final data = await loadJsonData('assets/data/clinic_card.json');
  //     final List<dynamic> jsonList = jsonDecode(data)['programs'];
  //     final List<Program> programs = jsonList.map((json) => Program.fromJson(json)).toList();
  //     return programs;
  //   } catch (e) {
  //     // Handle errors appropriately
  //     print('Error fetching programs: $e');
  //     return []; // Return an empty list or throw an exception as per your requirement
  //   }
  // }
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
    // final data = await loadJsonData('assets/data/clinic_card.json');
    // final List<dynamic> jsonList = jsonDecode(data)['programs'];
    // final programs = jsonList.map((json) => Program.fromJson(json)).toList();
    // return programs;
  }

  Future<http.StreamedResponse> getPrograms_(dynamic args) async {
    final id = await _repository.getUserId();
    final tokenPair = await getCachedToken();
    var headers = {'Authorization':"Bearer ${tokenPair.accessToken}",
      'Content-Type': 'application/json'};
    var request =
    http.Request('GET', Uri.parse('${Constants.BASE_URL_NEW}/patient_clinic_new?user_id=$id'));
    request.headers.addAll(headers);
    return await request.send();
  }
}
