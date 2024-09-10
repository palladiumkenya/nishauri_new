import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nishauri/src/features/common/data/models/announcement.dart';
import 'package:nishauri/src/features/common/data/repositories/announceent_repository.dart';
import 'package:nishauri/src/features/common/data/services/announcement_service.dart';
import 'package:nishauri/src/features/self_screening/data/repositories/insight_repository.dart';
import 'package:nishauri/src/features/self_screening/data/services/insight_service.dart';

final insightProvider = FutureProvider<List<Announcement>>((ref) async {
  final service = InsightService();
  final repo = InsightRepository(service);
  return await repo.getInsights();
});