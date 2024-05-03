import 'package:nishauri/src/features/bmi/data/model/bmi_nutrition_maping.dart';
import 'package:nishauri/src/features/bmi/data/services/bmi_calculator_service.dart';

class BMIStatusNutritionRepository {
  final BMICalculatorService _service;

  BMIStatusNutritionRepository(this._service);

  Future<List<BMIStatusNutrition>> getBMIStatusNutrition() async {
      final nutrition = await _service.getBMIStatusNutrition();
      return nutrition;
  }
}