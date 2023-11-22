import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nishauri/src/features/user_programs/data/models/user_program.dart';
import 'package:nishauri/src/features/user_programs/data/repositories/programs_repository.dart';

class UserProgramController extends StateNotifier<AsyncValue<List<UserProgram>>> {
  final ProgramsRepository _repository;
  UserProgramController(this._repository):super(const AsyncValue.loading()){
    _repository.getUserPrograms().then((value) => state = AsyncValue.data(value));
  }

  // Future<void>
}