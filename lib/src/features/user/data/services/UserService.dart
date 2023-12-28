import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:nishauri/src/features/user/data/models/user.dart';
import 'package:nishauri/src/shared/interfaces/HTTPService.dart';
import 'package:nishauri/src/shared/models/token_pair.dart';
import 'package:nishauri/src/utils/constants.dart';
import 'package:nishauri/src/utils/helpers.dart';

class UserService extends HTTPService {
  final TokenPair _tokenPair;

  UserService(this._tokenPair);

  Future<void> uploadImage(File imageFile) async {
    var request = http.MultipartRequest(
        'POST', Uri.parse('http://127.0.0.1:5000/auth/login'));
    request.fields.addAll({'key': '345'});
    request.files.add(await http.MultipartFile.fromPath('img',
        '/C:/Users/Omosh/AppData/Local/Postman/app-10.19.7/d3dcompiler_47.dll'));
    request.files.add(await http.MultipartFile.fromPath(
        'img', '/C:/Users/Omosh/AppData/Local/Postman/app-10.19.7/ffmpeg.dll'));
    request.files.add(await http.MultipartFile.fromPath(
        'img', '/C:/Users/Omosh/AppData/Local/Postman/app-10.19.7/icudtl.dat'));

    request.files.add(await http.MultipartFile.fromPath(
      'image',
      imageFile.path,
    ));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }

  Future<User> updateProfile(User user) async {
    var headers = {'x-access-token': _tokenPair.accessToken};
    var request = http.MultipartRequest(
        'POST', Uri.parse('${Constants.BASE_URL}/auth/profile'));
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

  Future<User> getUser() async {
    var headers = {'x-access-token': _tokenPair.accessToken};
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
        "image": person["image"]!=null ? "${Constants.BASE_URL}/files/${person["image"]}" : null
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

  Future<String> accountVerify(Map<String, dynamic> data) async {
    var headers = {'x-access-token': _tokenPair.accessToken, 'Content-Type': 'application/json',};
    var request = http.Request('POST', Uri.parse('${Constants.BASE_URL}/auth/verify'));
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

  Future<String> requestVerificationCode(String? mode) async {
    var headers = {'x-access-token': _tokenPair.accessToken};
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
}
