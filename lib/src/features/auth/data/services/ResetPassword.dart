import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:nishauri/src/features/auth/data/respositories/auth_repository.dart';
import 'package:nishauri/src/features/auth/data/services/AuthApiService.dart';
import 'package:nishauri/src/features/user/data/models/user.dart';
import 'package:nishauri/src/features/user/data/respositories/UserRepository.dart';
import 'package:nishauri/src/shared/interfaces/HTTPService.dart';
import 'package:nishauri/src/shared/models/token_pair.dart';
import 'package:nishauri/src/utils/constants.dart';
import 'package:nishauri/src/utils/helpers.dart';

class ResetPasswordService extends HTTPService {
  final AuthRepository _repository = AuthRepository(AuthApiService());
   Future<http.StreamedResponse> resetPassword_(Map<String, dynamic> data) async {
     var headers = {
       'Content-Type': 'application/json',
     };
     var request =
     http.Request('POST', Uri.parse('${Constants.BASE_URL_NEW}resetpassword'));
     request.body = jsonEncode(data);
     request.headers.addAll(headers);
     return await request.send();
   }

   Future<String> resetPassword(Map<String, dynamic> data) async {
     http.StreamedResponse response = await call(resetPassword_, data);
     try{
       if (response.statusCode == 200) {
         final responseString = await response.stream.bytesToString();
         final userData = json.decode(responseString);
         if (userData["success"] == true)
           {
             return userData["msg"];
           } else {
           throw userData["msg"];
         }
       }
     } catch (e)
     {
       throw "$e";
     }
     return "";
   }

   Future<http.StreamedResponse> verifyResetPassword_(Map<String, dynamic> data) async {
     var headers = {
       'Content-Type': 'application/json',
     };
     var request =
     http.Request('POST', Uri.parse('${Constants.BASE_URL_NEW}verifyresetpassotp'));
     request.body = jsonEncode(data);
     request.headers.addAll(headers);
     return await request.send();
   }

   Future<String> verifyResetPassword(Map<String, dynamic> data) async {
     http.StreamedResponse response = await call(verifyResetPassword_, data);
     try{
       if (response.statusCode == 200) {
         final responseString = await response.stream.bytesToString();
         final userData = json.decode(responseString);
         if (userData["success"] == true)
         {
           return userData["msg"];
         } else {
           throw userData["msg"];
         }
       }
     } catch (e)
     {
       throw "$e";
     }
     return "";
   }

   Future<String> changePassword(Map<String, dynamic> data) async {
     http.StreamedResponse response = await call(changePassword_, data);
     try{
       if (response.statusCode == 200) {
         final responseString = await response.stream.bytesToString();
         final userData = json.decode(responseString);
         if (userData["success"] == true)
         {
           return userData["msg"];
         } else {
           throw userData["msg"];
         }
       }
     } catch (e)
     {
       throw "$e";
     }
     return "";
   }

   Future<http.StreamedResponse> changePassword_(Map<String, dynamic> data) async {
     var headers = {
       'Content-Type': 'application/json',
     };
     var request =
     http.Request('POST', Uri.parse('${Constants.BASE_URL_NEW}changepassword'));
     request.body = jsonEncode(data);
     request.headers.addAll(headers);
     print(request);
     print(request.body);
     return await request.send();
   }

   Future<String> updatePassword(Map<String, dynamic> data) async {
     http.StreamedResponse response = await call(updatePassword_, data);
     try{
       if (response.statusCode == 200) {
         final responseString = await response.stream.bytesToString();
         final userData = json.decode(responseString);
         if (userData["success"] == true)
         {
           return userData["msg"];
         } else {
           throw userData["msg"];
         }
       }
     } catch (e)
     {
       throw "$e";
     }
     return "";
   }

   Future<http.StreamedResponse> updatePassword_(Map<String, dynamic> data) async {
     final id = await _repository.getUserId();
     var headers = {
       'Content-Type': 'application/json',
     };
     var request =
     http.Request('POST', Uri.parse('${Constants.BASE_URL_NEW}updatepassword?user_id=$id'));
     request.body = jsonEncode(data);
     request.headers.addAll(headers);
     print(request);
     print(request.body);
     return await request.send();
   }
}