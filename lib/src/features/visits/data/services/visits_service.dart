import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:nishauri/src/features/auth/data/models/auth_state.dart';
import 'package:nishauri/src/features/visits/data/models/visit.dart';
import 'package:nishauri/src/shared/interfaces/HTTPService.dart';
import 'package:nishauri/src/utils/helpers.dart';

class VisitService extends HTTPService {
  final AuthState _authState;

  VisitService(this._authState);

  // Future<void> getVisits() async {
  Future<List<Visit>> getVisits() async {
    final data = await loadJsonData('assets/data/visits.json');
    // debugPrint(data);
    final json = jsonDecode(data);
    final visit = Visit.fromJson(json);
    return [visit];
  }
}
