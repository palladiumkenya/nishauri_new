import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nishauri/src/features/auth/data/services/BiometricAuthService.dart';
import 'package:nishauri/src/features/user_preference/data/models/Setings.dart';
import 'package:nishauri/src/features/user_preference/presentation/controlers/SettingsControler.dart';

final settingsNotifierProvider =
    StateNotifierProvider<SettingsController, Settings>(
  (ref) => SettingsController(),
);
final canCheckBiometricsProvider = StateProvider<bool>((ref) => false);
final passwordVisibleProvider = StateProvider<bool>((ref) => false);
