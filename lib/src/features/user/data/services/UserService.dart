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
  Future<User> _updateProfile(User user) async {
    final tokenPair = await getCachedToken();
    // var headers = {'x-access-token': tokenPair.accessToken};
    var headers = {'Content-Type': 'application/json'};
    var request = http.MultipartRequest(
        'POST', Uri.parse('${Constants.BASE_URL_NEW}/profile'));
    // Serialize user data to JSON
    final userData = user.toJson();
    // Extract image path and remove it from user data
    final String? image = userData['image'];
    userData.remove('image');
    // Add headers to the request
    request.headers.addAll(headers);
    // Add form fields to the request
    userData.forEach((key, value) {
      if (value != null) {
        if (value is List) {
          // Handle lists (e.g., allergies, disabilities, chronics)
          for (var i = 0; i < value.length; i++) {
            request.fields['$key[$i]'] = value[i].toString();
          }
        } else {
          request.fields[key] = value.toString();
        }
      }
    });

    // Add the image file to the request
    if (image != null) {
      if (isNetworkUri(image)) {
        final remoteImageData = await _downloadRemoteImage(image);
        request.files.add(http.MultipartFile.fromBytes('image', remoteImageData,
            filename: '${userData['firstName']}.jpg'));
      } else {
        request.files.add(await http.MultipartFile.fromPath('image', image));
      }
    }

    // Send the request and get the response
    http.StreamedResponse response = await request.send();

    // Check the response status code

    if (response.statusCode == 200) {
      return user;
    } else {
      throw await getException(response);
    }
  }

  Future<http.StreamedResponse> updateProfile_(User user) async {
    final id = await _repository.getUserId();
    final tokenPair = await getCachedToken();
    final userId = {'user_id': id};
    final headers = {
      'Authorization': "Bearer ${tokenPair.accessToken}",
      'Content-Type': 'application/json'
    };

    final url = '${Constants.BASE_URL_NEW}setprofile';

    // Serialize user data to JSON
    final userData = user.toJson();
    // Add userId to userData
    userData.addAll(userId);
    // Extract image path and remove it from user data
    userData.remove('image');

    // Map the user data fields to the expected server field names
    final mappedUserData = {
      'user_id': id,
      'f_name': userData['firstName'] ?? '',
      'l_name': userData['lastName'] ?? '',
      'dob': userData['dateOfBirth'] ?? '',
      'gender': userData['gender'] ?? '',
      'email': userData['email'] ?? '',
      'phone_no': userData['phoneNumber'] ?? '',
      'landmark': userData['constituency'] ?? '',
      'weight': userData['weight'] ?? '',
      'primary_language': userData['primaryLanguage'] ?? '',
      'marital': userData['maritalStatus'] ?? '',
      'blood_group': userData['bloodGroup'] ?? '',
      'education': userData['educationLevel'] ?? '',
      'height': userData['height'] ?? '',
      'occupation': userData['occupation'] ?? '',
      'allergies': userData['allergies']?.isNotEmpty == true ? userData['allergies'][0] : '',
      'disabilities': userData['disabilities']?.isNotEmpty == true ? userData['disabilities'][0] : '',
      'chronics': userData['chronics']?.isNotEmpty == true ? userData['chronics'][0] : '',
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

  Future<User> updateProfile(User user) async {
    // Send the request and get the response
    final response = await updateProfile_(user);
    final responseString = await response.stream.bytesToString();
    final userData = json.decode(responseString);
    // Check the response status code
    if (response.statusCode == 200) {
      // Update user object if necessary
      // For now, just return the user object unchanged
      return user;
    } else {
      // Handle error appropriately, throw exception or return null
      throw 'Failed to update profile: Try Again in A few Seconds!';
    }
  }


  Future<User> __getUser() async {
    final tokenPair = await getCachedToken();
    var headers = {'x-access-token': tokenPair.accessToken};
    const url = '${Constants.BASE_URL}/auth/profile';
    final response = await request(url: url, token: tokenPair, method: "GET");

    if (response.statusCode == 200) {
      // Success: Parse and return the User object
      final responseString = await response.stream.bytesToString();
      final userData = json.decode(responseString);
      final Map<String, dynamic> person = userData["person"][0];
      person.remove("_id");
      return User.fromJson({
        ...userData,
        ...person,
        "name": "${person["firstName"]} ${person["lastName"]}",
        "id": userData["_id"],
        "image": person["image"] != null
            ? "${Constants.BASE_URL}/files/${person["image"]}"
            : null
      }); // Replace with your User object parsing logic
    } else {
      throw await getException(response);
    }
  }

  Future<User> getUser() async {
    final response = await call(getUser_, null);
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
      "username": "${person["profile"]["f_name"]} ${person["profile"]["l_name"]}",
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
    var headers = {'Authorization':"Bearer ${tokenPair.accessToken}",
      'Content-Type': 'application/json'};
    var request =
        http.Request('GET', Uri.parse('${Constants.BASE_URL_NEW}/get_profile?user_id=$id'));
    request.headers.addAll(headers);
    return await request.send();
  }

  Future<User> _getUser(dynamic args) async {
    final tokenPair = await getCachedToken();
    var headers = {'x-access-token': tokenPair.accessToken};
    var request =
        http.Request('GET', Uri.parse('${Constants.BASE_URL}/auth/profile'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      // Success: Parse and return the User object
      final responseString = await response.stream.bytesToString();
      final userData = json.decode(responseString);
      final Map<String, dynamic> person = userData["person"][0];
      person.remove("_id");
      return User.fromJson({
        ...userData,
        ...person,
        "name": "${person["firstName"]} ${person["lastName"]}",
        "id": userData["_id"],
        "image": person["image"] != null
            ? "${Constants.BASE_URL}/files/${person["image"]}"
            : null
      }); // Replace with your User object parsing logic
    } else {
      throw await getException(response);
    }
  }

  Future<Uint8List> _downloadRemoteImage(String remoteImagePath) async {
    final response = await http.get(Uri.parse(remoteImagePath));
    if (response.statusCode == 200) {
      return response.bodyBytes;
    } else {
      throw Exception('Failed to download remote image');
    }
  }

  Future<String> _accountVerify(Map<String, dynamic> data) async {
    final tokenPair = await getCachedToken();
    var headers = {
      'x-access-token': tokenPair.accessToken,
      'Content-Type': 'application/json',
    };
    var request =
        http.Request('POST', Uri.parse('${Constants.BASE_URL}/auth/verify'));
    request.body = jsonEncode(data);
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      final responseString = await response.stream.bytesToString();
      final userData = json.decode(responseString);
      return userData["detail"];
    } else {
      throw await getException(response);
    }
  }

  Future<String> accountVerify(Map<String, dynamic> data) async {
    http.StreamedResponse response = await call(accountVerify_, data);
    String message = '';
    try{
      if (response.statusCode == 200) {
        final responseString = await response.stream.bytesToString();
        final userData = json.decode(responseString);
        bool messageServer = userData["success"];

        if (messageServer == true){
          await _repository.saveIsVerified(true);
          message = userData["msg"];
        }
        else{
          throw userData["msg"];
        }
      }
    } catch (e)
    {
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
    var request =
        http.Request('POST', Uri.parse('${Constants.BASE_URL_NEW}verifyotp'));
    request.body = jsonEncode(mergedData);
    request.headers.addAll(headers);
    return await request.send();
  }

  Future<String> _requestVerificationCode(String? mode) async {
    final tokenPair = await getCachedToken();
    var headers = {'x-access-token': tokenPair.accessToken};
    var request = http.Request(
        'GET', Uri.parse('${Constants.BASE_URL}/auth/verify?mode=$mode'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final responseString = await response.stream.bytesToString();
      final userData = json.decode(responseString);
      return userData["detail"];
    } else {
      throw await getException(response);
    }
  }

  Future<http.StreamedResponse> requestVerificationCode_(String? mode) async {
    final id = await _repository.getUserId();
    final tokenPair = await getCachedToken();
    var headers = {'Authorization': "Bearer ${tokenPair.accessToken}",
      'Content-Type': 'application/json',};
    var body = {'user_id': id};
    var request = http.Request(
        'POST', Uri.parse('${Constants.BASE_URL_NEW}sendotp'));
    request.body = jsonEncode(body);
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    return response;
  }

  Future<String> requestVerificationCode(String? mode) async {
    http.StreamedResponse response =
        await call<String?>(requestVerificationCode_, mode);

    final responseString = await response.stream.bytesToString();
    final userData = json.decode(responseString);
    return userData["msg"];
  }
}
