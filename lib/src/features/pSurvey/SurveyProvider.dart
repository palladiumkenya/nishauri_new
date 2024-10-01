import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'SurveyNotifier.dart';
import 'SurveyState.dart';

final surveyProvider = StateNotifierProvider<SurveyNotifier, SurveyState>((ref) {
  return SurveyNotifier();
});
