import 'dart:convert';

import 'package:nishauri/src/features/auth/data/models/terms_and_conditions.dart';
import 'package:nishauri/src/features/auth/data/models/terms_conditions.dart';
import 'package:nishauri/src/shared/interfaces/HTTPService.dart';
import 'package:http/http.dart' as http;
import 'package:nishauri/src/utils/constants.dart';

class TermsConditionsService extends HTTPService {
  Future<TermsAndPrivacy> termsCondition() async {
    try {
      var headers = {'Content-Type': 'application/json'};
      var response = await http.get(
        Uri.parse('${Constants.BASE_URL_NEW}/terms_conditions'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        return TermsAndPrivacy.fromJson(jsonResponse);
      } else {
        throw 'Failed to load terms and conditions';
      }
    } catch (e) {
      throw 'Internet error occurred';
    }
  }
}