import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart';
import 'package:nishauri/src/features/bmi/data/model/bmi_nutrition_maping.dart';
import 'package:nishauri/src/shared/exeptions/http_exceptions.dart';
import 'package:nishauri/src/shared/interfaces/HTTPService.dart';

import '../../../../utils/constants.dart';

class BMICalculatorService extends HTTPService {
  Future<StreamedResponse> getBMIStatusNutrition_(dynamic args) async {
    var request = Request(
      'GET',
      Uri.parse('${Constants.BASE_URL_NEW}bmi_details'),
    );
    return await request.send();
  }

  Future<List<BMIStatusNutrition>> getBMIStatusNutrition() async {
    await Future.delayed(const Duration(seconds: 5));
    final response = await call(getBMIStatusNutrition_, null);
    final responseString = await response.stream.bytesToString();
    final Map<String, dynamic> responseData = json.decode(responseString);
    if (responseData["success"] == true) {
      final nutrition = (responseData["data"] as List<dynamic>)
          .map((e) => BMIStatusNutrition.fromJson({
                ...e,
                "isActive": e["is_active"] == 1,
                "id": e["id"].toString()
              }))
          .toList();
      return nutrition;
    } else {
      throw ResourceNotFoundException(responseData["message"]);
    }
  }
}
