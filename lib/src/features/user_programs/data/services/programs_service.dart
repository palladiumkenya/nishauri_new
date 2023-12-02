import 'package:nishauri/src/features/user_programs/data/models/program.dart';
import 'package:nishauri/src/features/user_programs/data/models/user_program.dart';
import 'package:nishauri/src/shared/exeptions/http_exceptions.dart';
import 'package:nishauri/src/shared/interfaces/HTTPService.dart';

class ProgramService extends HTTPService {
  final String _token;
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

  ProgramService(this._token);

  Future<List<Program>> getPrograms() async {
    await Future.delayed(const Duration(seconds: 3));
    return _programs;
  }

  Future<List<UserProgram>> getUserPrograms() async {
    return _userPrograms;
  }

  Future<String> registerProgram(Map<String, dynamic> data) async {
    await Future.delayed(const Duration(seconds: 3));
    return "OTP sent to 254793****58";
  }
  Future<UserProgram> verifyProgramOTP(Map<String, dynamic> data) async {
    await Future.delayed(const Duration(seconds: 3));
    final userProgram = UserProgram(
        program: _programs
            .where((element) => element.programCode == data["program"])
            .first,
        user: "u-1",
        createdAt: "25th Aug 2023");
    _userPrograms.add(userProgram);
    return userProgram;
  }
}
