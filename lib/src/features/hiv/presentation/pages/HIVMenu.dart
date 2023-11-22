import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nishauri/src/app/navigation/menu/MenuItemsBuilder.dart';
import 'package:nishauri/src/app/navigation/menu/MenuOption.dart';
import 'package:nishauri/src/app/navigation/menu/menuItems.dart';
import 'package:nishauri/src/utils/routes.dart';

_menuItems(BuildContext context) => [
      MenuItem(
        icon: Icons.shopping_cart,
        title: "Drug Orders",
        onPressed: () => context.goNamed(RouteNames.HIV_DRUG_ORDERS),
      ),
      MenuItem(
          icon: Icons.local_hospital_outlined,
          title: "ART Sites",
          onPressed: () => context.goNamed(RouteNames.HIV_ART_SITES)),

      MenuItem(
          icon: Icons.medication,
          title: "Regimen",
          onPressed: () => context.goNamed(RouteNames.HIV_REGIMEN)),
      MenuItem(
          icon: Icons.group,
          title: "ART Groups",
          onPressed: () => context.goNamed(RouteNames.HIV_ART_GROUPS)),
      MenuItem(
          icon: Icons.event,
          title: "ART Events",
          onPressed: () => context.goNamed(RouteNames.HIV_ART_EVENTS)),
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
