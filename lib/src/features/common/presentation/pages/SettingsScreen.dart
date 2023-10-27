import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class _SettingsItem {
  final IconData? leadingIcon;
  final IconData? trailingIcon;
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

final _settingsItem = <_SettingsItem>[
  _SettingsItem(title: "Profile", leadingIcon: Icons.account_circle),
  _SettingsItem(title: "Theme", leadingIcon: Icons.light_mode),
  _SettingsItem(title: "Privacy", leadingIcon: Icons.security),
  _SettingsItem(
      title: "Plugins", leadingIcon: Icons.private_connectivity_outlined),
  _SettingsItem(title: "Change Password", leadingIcon: Icons.key),
  _SettingsItem(title: "Logout", leadingIcon: Icons.logout),
];

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Settings")),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return Column(
            children: [
              ListTile(
                leading: Icon(_settingsItem[index].leadingIcon),
                title: Text(_settingsItem[index].title),
                onTap: _settingsItem[index].onPress,
              ),
              Container(height: 1,color: Colors.black12,margin: const EdgeInsets.all(5),)
            ],
          );
        },
        itemCount: _settingsItem.length,
        padding: const EdgeInsets.all(10),

      ),
    );
  }
}
