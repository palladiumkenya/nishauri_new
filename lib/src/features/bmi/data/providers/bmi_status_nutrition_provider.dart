import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nishauri/src/features/bmi/data/repositories/bmi_status_nutrition_repository.dart';
import 'package:nishauri/src/features/bmi/data/services/bmi_calculator_service.dart';

final bmiNutritionProvider = FutureProvider((ref)async {
  final repository = BMIStatusNutritionRepository(BMICalculatorService());
  return await repository.getBMIStatusNutrition();
});