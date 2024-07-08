import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nishauri/src/features/user_preference/data/models/Setings.dart';
import 'package:nishauri/src/local_storage/LocalStorage.dart';

class SettingsController extends StateNotifier<Settings> {
  SettingsController() : super(Settings.defaultSettings()) {
    loadSettingConfig();
  }

  Future<void> loadSettingConfig() async {
    final theme = await LocalStorage.get("theme");
    final isPrivacyEnabled = await LocalStorage.get("isPrivacyEnabled");
    final firstTimeInstallation = await LocalStorage.get("initial");
    state = state.copyWith(
        theme: theme.isNotEmpty ? theme : "light",
        isPrivacyEnabled:
            isPrivacyEnabled.isEmpty ? true : isPrivacyEnabled == "1",
        firstTimeInstallation: firstTimeInstallation.isEmpty
            ? true
            : firstTimeInstallation == "1");
  }

  Future<void> saveSettingConfig(Settings settings) async {
    await LocalStorage.save("theme", settings.theme);
    await LocalStorage.save(
        "isPrivacyEnabled", settings.isPrivacyEnabled ? "1" : "0");
    await LocalStorage.save(
        "initial", settings.firstTimeInstallation ? "1" : "0");
    await LocalStorage.save(
        "firstNuruAccess", settings.firstNuruAccess ? "1" : "0");
  }

  Future<void> clearSettingConfig() async {
    await LocalStorage.delete("theme");
    await LocalStorage.delete("isPrivacyEnabled");
    await LocalStorage.delete("initial");
  }

  void updateSettings({
    String? userToken,
    String? theme,
    String? pin,
    bool? isPrivacyEnabled,
    bool? isBiometricEnabled,
    bool? isAuthenticated,
    bool? firstTimeInstallation,
    bool? firstNuruAccess,
  }) {
    state = state.copyWith(
        userToken: userToken,
        theme: theme,
        pin: pin,
        isPrivacyEnabled: isPrivacyEnabled,
        isBiometricEnabled: isBiometricEnabled,
        isAuthenticated: isAuthenticated,
        firstTimeInstallation: firstTimeInstallation,
        firstNuruAccess: firstNuruAccess);
    saveSettingConfig(state);
  }

  Settings getState() {
    return state;
  }

  void patchSettings({
    String? userToken,
    String? theme,
    String? pin,
    bool? isPrivacyEnabled,
    bool? isBiometricEnabled,
    bool? isAuthenticated,
    bool? firstTimeInstallation,
    bool? firstNuruAccess,
  }) {
    state = state.copyWith(
        userToken: userToken ?? state.userToken,
        theme: theme ?? state.theme,
        pin: pin ?? state.pin,
        isPrivacyEnabled: isPrivacyEnabled ?? state.isPrivacyEnabled,
        isBiometricEnabled: isBiometricEnabled ?? state.isBiometricEnabled,
        isAuthenticated: isAuthenticated ?? state.isAuthenticated,
        firstTimeInstallation:
            firstTimeInstallation ?? state.firstTimeInstallation,
        firstNuruAccess: firstNuruAccess ?? state.firstNuruAccess);
    saveSettingConfig(state);
  }

  void clearSettings() {
    state = Settings.defaultSettings();
    clearSettingConfig();
  }
}
