import 'dart:convert';
import 'package:nishauri/src/features/auth/data/respositories/auth_repository.dart';
import 'package:nishauri/src/features/auth/data/services/AuthApiService.dart';
import 'package:nishauri/src/features/user_programs/data/models/program.dart';
import 'package:nishauri/src/features/user_programs/data/models/user_program.dart';
import 'package:nishauri/src/shared/interfaces/HTTPService.dart';
import 'package:http/http.dart' as http;
import 'package:nishauri/src/utils/constants.dart';

class ProgramService extends HTTPService {
  final AuthRepository _repository = AuthRepository(AuthApiService());
  Future<List<Program>> getPrograms() async {

      final response = await call(getPrograms_, null);
      if (response.statusCode == 200) {
        final responseString = await response.stream.bytesToString();
        final List<dynamic> programData = json.decode(responseString)["programs"];
        return programData.map((e) {
          return Program.fromJson({
            ...e,
          });
        }).toList();
      } else {
        throw Exception("Failed to load programs, please try again.");
      }
  }

  Future<http.StreamedResponse> getPrograms_(dynamic args) async {
    var headers = {
      'Content-Type': 'application/json',
    };
    var request = http.Request('GET',
        Uri.parse('${Constants.BASE_URL_NEW}/get_program'));
    request.headers.addAll(headers);
    print(request.headers);
    return await request.send();
  }

  Future<List<UserProgram>> getUserPrograms() async {
    try {
      final response = await call(getUserPrograms_, null);
      if (response.statusCode == 200) {
        final responseString = await response.stream.bytesToString();
        final List<dynamic> programData =
            json.decode(responseString)["programs"];
        return programData
            .map((e) => UserProgram.fromJson({
                  ...e,
                  "createdAt": e["enrolled_date"],
                  "id": e['program_id'].toString(),
                  "isActive": e['is_active'] == "1",
                }))
            .toList();
      } else {
        throw "Something Went Wrong Contact Try Again";
      }
    } catch (e) {
      throw "Please check your internet connection";
    }
  }

  Future<http.StreamedResponse> getUserPrograms_(dynamic args) async {
    final tokenPair = await getCachedToken();
    final id = await _repository.getUserId();
    var headers = {
      'Authorization': 'Bearer ${tokenPair.accessToken}',
      'Content-Type': 'application/json',
    };
    var url = '${Constants.BASE_URL_NEW}/user_programs?user_id=$id';
    final response = request(url: url, token: tokenPair, method: 'GET', requestHeaders: headers, userId: id);
    return response;
    // var request = http.Request('GET',
    //     Uri.parse('${Constants.BASE_URL_NEW}/user_programs?user_id=$id'));
    // request.headers.addAll(headers);
    // print(request.headers);
    // return await request.send();
  }

  Future<String> registerProgram(Map<String, dynamic> data) async {
    http.StreamedResponse response =
        await call<Map<String, dynamic>>(registerProgram_, data);
    final responseString = await response.stream.bytesToString();
    final responseData = jsonDecode(responseString);
    if (responseData["success"] == false) {
      throw responseData["msg"];
    } else {
      return responseData["msg"];
    }
    // return ProgramVerificationDetail.fromJson(responseData);
  }

  Future<http.StreamedResponse> registerProgram_(
      Map<String, dynamic> data) async {
    final tokenPair = await getCachedToken();
    final id = await _repository.getUserId();

    // Parse program_id to integer
    final programId = int.parse(data['program_id'].toString());

    var user = {'user_id': id};
    var mergedData = {...data, ...user, 'program_id': programId};
    print(mergedData);
    var headers = {
      'Authorization': 'Bearer ${tokenPair.accessToken}',
      'Content-Type': 'application/json',
    };
    var url = '${Constants.BASE_URL_NEW}/setprogram';
    final response = request(url: url, token: tokenPair, method: 'POST', requestHeaders: headers, data: mergedData, userId: id);
    // var request =
    //     http.Request('POST', Uri.parse('${Constants.BASE_URL_NEW}/setprogram'));
    // request.body = json.encode(data_);
    // request.headers.addAll(headers);
    // print(request.body);
    // http.StreamedResponse response = await request.send();
    return response;
  }

