import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:nishauri/src/features/auth/data/respositories/auth_repository.dart';
import 'package:nishauri/src/features/auth/data/services/AuthApiService.dart';
import 'package:nishauri/src/features/art/model/Facility.dart';
import 'package:nishauri/src/shared/interfaces/HTTPService.dart';
import 'package:nishauri/src/utils/constants.dart';

class FacilityDirectoryService extends HTTPService {
  final AuthRepository _repository = AuthRepository(AuthApiService());
  Future<List<Facility>> getfacilities() async {
    List<Facility> facilities = [];
    try {
      final response = await call(getFacilities_ as Future<http.StreamedResponse> Function(Null args), null);
      if (response.statusCode == 200) {
        final responseString = await response.stream.bytesToString();
        final Map<String, dynamic> dataNew = json.decode(responseString);
        final List<dynamic> jsonList = dataNew['message'];
        facilities.clear();
        facilities.addAll(jsonList.map((json) => Facility.fromJson(json)));
      } else {
        throw "Failed to fetch data. Status code: ${response.statusCode}";
      }
    } catch (e) {
      throw "No Facility Records Found";
    }
    return facilities;
  }

  Future<http.StreamedResponse> getFacilities_(String queryParameter) async {
    final id = await _repository.getUserId();
    final tokenPair = await getCachedToken();
    var headers = {'Authorization':"Bearer ${tokenPair.accessToken}",
      'Content-Type': 'application/json'};
    var request =
    http.Request('GET', Uri.parse('${Constants.BASE_URL_NEW}/artdirectory?name=$queryParameter&user_id=$id'));

    request.headers.addAll(headers);
    return await request.send();
  }
}