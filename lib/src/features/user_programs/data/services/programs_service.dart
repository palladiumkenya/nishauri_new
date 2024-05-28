import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:nishauri/src/features/auth/data/respositories/auth_repository.dart';
import 'package:nishauri/src/features/auth/data/services/AuthApiService.dart';
import 'package:nishauri/src/features/user_programs/data/models/program.dart';
import 'package:nishauri/src/features/user_programs/data/models/program_verification_detail.dart';
import 'package:nishauri/src/features/user_programs/data/models/program_verificaton_contact.dart';
import 'package:nishauri/src/features/user_programs/data/models/user_program.dart';
import 'package:nishauri/src/shared/interfaces/HTTPService.dart';
import 'package:http/http.dart' as http;
import 'package:nishauri/src/utils/constants.dart';

class ProgramService extends HTTPService {
  final AuthRepository _repository = AuthRepository(AuthApiService());

  // final List<Program> _programs = [
  //   const Program(
  //     program_code: "HIV",
  //     name: "HIV Program",
  //     createdAt: "20th Oct 2023",
  //   ),
  //   const Program(
  //     program_code: "TB",
  //     name: "Tuberculosis Program",
  //     createdAt: "20th Oct 2023",
  //   ),
  //   const Program(
  //     program_code: "ASTHMA",
  //     name: "Asthma Program",
  //     createdAt: "20th Oct 2023",
  //   ),
  //   const Program(
  //     program_code: "DIABETES",
  //     name: "Diabetes Program",
  //     createdAt: "20th Oct 2023",
  //   ),
  //   const Program(
  //     program_code: "CANCER",
  //     name: "Cancer Program",
  //     createdAt: "20th Oct 2023",
  //   ),
  //   const Program(
  //     program_code: "HBP",
  //     name: "Hypertension",
  //     createdAt: "20th Oct 2023",
  //   ),
  // ];

  // final List<UserProgram> _userPrograms = [
  //   const UserProgram(
  //     program: Program(
  //       id: "1",
  //       program_code: "HIV",
  //       name: "HIV Program",
  //       createdAt: "20th Oct 2023",
  //     ),
  //     // user: "u-1",
  //     createdAt: "20th Oct 2023",
  //   ),
  //   const UserProgram(
  //     program: Program(
  //       id: "2",
  //       program_code: "TB",
  //       name: "Tuberculosis Program",
  //       createdAt: "20th Oct 2023",
  //     ),
  //     // user: "u-1",
  //     createdAt: "20th Oct 2023",
  //   ),
  //   const UserProgram(
  //     program: Program(
  //       id: "3",
  //       program_code: "ASTHMA",
  //       name: "Asthma Program",
  //       createdAt: "20th Oct 2023",
  //     ),
  //     // user: "u-1",
  //     createdAt: "20th Oct 2023",
  //   ),
  //   const UserProgram(
  //     program: Program(
  //       id: "4",
  //       program_code: "DIABETES",
  //       name: "Diabetes Program",
  //       createdAt: "20th Oct 2023",
  //     ),
  //     // user: "u-1",
  //     createdAt: "20th Oct 2023",
  //   ),
  // ];

  // Future<List<Program>> getPrograms() async {
  //   await Future.delayed(const Duration(seconds: 3));
  //   return _programs;
  // }
  Future<List<Program>> getPrograms() async {

      final response = await call(getPrograms_, null);
      print(response.statusCode);
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
    var request = http.Request('GET',
        Uri.parse('${Constants.BASE_URL_NEW}/user_programs?user_id=$id'));
    request.headers.addAll(headers);
    print(request.headers);
    return await request.send();
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
    var headers = {
      'Authorization': 'Bearer ${tokenPair.accessToken}',
      'Content-Type': 'application/json',
    };
    final data_ = Map.from(mergedData)
      ..removeWhere((key, value) => key == "program");
    var request =
        http.Request('POST', Uri.parse('${Constants.BASE_URL_NEW}/setprogram'));
    request.body = json.encode(data_);
    request.headers.addAll(headers);
    print(request.body);
    http.StreamedResponse response = await request.send();
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
    var request = http.Request(
        'POST', Uri.parse('${Constants.BASE_URL_NEW}/updateprogram'));
    request.body = json.encode(mergedData);
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
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
    var request = http.Request(
      'POST',
      Uri.parse(
          '${Constants.BASE_URL_NEW}/validateprograms'),
    );
    request.headers.addAll(headers);
    request.body = json.encode(mergedData);
    http.StreamedResponse response = await request.send();
    return response;
  }
}
