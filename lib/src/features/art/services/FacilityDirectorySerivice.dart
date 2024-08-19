import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:nishauri/src/features/auth/data/respositories/auth_repository.dart';
import 'package:nishauri/src/features/auth/data/services/AuthApiService.dart';
import 'package:nishauri/src/features/art/model/Facility.dart';
import 'package:nishauri/src/shared/interfaces/HTTPService.dart';
import 'package:nishauri/src/utils/constants.dart';

class FacilityDirectoryService extends HTTPService {
  final AuthRepository _repository = AuthRepository(AuthApiService());

  Future<List<Facility>> getfacilities(String search) async {
    try {
      final response = await call(getFacilities_, search);

      if (response.statusCode == 200) {
        final responseString = await response.stream.bytesToString();
        final Map<String, dynamic> dataNew = json.decode(responseString);

        return (dataNew['message'] as List<dynamic>)
            .map((e) => Facility.fromJson(e))
            .toList();
      } else {
        throw "Failed to fetch data. Status code: ${response.statusCode}";
      }
    } catch (e) {
      throw "No Facility Records Found";
    }
  }

  Future<http.StreamedResponse> getFacilities_(String search) async {
    final id = await _repository.getUserId();
    final tokenPair = await getCachedToken();
    var url = '${Constants.BASE_URL_NEW}/artdirectory?name=$search&user_id=$id';
    var headers = {
      'Authorization': "Bearer ${tokenPair.accessToken}",
      'Content-Type': 'application/json'
    };
    final response = request(url: url, token: tokenPair, method: 'GET', requestHeaders: headers, userId: id);
    // var request = http.Request(
    //     'GET',
    //     Uri.parse(
    //         '${Constants.BASE_URL_NEW}/artdirectory?name=$search&user_id=$id'));
    // request.headers.addAll(headers);
    // return await request.send();
    return response;
  }
}
