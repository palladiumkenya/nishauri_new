import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nishauri/src/app/navigation/menu/MenuItemsBuilder.dart';
import 'package:nishauri/src/app/navigation/menu/MenuOption.dart';
import 'package:nishauri/src/app/navigation/menu/menuItems.dart';
import 'package:nishauri/src/utils/routes.dart';

_menuItems(BuildContext context) => [
      MenuItem(
          icon: Icons.app_registration,
          title: "Register",
          onPressed: () => context.goNamed(RouteNames.HIV_PROGRAM_VERIFICATION)),
      MenuItem(icon: Icons.shopping_cart, title: "Drug Orders"),
      MenuItem(icon: Icons.local_hospital_outlined, title: "ART Sites"),
      MenuItem(icon: Icons.dashboard_customize_outlined, title: "Dashboard"),
      MenuItem(icon: Icons.medication, title: "Regimen"),
      MenuItem(icon: Icons.group, title: "ART Groups"),
      MenuItem(icon: Icons.event, title: "ART Events"),
    ];

class HIVMenuScreen extends StatelessWidget {
  const HIVMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final _items = _menuItems(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.chevron_left),
          onPressed: () => context.pop(),
        ),
        title: const Text("HIV Program"),
      ),
      body: MenuItemsBuilder(
        crossAxisCount: 3,
        itemBuilder: (item) => MenuOption(
          title: item.title ?? "",
          icon: item.icon,
          onPress: item.onPressed,
        ),
        items: _items,
      ),
    );
  }
}
