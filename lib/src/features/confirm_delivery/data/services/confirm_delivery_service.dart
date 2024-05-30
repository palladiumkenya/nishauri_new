import 'dart:convert';

import 'package:http/http.dart';
import 'package:nishauri/src/features/auth/data/respositories/auth_repository.dart';
import 'package:nishauri/src/features/auth/data/services/AuthApiService.dart';
import 'package:nishauri/src/shared/interfaces/HTTPService.dart';
import 'package:nishauri/src/utils/constants.dart';

class ConfirmDeliveryService extends HTTPService {
  final AuthRepository _repository = AuthRepository(AuthApiService());

  Future<StreamedResponse> confirmDelivery_(Map<String, dynamic> data) async {
    final id = await _repository.getUserId();
    final token = await getCachedToken();
    // final userId = {'user_id': id};
    // var mergedData = {...data, ...userId};
    var headers = {
      'Authorization': 'Bearer ${token.accessToken}',
      'Content-Type': 'application/json',
    };
    var url = '${Constants.BASE_URL_NEW}/delivery_confirmation';
    final response = request(url: url, token: token, method: 'POST', requestHeaders: headers, data: data, userId: id);
    // var request = Request(
    //   'POST',
    //   Uri.parse('${Constants.BASE_URL_NEW}/delivery_confirmation'),
    // );
    // request.body = json.encode(data);
    // request.headers.addAll(headers);
    // print(request.body);
    // return await request.send();
    return response;
  }

  Future<String> confirmDelivery(Map<String, dynamic> data) async {
    try{
      final response = await call<Map<String, dynamic>>(confirmDelivery_, data);
      if (response.statusCode == 200){
        final responseString = await response.stream.bytesToString();
        final Map<String, dynamic> responseData = json.decode(responseString);
        if (responseData["success"] == true){
          return responseData["msg"];
        } else {
          throw responseData["msg"];
        }
      } else {
        throw "Something Went Wrong, Try Again";
      }
    }catch (e){
      throw "Something Went Wrong, Try Again";
    }
  }
}