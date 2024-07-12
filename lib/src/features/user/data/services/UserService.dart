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

class UserService extends HTTPService {
  final AuthRepository _repository = AuthRepository(AuthApiService());

  Future<http.StreamedResponse> updateProfile_(
      Map<String, dynamic> user) async {
    final id = await _repository.getUserId();
    final tokenPair = await getCachedToken();
    final userId = {'user_id': id};
    final headers = {
      'Authorization': "Bearer ${tokenPair.accessToken}",
      'Content-Type': 'application/json'
    };

    const url = '${Constants.BASE_URL_NEW}setprofile';

    // Serialize user data to JSON
    final userData = user;
    // Add userId to userData
    userData.addAll(userId);
    // Extract image path and remove it from user data
    userData.remove('image');

    // Map the user data fields to the expected server field names
    final mappedUserData = {
      'user_id': id,
      ...userData,
      'allergies': userData['allergies']?.join(",") ?? '',
      'disabilities': userData['disabilities']?.join(",") ?? '',
      'chronics': userData['chronics']?.join(",") ?? '',
      // Map other fields as needed
      // Ensure you handle null values appropriately
    };

    final request = http.Request('POST', Uri.parse(url));
    // Add headers to the request
    request.headers.addAll(headers);
    // Convert the user data to JSON and set it as the request body
    request.body = json.encode(mappedUserData);

    // Send the request and get the response
    final response = await request.send();
    return response;
  }

  Future<void> updateProfile(Map<String, dynamic> user) async {
    // Send the request and get the response
    final response = await updateProfile_(user);
    final responseString = await response.stream.bytesToString();
    final userData = json.decode(responseString);
    // Check the response status code
    if (response.statusCode == 200) {
      // Update user object if necessary
      // For now, just return the user object unchanged
      return; //user;
    } else {
      // Handle error appropriately, throw exception or return null
      throw 'Failed to update profile: Try Again in A few Seconds!';
    }
  }

  Future<User> getUser() async {
    final response = await call(getUser_, null);
    print(response.statusCode);
    final responseString = await response.stream.bytesToString();
    final userData = json.decode(responseString);
    final Map<String, dynamic> person = userData["data"];
    person.remove("user_id");
    return User.fromJson({
      ...userData,
      ...person,
      "name": "${person["profile"]["f_name"]} ${person["profile"]["l_name"]}",
      "id": userData["user_id"],
      "firstName": person["profile"]["f_name"],
      "lastName": person["profile"]["l_name"],
      "bloodGroup": person["profile"]["blood_group"],
      "maritalStatus": person["profile"]["marital"],
      "primaryLanguage": person["profile"]["primary_language"],
      "educationLevel": person["profile"]["education"],
      "constituency": person["profile"]["landmark"],
      "image": "image",
      "username":
          "${person["profile"]["f_name"]} ${person["profile"]["l_name"]}",
      "email": person["profile"]["email"],
      "phoneNumber": person["profile"]["phone_no"],
      "dateOfBirth": person["profile"]["dob"],
      "occupation": person["profile"]["occupation"],
      "height": person["profile"]["height"],
      "weight": person["profile"]["weight"],
      "allergies": person["profile"]["allergies"],
      "disabilities": person["profile"]["disabilities"],
      "chronics": person["profile"]["chronics"],
      "gender": person["profile"]["gender"],
    });
  }

  Future<http.StreamedResponse> getUser_(dynamic args) async {
    final id = await _repository.getUserId();

    final tokenPair = await getCachedToken();
    var headers = {
      'Authorization': "Bearer ${tokenPair.accessToken}",
      'Content-Type': 'application/json'
    };
    print('user token : $tokenPair');
    var url = '${Constants.BASE_URL_NEW}/get_profile?user_id=$id';
    final response = await request(url: url, token: tokenPair, method: 'GET', requestHeaders: headers, userId: id);
    // var request = http.Request(
    //     'GET', Uri.parse('${Constants.BASE_URL_NEW}/get_profile?user_id=$id'));
    // request.headers.addAll(headers);
    return response;
  }

