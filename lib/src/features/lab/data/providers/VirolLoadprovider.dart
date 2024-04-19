import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nishauri/src/features/lab/data/models/viral_load.dart';
import 'package:nishauri/src/features/lab/data//services/ViralLoadService.dart';

final viralLoadProvider = FutureProvider<List<ViralLoad>>((ref) async {
  ViralLoadService service = ViralLoadService();
  return await service.getViralLoads();
});
