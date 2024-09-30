import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nishauri/src/features/common/data/models/announcement.dart';
import 'package:nishauri/src/features/self_screening/data/repositories/bs_repository.dart';
import 'package:nishauri/src/features/self_screening/data/repositories/insight_repository.dart';
import 'package:nishauri/src/features/self_screening/data/services/bs_service.dart';
import 'package:nishauri/src/features/self_screening/data/services/insight_service.dart';

final insightProvider = FutureProvider<List<Announcement>>((ref) async {
  final service = InsightService();
  final repo = InsightRepository(service);
  return await repo.getInsights();
});

final bsInsightProvider = FutureProvider<List<Announcement>>((ref) async {
  final service = BsService();
  final repo = BsRepository(service);
  return await repo.getBsInsights();
});