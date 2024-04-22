import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nishauri/src/app/navigation/menu/MenuItemsBuilder.dart';
import 'package:nishauri/src/app/navigation/menu/MenuOption.dart';
import 'package:nishauri/src/app/navigation/menu/menuItems.dart';
import 'package:nishauri/src/utils/constants.dart';
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
        title: Text("Dawa Drop",
            style: theme.textTheme.titleMedium?.copyWith(
                color: theme.canvasColor,
                fontWeight: FontWeight.normal,
                overflow: TextOverflow.ellipsis
            ),),
      ),
      body: MenuItemsBuilder(
        crossAxisCount: 2,
        itemBuilder: (item) => Card(
          margin: const EdgeInsets.all(Constants.SPACING),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            splashColor: theme.colorScheme.primary,
            onTap: item.onPressed,
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    theme.colorScheme.inversePrimary,
                    theme.colorScheme.primary,
                  ],
                ),
                image: const DecorationImage(
                  image: AssetImage("assets/images/contours.png"),
                  opacity: 0.2,
                  fit: BoxFit.cover,
                ),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Icon(item.icon, size: 50, color: theme.cardColor),
                    const SizedBox(height: Constants.SPACING),
                    Text(
                      item.title ?? '',
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: theme.canvasColor,
                        fontWeight: FontWeight.normal,
                        overflow: TextOverflow.ellipsis,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),

        // itemBuilder: (item) => MenuOption(
        //   title: item.title ?? "",
        //   icon: item.icon,
        //   onPress: item.onPressed,
        // ),
        items: _items,
      ),
    );
  }
}
