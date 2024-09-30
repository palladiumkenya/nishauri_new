import 'package:nishauri/src/features/common/data/models/announcement.dart';
import 'package:nishauri/src/features/self_screening/data/services/bs_service.dart';

class BsRepository {
  final BsService _service;

  BsRepository(this._service);

  Future<List<Announcement>> getBsInsights() async {
    return await _service.getBsInsights();
  }
}
