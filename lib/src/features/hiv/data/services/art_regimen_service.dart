import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:nishauri/src/features/auth/data/respositories/auth_repository.dart';
import 'package:nishauri/src/features/auth/data/services/AuthApiService.dart';
import 'package:nishauri/src/features/hiv/data/models/regimen/art_regimen.dart';
import 'package:nishauri/src/shared/interfaces/HTTPService.dart';
import 'package:nishauri/src/utils/constants.dart';

class ARTRegimenService extends HTTPService {
  final AuthRepository _repository = AuthRepository(AuthApiService());
  Future<List<ARTRegimen>> getARTRegimenHistory() async {
    List<ARTRegimen> regimen = [];
    try {
      final response = await call(getARTRegimenHistory_, null);
      if (response.statusCode == 200) {
        final responseString = await response.stream.bytesToString();
        final Map<String, dynamic> dataNew = json.decode(responseString);
        final List<dynamic> jsonList = dataNew['msg'];
        regimen.clear();
        regimen.addAll(jsonList.map((json) => ARTRegimen.fromJson(json)));
      } else {
        throw "Failed to fetch data. Status code: ${response.statusCode}";
      }
    } catch (e) {
      throw e;
    }
    return regimen;
  }

  Future<http.StreamedResponse> getARTRegimenHistory_(dynamic args) async {
    final id = await _repository.getUserId();
    final tokenPair = await getCachedToken();
    var headers = {'Authorization':"Bearer ${tokenPair.accessToken}",
      'Content-Type': 'application/json'};
    var url = '${Constants.BASE_URL_NEW}/regimen?user_id=$id';
    final response = request(url: url, token: tokenPair, method: 'GET', requestHeaders: headers, userId: id);
    return response;
    // var request =
    // http.Request('GET', Uri.parse('${Constants.BASE_URL_NEW}/regimen?user_id=$id'));
    // request.headers.addAll(headers);
    // return await request.send();
  }
}
