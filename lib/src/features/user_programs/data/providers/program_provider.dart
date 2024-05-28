import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nishauri/src/features/user/data/providers/user_provider.dart';
import 'package:nishauri/src/features/user_programs/data/models/program.dart';
import 'package:nishauri/src/features/user_programs/data/models/user_program.dart';
import 'package:nishauri/src/features/user_programs/data/repositories/programs_repository.dart';
import 'package:nishauri/src/features/user_programs/data/services/programs_service.dart';
import 'package:nishauri/src/features/user_programs/presentation/controllers/user_program_controller.dart';

final userProgramProvider = StateNotifierProvider<UserProgramController, AsyncValue<List<UserProgram>>>((ref) {
  ref.watch(userProvider);
  final service = ProgramService();
  final repository = ProgramsRepository(service);
  return UserProgramController(repository);
});

final programServiceProvider = Provider((ref) => ProgramService());

final programsRepositoryProvider = Provider((ref) {
  final service = ref.watch(programServiceProvider);
  return ProgramsRepository(service);
});

final programsProvider = FutureProvider<List<Program>>((ref) async {
  final repository = ref.watch(programsRepositoryProvider);
  final userProgramsState = ref.watch(userProgramProvider);

  return userProgramsState.when(
    data: (userPrograms) async {
      final allPrograms = await repository.getPrograms();


      // Filter out programs that are in userPrograms and active
      final activeUserProgramIds = userPrograms
          .where((userProgram) => userProgram.isActive)
          .map((userProgram) => userProgram.id)
          .toSet();

      final filteredPrograms = allPrograms
          .where((program) {
            return !activeUserProgramIds.contains(program.id.toString());
          })
          .toList();

      return filteredPrograms;
    },
    loading: () => [],
    error: (err, stack) {
      print('Error fetching user programs: $err');
      return [];
    },
  );
});
