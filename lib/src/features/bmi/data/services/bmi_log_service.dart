import 'dart:convert';

import 'package:http/http.dart';
import 'package:nishauri/src/features/auth/data/respositories/auth_repository.dart';
import 'package:nishauri/src/features/auth/data/services/AuthApiService.dart';
import 'package:nishauri/src/features/bmi/data/model/bmi_log.dart';
import 'package:http/http.dart' as http;
import 'package:nishauri/src/shared/interfaces/HTTPService.dart';
import 'package:nishauri/src/shared/models/token_pair.dart';

class BMILogService extends HTTPService{
  final AuthRepository _repository = AuthRepository(AuthApiService());

  Future<String> logBMI(Map<String, dynamic> data) async{
    try{
      final response = await call<Map<String, dynamic>> (logBMI_, data);
      final responseString = await response.stream.bytesToString();
      final responseData = jsonDecode(responseString);

      if(responseData["success"] == false) {
        throw responseData["msg"];
      }
      else{
        return responseData["msg"];
      }
    }
    catch(e) {
      print("Error logging BMI: $e");
      throw "Please check your internet connection";
    }
  } 

  Future <StreamedResponse> logBMI_(Map<String, dynamic> data) async {
    final TokenPair = await getCachedToken();
    final id = await _repository.getUserId();
    final userId = {'user_id': id};
    var headers = {
      'Authorization': 'Bearer ${TokenPair.accessToken}',
      'Content-Type': 'application/json',
    };
    //awaiting endpoint to use as url
    const url = 'awaiting endpoints';
    final payload = {...userId, ...data};
    final request = http.Request('POST', Uri.parse(url));
    request.headers.addAll(headers);
    request.body = json.encode(payload);
    print(request.body);

    final response = await request.send();

    return response;
  }

}