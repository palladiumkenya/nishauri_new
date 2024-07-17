import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nishauri/src/features/bmi/data/repositories/bmi_log_repository.dart';
import 'package:nishauri/src/features/bmi/data/services/bmi_log_service.dart';
import 'package:nishauri/src/features/bmi/presentation/controllers/bmi_log_controller.dart';

final bmiLogProvider = StateNotifierProvider<BMILogController, AsyncValue<String>>((ref) {
  final service = BMILogService();
  final repository = BMILogRepository(service);
  return BMILogController(repository);
});