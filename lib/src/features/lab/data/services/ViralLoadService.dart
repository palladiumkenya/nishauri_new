
import 'dart:convert';

import 'package:nishauri/src/features/lab/data/models/viral_load.dart';
import 'package:nishauri/src/shared/interfaces/HTTPService.dart';
import 'package:nishauri/src/utils/helpers.dart';

class ViralLoadService extends HTTPService {
  Future<List<ViralLoad>> getViralLoads() async {
    final data = await loadJsonData('assets/data/viral_load.json');
    final List<dynamic> jsonList = jsonDecode(data)['msg']; // Access the 'msg' array
    final viralLoads = jsonList.map((json) => ViralLoad.fromJson(json)).toList();
    return viralLoads;
  }
}
