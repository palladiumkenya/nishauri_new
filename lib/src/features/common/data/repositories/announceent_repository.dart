import 'package:nishauri/src/features/common/data/models/announcement.dart';
import 'package:nishauri/src/features/common/data/services/announcement_service.dart';

class AnnouncementRepository {
  final AnnouncementService _service;

  AnnouncementRepository(this._service);

  Future<List<Announcement>> getAnnouncements() async {
    return await _service.getAnnouncements();
  }
}
