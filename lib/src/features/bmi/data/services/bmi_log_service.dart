import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:nishauri/src/features/auth/data/respositories/auth_repository.dart';
import 'package:nishauri/src/features/auth/data/services/AuthApiService.dart';
import 'package:nishauri/src/features/bmi/data/model/bmi_log.dart';
import 'package:http/http.dart' as http;
import 'package:nishauri/src/shared/interfaces/HTTPService.dart';
import 'package:nishauri/src/shared/models/token_pair.dart';
import 'package:nishauri/src/utils/constants.dart';

class BMILogService extends HTTPService{
  final AuthRepository _repository = AuthRepository(AuthApiService());

  Future<String> logBMI(Map<String, dynamic> data) async{
    
    try{
      final response = await call<Map<String, dynamic>> (logBMI_, data);
      debugPrint("Response status code: ${response.statusCode}");
      if (response.statusCode == 200) {       
        final responseString = await response.stream.bytesToString();
        final responseData = jsonDecode(responseString);
        print("Sucessfully sent data to end point");
        if(responseData["success"] == true) {
          return responseData["msg"];
        }
        else{
          throw responseData["msg"];
        }

      }
      else{
        throw "Something Went Wrong Try Again Later ${response.statusCode}";
      }
    }
    catch(e) {
      print("Error logging BMI: $e");
      throw "$e";
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
    var url = '${Constants.BASE_URL_NEW}/post_bmi';
    final payload = {...data, ...userId};
    debugPrint("Data payload: $payload");
    
    final response = request(
      url: url, 
      token: TokenPair, 
      method: 'POST', 
      requestHeaders: headers, 
      userId: id,
      data: payload,
      );
    return response;

}


}

