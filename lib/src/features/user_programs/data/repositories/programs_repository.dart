import 'package:nishauri/src/features/user_programs/data/models/program.dart';
import 'package:nishauri/src/features/user_programs/data/models/user_program.dart';
import 'package:nishauri/src/features/user_programs/data/services/programs_service.dart';

import '../models/program_verification_detail.dart';
import '../models/program_verificaton_contact.dart';


class ProgramsRepository {
  final ProgramService _service;

  ProgramsRepository(this._service);

  Future<List<Program>> getPrograms() async {
    return await _service.getPrograms();
  }
  Future<List<UserProgram>> getUserPrograms() async {
    return await _service.getUserPrograms();
  }

  Future<String> registerProgram(Map<String, dynamic> program)async{
    return await _service.registerProgram(program);
  }
  Future<String> updateProgram(Map<String, dynamic> data)async{
    return await _service.updateProgram(data);
  }

  Future<String> verifyProgramOTP(Map<String, dynamic> data)async{
    return await _service.verifyProgramOTP(data);
  }

  Future<Map<String, dynamic>> programVerification(Map<String, dynamic> data) async{
    return await _service.programVerification(data);
  }

  Future<String> resendOTP(Map<String, dynamic> data) async{
    return await _service.resendOTP(data);
  }
}
