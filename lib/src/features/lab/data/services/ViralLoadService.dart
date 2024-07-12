import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:nishauri/src/features/auth/data/respositories/auth_repository.dart';
import 'package:nishauri/src/features/auth/data/services/AuthApiService.dart';
import 'package:nishauri/src/features/lab/data/models/viral_load.dart';
import 'package:nishauri/src/shared/interfaces/HTTPService.dart';
import 'package:nishauri/src/utils/constants.dart';

class ViralLoadService extends HTTPService {
  final AuthRepository _repository = AuthRepository(AuthApiService());
  Future<List<ViralLoad>> getViralLoads() async {
    List<ViralLoad> viralLoads = [];
    try {
      final response = await call(getViralLoads_, null);
      if (response.statusCode == 200) {
        final responseString = await response.stream.bytesToString();
        final Map<String, dynamic> dataNew = json.decode(responseString);
        final List<dynamic> jsonList = dataNew['msg'];
        viralLoads.clear();
        viralLoads.addAll(jsonList.map((json) => ViralLoad.fromJson(json)));
      } else {
        throw "Failed to fetch data. Status code: ${response.statusCode}";
      }
    } catch (e) {
      throw "No VL Records Found";
    }
    return viralLoads;
  }

  Future<http.StreamedResponse> getViralLoads_(dynamic args) async {
    final id = await _repository.getUserId();
    final tokenPair = await getCachedToken();
    var headers = {'Authorization':"Bearer ${tokenPair.accessToken}",
      'Content-Type': 'application/json'};
    var url = '${Constants.BASE_URL_NEW}/vl_results?user_id=$id';
    final response = request(url: url, token: tokenPair, method: 'GET', requestHeaders: headers, userId: id);
    return response;
    // var request =
    // http.Request('GET', Uri.parse('${Constants.BASE_URL_NEW}/vl_results?user_id=$id'));
    // request.headers.addAll(headers);
    // return await request.send();
  }

  Future<void> saveViralLoad() async {
    try{
      final resp = await call(getViralLoads_, null);
      if (resp.statusCode == 200) {
        final responseString = await resp.stream.bytesToString();
        final respData = json.decode(responseString);
        if (respData["success"] == true){
          var msgList = List.from(respData['msg']);
          msgList.sort((a, b) => DateTime.parse(b['date']).compareTo(DateTime.parse(a['date'])));
          var latestResult = msgList.first;
          var viralLoad = latestResult["result"];
          var vlDate = latestResult["date"];
          await _repository.saveVL(viralLoad);
          await _repository.saveVlDate(vlDate);
        }
      }
    } catch (e) {
      throw e;
    }
  }
}
