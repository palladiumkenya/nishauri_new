import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nishauri/src/app/navigation/menu/MenuItemsBuilder.dart';
import 'package:nishauri/src/app/navigation/menu/menuItems.dart';
import 'package:nishauri/src/utils/constants.dart';
import 'package:nishauri/src/utils/routes.dart';

_menuItems(BuildContext context) => [
  MenuItem(
    icon: Icon(Icons.list_alt_rounded),
    title: "Appointments",
    onPressed: () => context.goNamed(RouteNames.PROGRAM_APPOINTMENT),
  ),
  // MenuItem(
  //   icon: Icons.local_hospital_outlined,
  //   title: "Others",
  //   // onPressed: () => context.goNamed(RouteNames.HIV_DRUG_ORDERS),
  // ),
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
        title: const Text("Request Drug"),
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
              padding: const EdgeInsets.all(Constants.SPACING),
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
                    fit: BoxFit.cover
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  item.icon,
                  const SizedBox(height: Constants.SPACING,),
                  Text(item.title ?? '',
                    style: theme.textTheme.titleMedium?.copyWith(
                        color: theme.canvasColor,
                        fontWeight: FontWeight.normal,
                        overflow: TextOverflow.ellipsis
                    ),)
                ],
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
