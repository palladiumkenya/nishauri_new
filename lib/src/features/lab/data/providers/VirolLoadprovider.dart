import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nishauri/src/features/lab/data/models/viral_load.dart';
import 'package:nishauri/src/features/lab/data//services/ViralLoadService.dart';
import 'package:nishauri/src/features/user_programs/data/providers/program_provider.dart';

final viralLoadProvider = FutureProvider<List<ViralLoad>>((ref) async {
  ref.watch(userProgramProvider);
  ViralLoadService service = ViralLoadService();
  return await service.getViralLoads();
});
