import 'dart:convert';

import 'package:http/http.dart';
import 'package:nishauri/src/features/hiv/data/models/art_treatment_support/art_treatment_support.dart';
import 'package:nishauri/src/shared/interfaces/HTTPService.dart';

import '../../../../utils/constants.dart';

class ARTTreatmentSupportService extends HTTPService {
  Future<List<ARTTreatmentSupport>> getTreatmentSupport() async {
    final response = await call(getTreatmentSupport_, null);
    final responseString = await response.stream.bytesToString();
    final Map<String, dynamic> tSupportData = json.decode(responseString);
    final programs = (tSupportData["results"] as List<dynamic>)
        .map((e) => ARTTreatmentSupport.fromJson(e))
        .toList();
    return programs;
  }

  Future<StreamedResponse> getTreatmentSupport_(dynamic args) async {
    final tokenPair = await getCachedToken();
    var headers = {'x-access-token': tokenPair.accessToken};
    var request = Request('GET',
        Uri.parse('${Constants.BASE_URL}/hiv-program/art-treatment-support'));
    request.headers.addAll(headers);
    return await request.send();
  }
}