  Future<String> updateProgram(Map<String, dynamic> data) async {
    http.StreamedResponse response =
        await call<Map<String, dynamic>>(updateProgram_, data);
    if (response.statusCode == 200) {
      final responseString = await response.stream.bytesToString();
      final responseData = jsonDecode(responseString);
      if (responseData["success"] == true) {
        return responseData["msg"];
      } else {
        throw responseData["msg"];
      }
    } else {
      throw "Something happened contact admin";
    }
  }

  Future<http.StreamedResponse> updateProgram_(
      Map<String, dynamic> data) async {
    final tokenPair = await getCachedToken();
    final id = await _repository.getUserId();
    var user = {'user_id': id};
    var mergedData = {...data, ...user};
    var headers = {
      'Authorization': 'Bearer ${tokenPair.accessToken}',
      'Content-Type': 'application/json',
    };
    var url = '${Constants.BASE_URL_NEW}/updateprogram';
    final response = request(url: url, token: tokenPair, method: 'POST', requestHeaders: headers, data: mergedData, userId: id);
    // var request = http.Request(
    //     'POST', Uri.parse('${Constants.BASE_URL_NEW}/updateprogram'));
    // request.body = json.encode(mergedData);
    // request.headers.addAll(headers);
    // http.StreamedResponse response = await request.send();
    return response;
  }

  Future<String> verifyProgramOTP(Map<String, dynamic> data) async {
    http.StreamedResponse response =
        await call<Map<String, dynamic>>(verifyProgramOTP_, data);
    final responseString = await response.stream.bytesToString();
    final responseData = jsonDecode(responseString);
    return responseData["detail"];
  }

  Future<http.StreamedResponse> verifyProgramOTP_(
      Map<String, dynamic> data) async {
    final tokenPair = await getCachedToken();
    var headers = {
      'x-access-token': tokenPair.accessToken,
      'Content-Type': 'application/json',
    };
    var request = http.Request(
      'POST',
      Uri.parse('${Constants.BASE_URL}/patients/programs/verify/'),
    );
    request.body = jsonEncode(data);
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    return response;
  }

  Future<Map<String, dynamic>> programVerification(Map<String, dynamic> data) async {
    http.StreamedResponse response =
        await call<Map<String, dynamic>>(programVerification_, data);
    if(response.statusCode == 200){
      final responseString = await response.stream.bytesToString();
      final responseData = jsonDecode(responseString);
      if (responseData["success"] == true){
        return responseData;
      }
      else {
        throw responseData["msg"];
      }
    }
    else{
      throw "Something went wrong";
    }
  }

  Future<http.StreamedResponse> programVerification_(
      Map<String, dynamic> data) async {
    final id = await _repository.getUserId();
    var user = {'user_id': id};
    var mergedData = {...data, ...user};
    final tokenPair = await getCachedToken();
    var headers = {
      'Authorization': 'Bearer ${tokenPair.accessToken}',
      'Content-Type': 'application/json',
    };
    var url = '${Constants.BASE_URL_NEW}/validateprograms';
    final response = request(url: url, token: tokenPair, method: 'POST', requestHeaders: headers, data: mergedData, userId: id);
    // var request = http.Request(
    //   'POST',
    //   Uri.parse(
    //       '${Constants.BASE_URL_NEW}/validateprograms'),
    // );
    // request.headers.addAll(headers);
    // request.body = json.encode(mergedData);
    // http.StreamedResponse response = await request.send();
    return response;
  }

  Future<http.StreamedResponse> resendOTP_(Map<String, dynamic> data) async {
    final tokenPair = await getCachedToken();
    final id = await _repository.getUserId();

    // Parse program_id to integer
    final programId = int.parse(data['program_id'].toString());
    final ccc = data['ccc_no'];
    var mergedData = {'program_id': programId, 'ccc_no': ccc, 'user_id': id};
    print(mergedData);
    var headers = {
      'Authorization': 'Bearer ${tokenPair.accessToken}',
      'Content-Type': 'application/json',
    };
    var url = '${Constants.BASE_URL_NEW}resendotp';
    final response = request(url: url, token: tokenPair, method: 'POST', requestHeaders: headers, data: mergedData, userId: id);
    // var request =
    //     http.Request('POST', Uri.parse('${Constants.BASE_URL_NEW}/setprogram'));
    // request.body = json.encode(data_);
    // request.headers.addAll(headers);
    // print(request.body);
    // http.StreamedResponse response = await request.send();
    return response;
  }

  Future<String> resendOTP(Map<String, dynamic> data) async {
    http.StreamedResponse response = await call(resendOTP_, data);
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
}
