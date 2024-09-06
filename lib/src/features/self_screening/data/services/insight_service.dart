import 'dart:convert';
import 'dart:developer';

import 'package:nishauri/src/features/common/data/models/announcement.dart';
import 'package:nishauri/src/shared/interfaces/HTTPService.dart';
import 'package:nishauri/src/utils/helpers.dart';

class InsightService extends HTTPService {
  Future<List<Announcement>> getInsights() async {
    final data = await loadJsonData("assets/data/self_screening_insight.json");
    final json = jsonDecode(data);
    final announce = json
        .map((an) => Announcement.fromJson(Map<String, dynamic>.from(an))).toList();

    log("$announce");
    return [...announce];
  }
}
