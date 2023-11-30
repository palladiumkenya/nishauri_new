import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nishauri/src/features/user_programs/data/models/user_program.dart';
import 'package:nishauri/src/features/user_programs/data/repositories/programs_repository.dart';

class UserProgramController
    extends StateNotifier<AsyncValue<List<UserProgram>>> {
  final ProgramsRepository _repository;

  UserProgramController(this._repository) : super(const AsyncValue.loading()) {
    _getUserPrograms();
  }

  Future<void> _getUserPrograms() async {
    _repository
        .getUserPrograms()
        .then((value) => state = AsyncValue.data(value));
  }

  Future<String> registerProgram(Map<String, dynamic> data) async {
    try {
      return await _repository.registerProgram(data);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> verifyProgramOTP(Map<String, dynamic> data) async {
    try {
      await _repository.verifyProgramOTP(data);
      _getUserPrograms();
    } catch (e) {
      rethrow;
    }
  }

// Future<void>
}
