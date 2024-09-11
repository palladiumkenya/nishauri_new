import 'dart:convert';
import 'dart:developer';

import 'package:nishauri/src/features/common/data/models/announcement.dart';
import 'package:nishauri/src/shared/interfaces/HTTPService.dart';
import 'package:nishauri/src/utils/helpers.dart';

class BsService extends HTTPService {
  Future<List<Announcement>> getBsInsights() async {
    final data = await loadJsonData("assets/data/self_screening_bs.json");
    final json = jsonDecode(data);
    final announce = json
        .map((an) => Announcement.fromJson(Map<String, dynamic>.from(an))).toList();

    log("$announce");
    return [...announce];
  }
}
