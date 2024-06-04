import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nishauri/src/features/user_programs/data/models/program.dart';
import 'package:nishauri/src/features/user_programs/data/models/user_program.dart';
import 'package:nishauri/src/features/user_programs/data/repositories/programs_repository.dart';

import '../../data/models/program_verification_detail.dart';
import '../../data/models/program_verificaton_contact.dart';

class UserProgramController
    extends StateNotifier<AsyncValue<List<UserProgram>>> {
  final ProgramsRepository _repository;

  UserProgramController(this._repository) : super(const AsyncValue.loading()) {
    _getUserPrograms();
  }

  Future<void> _getUserPrograms() async {
    try {
      final programs = await _repository
          .getUserPrograms();
      state = AsyncValue.data(programs);
    }catch(err){
      state = const AsyncValue.data([]);
    }
  }

  Future<String> registerProgram(
      Map<String, dynamic> data) async {
    try {
      final verificationDetail = await _repository.registerProgram(data);
      await _getUserPrograms();
      return verificationDetail;
    } catch (e) {
      rethrow;
    }
  }

  Future<String> updateProgram(Map<String, dynamic> data) async {
    try {
      final results = await _repository.updateProgram(data);
      await _getUserPrograms();
      return results;
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> programVerification(Map<String, dynamic> data) async {
    try {
      return await _repository.programVerification(data);
    } catch (e) {
      rethrow;
    }
  }

  Future<String> resendOTP(Map<String, dynamic> data) async {
    try {
      final message = await _repository.resendOTP(data);
      return message;
    } catch (e) {
      rethrow;
    }
  }

// Future<void>
}
