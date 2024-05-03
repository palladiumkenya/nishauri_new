import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nishauri/src/features/clinic_card/data/models/program.dart';
import 'package:nishauri/src/features/clinic_card/data/repository/ProgramRepository.dart';
import 'package:nishauri/src/features/clinic_card/data/services/ProgramService.dart';

final programProvider = FutureProvider<List<Program>>((ref) async {
  final service = ProgramService();
  final repository = ProgramRepository(service);
  return await repository.getPrograms();
});
