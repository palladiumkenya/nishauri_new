import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nishauri/src/features/clinic_card/data/models/program.dart';
import 'package:nishauri/src/features/clinic_card/data/repository/ProgramRepository.dart';
import 'package:nishauri/src/features/clinic_card/data/services/ProgramService.dart';
import 'package:nishauri/src/features/user_programs/data/providers/program_provider.dart';

final programProvider = FutureProvider<List<Program>>((ref) async {
  ref.watch(userProgramProvider);
  final service = ProgramService();
  final repository = ProgramRepository(service);
  return await repository.getPrograms();
});
