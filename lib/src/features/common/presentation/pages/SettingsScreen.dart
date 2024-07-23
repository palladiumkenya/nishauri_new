import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:nishauri/src/features/auth/data/providers/biometric_auth_provider.dart';
import 'package:nishauri/src/features/auth/data/respositories/credential_storage_repository.dart';
import 'package:nishauri/src/features/auth/data/services/AuthApiService.dart';
import 'package:nishauri/src/features/auth/data/services/BiometricAuthService.dart';
import 'package:nishauri/src/features/user/data/models/user.dart';
import 'package:nishauri/src/features/user/data/providers/user_provider.dart';
import 'package:nishauri/src/features/user_preference/data/providers/settings_provider.dart';
import 'package:nishauri/src/local_storage/LocalStorage.dart';
import 'package:nishauri/src/shared/display/AppCard.dart';
import 'package:nishauri/src/shared/display/scafold_stack_body.dart';
import 'package:nishauri/src/shared/input/Button.dart';
import 'package:nishauri/src/utils/constants.dart';
import 'package:nishauri/src/utils/routes.dart';

class _SettingsItem {
  final IconData? leadingIcon;
  final Widget? trailingIcon;
  final String title;
  final String? subTitle;
  final void Function()? onPress;

  _SettingsItem(
      {required this.title,
      this.onPress,
      this.subTitle,
      this.trailingIcon,
      this.leadingIcon});
}

List<_SettingsItem> _settingsItem(BuildContext context) => <_SettingsItem>[
      _SettingsItem(
        title: "Profile",
        subTitle: "View your profile information",
        leadingIcon: Icons.account_circle,
        onPress: () => context.goNamed(RouteNames.PROFILE_SETTINGS),
      ),
      _SettingsItem(
        title: "Theme",
        leadingIcon: Icons.light_mode,
        subTitle: "Toggle dark and light theme",
        trailingIcon: Consumer(
          builder: (context, ref, child) => Switch(
            value: ref.watch(settingsNotifierProvider).theme == "dark",
            onChanged: (value) => ref
                .read(settingsNotifierProvider.notifier)
                .patchSettings(theme: value ? "dark" : "light"),
          ),
        ),
      ),
      _SettingsItem(
        title: "Enable advanced Privacy",
        subTitle: "Lock app every time it goes in background",
        leadingIcon: Icons.security,
        trailingIcon: Consumer(
          builder: (context, ref, child) {
            final settings = ref.read(settingsNotifierProvider.notifier);

            return Switch(
              value: settings.getState().isPrivacyEnabled,
              onChanged: (bool value) {
                final settings = ref.read(settingsNotifierProvider.notifier);
                settings.patchSettings(
                    isPrivacyEnabled: !settings.getState().isPrivacyEnabled);
              },
            );
          },
        ),
        // onPress: () => context.goNamed(RouteNames.PRIVACY_SETTINGS),
      ),
      // _SettingsItem(
      //     title: "Plugins", leadingIcon: Icons.private_connectivity_outlined),
      _SettingsItem(
        title: "Change Password",
        leadingIcon: Icons.key,
        onPress: () => context.goNamed(RouteNames.CHANGE_PASSWORD),
      ),
      // Enable biometric support option
      _SettingsItem(
        title: "Enable Biometric support",
        leadingIcon: Icons.fingerprint,
        trailingIcon: Consumer(
            builder: (BuildContext context, WidgetRef ref, Widget? child) {
          final biometricState = ref.watch(biometricPreferenceProvider);
          return biometricState.when(
              data: (bool isBiometricEnabled) {
                debugPrint("Biometric Settings: $isBiometricEnabled");
                return Switch(
                  value: isBiometricEnabled,
                  onChanged: (bool value) async {
                    try {
                      if (value) {
                        await _enableBiometricSupport(context, ref);
                      } else {
                        final credentialStorage = CredentialStorageRepository();
                        await credentialStorage.saveBiometricPreference(false);
                        await credentialStorage.deleteCredentials();
                      }
                      // Forces provider to refresh
                      ref.invalidate(biometricPreferenceProvider);
                    } catch (e) {
                      debugPrint("Error updating biometric preference: $e");
                    }
                  },
                );
              },
              error: (e, stack) => Text('Error: $e'),
              loading: () => const CircularProgressIndicator());
        }),
      ),
    ];

