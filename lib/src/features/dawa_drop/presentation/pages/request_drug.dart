import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nishauri/src/app/navigation/menu/MenuItemsBuilder.dart';
import 'package:nishauri/src/app/navigation/menu/MenuOption.dart';
import 'package:nishauri/src/app/navigation/menu/menuItems.dart';
import 'package:nishauri/src/utils/routes.dart';

_menuItems(BuildContext context) => [
  MenuItem(
    icon: Icons.list_alt_rounded,
    title: "Appointments",
    onPressed: () => context.goNamed(RouteNames.PROGRAM_APPOINTMENT),
  ),
  MenuItem(
    icon: Icons.local_hospital_outlined,
    title: "Others",
    // onPressed: () => context.goNamed(RouteNames.HIV_DRUG_ORDERS),
  ),
];

class RequestDrugMenuScreen extends StatelessWidget {
  const RequestDrugMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final _items = _menuItems(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.primaryColor,
        leading: IconButton(
          icon: const Icon(Icons.chevron_left),
          onPressed: () => context.pop(),
        ),
        title: const Text("Request Medication"),
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
