import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nishauri/src/app/navigation/menu/MenuItemsBuilder.dart';
import 'package:nishauri/src/app/navigation/menu/MenuOption.dart';
import 'package:nishauri/src/app/navigation/menu/menuItems.dart';
import 'package:nishauri/src/utils/routes.dart';

_menuItems(BuildContext context) => [
  MenuItem(
    icon: Icons.shopping_cart,
    title: "Request Drugs",
    onPressed: () => context.goNamed(RouteNames.REQUEST_DRUGS),
  ),
  MenuItem(
    icon: Icons.shopping_cart_checkout,
    title: "Drug Orders",
    onPressed: () => context.goNamed(RouteNames.HIV_DRUG_ORDERS),
  ),
  MenuItem(
    icon: Icons.check_outlined,
    title: "Confirm Delivery",
    onPressed: () => context.goNamed(RouteNames.DISPATCHED_DRUGS),
  ),
];

class DawaDropMenuScreen extends StatelessWidget {
  const DawaDropMenuScreen({super.key});

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
        title: const Text("Dawa Drop"),
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
