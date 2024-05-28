import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:nishauri/src/features/user/data/models/user.dart';
import 'package:nishauri/src/features/user/data/providers/user_provider.dart';
import 'package:nishauri/src/features/user_preference/data/providers/settings_provider.dart';
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
      )
    ];

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
            title: Center(child: Text("Settings", style: theme.textTheme.titleLarge,)),
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