Future<void> _enableBiometricSupport(
    BuildContext context, WidgetRef ref) async {
  final biometricAuthService = BiometricAuthService();
  final credentialStorage = CredentialStorageRepository();
  final bool canCheckBiometrics =
      await biometricAuthService.canCheckBiometrics();
  if (canCheckBiometrics) {
    final phoneAndPassword = await _promptForCredentials(context);
    if (phoneAndPassword != null) {
      await credentialStorage.saveCredentials(
          phoneAndPassword['phone_number']!, phoneAndPassword['password']!);
      await credentialStorage.saveBiometricPreference(true);
      // Manually refresh the biometricPreferenceProvider to reflect the updated state
      ref.invalidate(biometricPreferenceProvider);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Credentials saved. Biometric support enabled.")));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Credentials not saved. Biometric support disabled.")));
      await credentialStorage.saveBiometricPreference(false);
      // Manually refresh the biometricPreferenceProvider
      ref.invalidate(biometricPreferenceProvider);
    }
  } else {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content:
            Text("Biometric authentication is not supported on this device.")));
    await credentialStorage.saveBiometricPreference(false);
    // Refresh the provider to update the UI
    ref.invalidate(biometricPreferenceProvider);
  }
}

Future<Map<String, String>?> _promptForCredentials(BuildContext context) async {
  String phoneNumber = '';
  String password = '';
  // Initialize Auth api service
  AuthApiService authApiService = AuthApiService();
  try {
    final result = await showDialog<Map<String, String>>(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: const Text('Kindly confirm your login details',
                textAlign: TextAlign.center),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  decoration: const InputDecoration(labelText: 'Phone number'),
                  onChanged: (value) => phoneNumber = value,
                ),
                TextField(
                  decoration: const InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  onChanged: (value) => password = value,
                ),
              ],
            ),
            actions: [
              Button(
                onPress: () async {
                  // Test whether credentials are correct using authApiservice
                  final credentials = {
                    'user_name': phoneNumber,
                    'password': password
                  };
                  final isAuthenticated =
                      await authApiService.authenticate(credentials);
                  if (isAuthenticated.accountVerified) {
                    Navigator.of(context).pop(
                        {'phone_number': phoneNumber, 'password': password});
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Credentials are incorrect."),
                      ),
                    );
                  }
                },
                title: 'Submit',
              ),
              Button(
                  title: 'Cancel',
                  onPress: () {
                    Navigator.of(context).pop();
                  }),
            ],
          );
        });
    return result;
  } catch (e) {
    return null;
  }
}

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _items = _settingsItem(context);
    final user = ref.watch(userProvider);
    final theme = Theme.of(context);
    return Scaffold(
        // appBar: AppBar(
        //   title: const Center(child: Text("Settings")),
        // ),
        body: ScaffoldStackedBody(
      body: Column(
        children: [
          AppBar(
            backgroundColor: Colors.transparent,
            title: Center(
                child: Text(
              "Settings",
              style: theme.textTheme.titleLarge,
            )),
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                final item = _items[index];
                return AppCard(
                  variant: CardVariant.OUTLINED,
                  child: ListTile(
                    leading: Icon(item.leadingIcon),
                    title: Text(item.title),
                    subtitle:
                        item.subTitle != null ? Text(item.subTitle!) : null,
                    onTap: item.onPress,
                    trailing: item.trailingIcon,
                  ),
                );
              },
              itemCount: _items.length,
            ),
          ),
        ],
      ),
    ));
  }
}
