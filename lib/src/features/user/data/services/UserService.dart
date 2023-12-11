import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:nishauri/src/features/auth/data/models/auth_state.dart';
import 'package:nishauri/src/features/user/data/models/user.dart';
import 'package:nishauri/src/shared/exeptions/http_exceptions.dart';
import 'package:nishauri/src/shared/interfaces/HTTPService.dart';
import 'package:nishauri/src/utils/constants.dart';
import 'package:nishauri/src/utils/helpers.dart';

class UserService extends HTTPService {
  final AuthState _authState;

  UserService(this._authState);

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
    await Future.delayed(const Duration(seconds: 3));
    // throw ValidationException({"dateOfBirth":'Invalid date of birth'});
    // _user = user;
    // return _user;
    return user;
  }

  Future<User> getUser() async {
    var request = http.Request('GET',
        Uri.parse('${Constants.BASE_URL}profile?user_id=${_authState.user}'));
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      // Success: Parse and return the User object
      final responseString = await response.stream.bytesToString();
      final userData = json.decode(responseString);
      Map<String, dynamic> data =
          userData["data"].isEmpty ? {} : userData["data"][0];
      return User.fromJson({
        "id": "",
        "username": data["phone_no"] ?? "",
        "phoneNumber": data["phone_no"] ?? "",
        "email": data["email"] ?? "",
        "name": data["client_name"] ?? "",
        // "lastName": userData["client_name"].toString().split(" ")[1],
        "gender": data["gender"] == "Female" ? "F" : "M"
      });
    } else {
      throw await getException(response);
    }
  }
}
