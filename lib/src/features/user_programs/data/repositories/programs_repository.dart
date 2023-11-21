import 'package:nishauri/src/features/user_programs/data/models/program.dart';
import 'package:nishauri/src/features/user_programs/data/models/user_program.dart';
import 'package:nishauri/src/features/user_programs/data/services/programs_service.dart';


class ProgramsRepository {
  final ProgramService _service;

  ProgramsRepository(this._service);

  Future<List<Program>> getPrograms() async {
    return await _service.getPrograms();
  }

  Future<List<UserProgram>> getUserPrograms() async {
    return await _service.getUserPrograms();
  }
}