  int calculateAge(String dob) {
    if (dob.isEmpty) return 0;
    DateTime dateOfBirth = DateTime.parse(dob);
    DateTime now = DateTime.now();

    int age = now.year - dateOfBirth.year;

    if (now.month < dateOfBirth.month ||
        (now.month == dateOfBirth.month && now.day < dateOfBirth.day)) {
      age--;
    }

    return age;
  }


  Future<void> saveGenderAge() async {
    try{
      final resp = await call(getUser_, null);
      if (resp.statusCode == 200) {
        final responseString = await resp.stream.bytesToString();
        final respData = json.decode(responseString);
        if (respData["success"] == true) {
          final gender = respData["data"]["profile"]["gender"];
          final dob = respData["data"]["profile"]["dob"];
          await _repository.saveGender(gender);
          await _repository.saveAge(calculateAge(dob).toString());
        }
        else{
          throw respData["msg"];
        }
      }
    } catch (e) {
      throw e;
    }
  }
  Future<String> accountVerify(Map<String, dynamic> data) async {
    http.StreamedResponse response = await call(accountVerify_, data);
    String message = '';
    try {
      if (response.statusCode == 200) {
        final responseString = await response.stream.bytesToString();
        final userData = json.decode(responseString);
        bool messageServer = userData["success"];

        if (messageServer == true) {
          await _repository.saveIsVerified(true);
          message = userData["msg"];
        } else {
          throw userData["msg"];
        }
      }
    } catch (e) {
      rethrow;
    }
    return message;
  }

  Future<http.StreamedResponse> accountVerify_(
      Map<String, dynamic> data) async {
    final id = await _repository.getUserId();
    var user = {'user_id': id};
    var mergedData = {...data, ...user};
    final tokenPair = await getCachedToken();
    var headers = {
      'Authorization': "Bearer ${tokenPair.accessToken}",
      'Content-Type': 'application/json',
    };
    var url = '${Constants.BASE_URL_NEW}verifyotp';
    final response = await request(url: url, token: tokenPair, method: 'POST', requestHeaders: headers, data: mergedData, userId: id);
    // var request =
    //     http.Request('POST', Uri.parse('${Constants.BASE_URL_NEW}verifyotp'));
    // request.body = jsonEncode(mergedData);
    // request.headers.addAll(headers);
    // return await request.send();
    return response;
  }

  Future<http.StreamedResponse> requestVerificationCode_(String? mode) async {
    final id = await _repository.getUserId();
    final tokenPair = await getCachedToken();
    var headers = {
      'Authorization': "Bearer ${tokenPair.accessToken}",
      'Content-Type': 'application/json',
    };
    var body = {'user_id': id};
    var url = '${Constants.BASE_URL_NEW}sendotp';
    final response = request(url: url, token: tokenPair, method: 'POST', requestHeaders: headers, userId: id, data: body);
    // var request =
    //     http.Request('POST', Uri.parse('${Constants.BASE_URL_NEW}sendotp'));
    // request.body = jsonEncode(body);
    // request.headers.addAll(headers);
    // http.StreamedResponse response = await request.send();
    return response;
  }

  Future<String> requestVerificationCode(String? mode) async {
    http.StreamedResponse response =
        await call<String?>(requestVerificationCode_, mode);

    final responseString = await response.stream.bytesToString();
    final userData = json.decode(responseString);
    return userData["msg"];
  }

  Future<String> revokeToken() async {
    final id = await _repository.getUserId();
    final tokenPair = await getCachedToken();
    var data = {"token": tokenPair.refreshToken, "user_id" : id};
    var headers = {'Content-Type': 'application/json'};
    var request =
    http.Request('POST', Uri.parse('${Constants.BASE_URL_NEW}/revoke_token'));
    request.body = json.encode(data);
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {

      final responseString = await response.stream.bytesToString();
      final respData = jsonDecode(responseString);
      if(respData["success"] == true){
        return respData['msg'];
      }else {
        throw respData['msg'];
      }
    } else {
      print('-->revokeToken ${await getException(response)}');
      throw await getException(response);
    }
  }
}
