import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:nishauri/src/features/user/data/models/user.dart';
import 'package:nishauri/src/shared/exeptions/http_exceptions.dart';
import 'package:nishauri/src/shared/interfaces/HTTPService.dart';
import 'package:nishauri/src/utils/constants.dart';

class UserService extends HTTPService {
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

  Future<User> getUser(String token) async {
    var headers = {'x-auth-token': token};
    var request =
        http.Request('GET', Uri.parse('${Constants.BASE_URL}auth/profile'));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      // Success: Parse and return the User object
      final responseString = await response.stream.bytesToString();
      final userData = json.decode(responseString);
      return User.fromJson(
          userData); // Replace with your User object parsing logic
    } else {
      throw await getException(response);
    }
  }
}