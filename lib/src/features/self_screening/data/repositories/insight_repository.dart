import 'package:nishauri/src/features/common/data/models/announcement.dart';
import 'package:nishauri/src/features/self_screening/data/services/insight_service.dart';

class InsightRepository {
  final InsightService _service;

  InsightRepository(this._service);

  Future<List<Announcement>> getInsights() async {
    return await _service.getInsights();
  }
}
