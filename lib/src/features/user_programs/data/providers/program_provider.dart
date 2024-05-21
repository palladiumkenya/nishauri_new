import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nishauri/src/features/user/data/providers/user_provider.dart';
import 'package:nishauri/src/features/user_programs/data/models/user_program.dart';
import 'package:nishauri/src/features/user_programs/data/repositories/programs_repository.dart';
import 'package:nishauri/src/features/user_programs/data/services/programs_service.dart';
import 'package:nishauri/src/features/user_programs/presentation/controllers/user_program_controller.dart';

final userProgramProvider = StateNotifierProvider<UserProgramController, AsyncValue<List<UserProgram>>>((ref){
  ref.watch(userProvider);
  final service = ProgramService();
  final repository = ProgramsRepository(service);
  return UserProgramController(repository);
});