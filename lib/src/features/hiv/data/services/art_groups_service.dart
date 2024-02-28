import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:nishauri/src/features/auth/data/models/auth_state.dart';
import 'package:nishauri/src/features/hiv/data/models/models.dart';
import 'package:nishauri/src/shared/exeptions/http_exceptions.dart';
import 'package:nishauri/src/shared/interfaces/HTTPService.dart';

import '../../../../utils/constants.dart';

class ARTGroupService extends HTTPService {
  Future<List<ARTGroup>> getUserARTGroups() async {
    final response = await call(getUserSubscriptions_, null);
    final responseString = await response.stream.bytesToString();
    final Map<String, dynamic> programData = json.decode(responseString);
    final programs = (programData["results"] as List<dynamic>)
        .map((e) => ARTGroup.fromJson(e))
        .toList();
    return programs;
  }

  Future<StreamedResponse> getUserARTGroups_(dynamic args) async {
    final tokenPair = await getCachedToken();
    var headers = {'x-access-token': tokenPair.accessToken};
    var request = Request('GET',
        Uri.parse('${Constants.BASE_URL}/hiv-program/art-community/groups'));
    request.headers.addAll(headers);
    return await request.send();
  }

  Future<void> addARTGroup(Map<String, dynamic> group) async {
    await call(addARTGroup_, group);
  }

  Future<StreamedResponse> addARTGroup_(Map<String, dynamic> group) async {
    final tokenPair = await getCachedToken();
    var headers = {
      'x-access-token': tokenPair.accessToken,
      'Content-Type': 'application/json'
    };
    var request = Request('POST',
        Uri.parse('${Constants.BASE_URL}/hiv-program/art-community/groups'));
    request.headers.addAll(headers);
    request.body = json.encode(group);
    return await request.send();
  }

  Future<List<ARTGroupSubscription>> getUserSubscriptions() async {
    final response = await call(getUserSubscriptions_, null);
    final responseString = await response.stream.bytesToString();
    final Map<String, dynamic> programData = json.decode(responseString);
    final programs = (programData["results"] as List<dynamic>)
        .map((e) => ARTGroupSubscription.fromJson(e))
        .toList();
    return programs;
  }

  Future<StreamedResponse> getUserSubscriptions_(dynamic args) async {
    final tokenPair = await getCachedToken();
    var headers = {'x-access-token': tokenPair.accessToken};
    var request = Request(
        'GET',
        Uri.parse(
            '${Constants.BASE_URL}/hiv-program/art-community/enrollments'));
    request.headers.addAll(headers);
    return await request.send();
  }
}
