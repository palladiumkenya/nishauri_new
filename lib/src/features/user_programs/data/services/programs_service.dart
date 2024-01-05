import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:nishauri/src/features/user_programs/data/models/program.dart';
import 'package:nishauri/src/features/user_programs/data/models/program_verification_detail.dart';
import 'package:nishauri/src/features/user_programs/data/models/program_verificaton_contact.dart';
import 'package:nishauri/src/features/user_programs/data/models/user_program.dart';
import 'package:nishauri/src/shared/interfaces/HTTPService.dart';
import 'package:http/http.dart' as http;
import 'package:nishauri/src/utils/constants.dart';

class ProgramService extends HTTPService {
  final List<Program> _programs = [
    const Program(
      programCode: "HIV",
      name: "HIV Program",
      createdAt: "20th Oct 2023",
    ),
    const Program(
      programCode: "TB",
      name: "Tuberculosis Program",
      createdAt: "20th Oct 2023",
    ),
    const Program(
      programCode: "ASTHMA",
      name: "Asthma Program",
      createdAt: "20th Oct 2023",
    ),
    const Program(
      programCode: "DIABETES",
      name: "Diabetes Program",
      createdAt: "20th Oct 2023",
    ),
    const Program(
      programCode: "CANCER",
      name: "Cancer Program",
      createdAt: "20th Oct 2023",
    ),
    const Program(
      programCode: "HBP",
      name: "Hypertension",
      createdAt: "20th Oct 2023",
    ),
  ];
  final List<UserProgram> _userPrograms = [
    // const UserProgram(
    //   program: Program(
    //     programCode: "HIV",
    //     name: "HIV Program",
    //     createdAt: "20th Oct 2023",
    //   ),
    //   user: "u-1",
    //   createdAt: "20th Oct 2023",
    // ),
    // const UserProgram(
    //   program: Program(
    //     programCode: "TB",
    //     name: "Tuberculosis Program",
    //     createdAt: "20th Oct 2023",
    //   ),
    //   user: "u-1",
    //   createdAt: "20th Oct 2023",
    // ),
    // const UserProgram(
    //   program: Program(
    //     programCode: "ASTHMA",
    //     name: "Asthma Program",
    //     createdAt: "20th Oct 2023",
    //   ),
    //   user: "u-1",
    //   createdAt: "20th Oct 2023",
    // ),
    // const UserProgram(
    //   program: Program(
    //     programCode: "DIABETES",
    //     name: "Diabetes Program",
    //     createdAt: "20th Oct 2023",
    //   ),
    //   user: "u-1",
    //   createdAt: "20th Oct 2023",
    // ),
    // const UserProgram(
    //   program: Program(
    //     programCode: "CANCER",
    //     name: "Cancer Program",
    //     createdAt: "20th Oct 2023",
    //   ),
    //   user: "u-1",
    //   createdAt: "20th Oct 2023",
    // ),
    // const UserProgram(
    //   program: Program(
    //     programCode: "HBP",
    //     name: "Hypertension",
    //     createdAt: "20th Oct 2023",
    //   ),
    //   user: "u-1",
    //   createdAt: "20th Oct 2023",
    // ),
  ];

  Future<List<Program>> getPrograms() async {
    await Future.delayed(const Duration(seconds: 3));
    return _programs;
  }

  Future<List<UserProgram>> getUserPrograms() async {
    return _userPrograms;
  }

  Future<ProgramVerificationDetail> registerProgram(Map<String, dynamic> data) async {
    http.StreamedResponse response = await call<Map<String, dynamic>>(registerProgram_, data);
    final responseString = await response.stream.bytesToString();
    final responseData = jsonDecode(responseString);
    return ProgramVerificationDetail.fromJson(responseData);

  }
  Future<http.StreamedResponse> registerProgram_(Map<String, dynamic> data) async {
    final tokenPair = await getCachedToken();
    var headers = {'x-access-token': tokenPair.accessToken, 'Content-Type': 'application/json',};
    final data_ = Map.from(data)
      ..removeWhere((key, value) => key == "program");
    var request = http.Request(
        'POST', Uri.parse('${Constants.BASE_URL}/patients/programs/register/'));
    request.body = json.encode(data_);
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    return response;
  }

  Future<UserProgram> verifyProgramOTP(Map<String, dynamic> data) async {
    await Future.delayed(const Duration(seconds: 3));
    final userProgram = UserProgram(
        program: _programs
            .where((element) => element.programCode == data["program"])
            .first,
        createdAt: "25th Aug 2023");
    _userPrograms.add(userProgram);
    return userProgram;
  }
}
