import 'package:flutter/material.dart';
import 'package:nishauri/src/app/navigation/menu/MenuItemsBuilder.dart';
import 'package:nishauri/src/app/navigation/menu/MenuOption.dart';
import 'package:nishauri/src/app/navigation/menu/menuItems.dart';
import 'package:nishauri/src/features/common/presentation/helpers/constants.dart';
import 'package:nishauri/src/features/common/presentation/widgets/Greeting2.dart';
import 'package:nishauri/src/shared/input/FormInputTextField.dart';
import 'package:nishauri/src/utils/constants.dart';

class MainMenuScreen extends StatelessWidget {
  const MainMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.primaryColor,
        title: const Center(child: Text("Apps")),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.edit_sharp),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(Constants.SPACING),
              child: const FormInputTextField(
                prefixIcon: Icons.search,
                placeholder: "Search...",
              ),
            ),
            Expanded(
              child: MenuItemsBuilder(
                itemBuilder: (item) => MenuOption(
                  title: item.title ?? "",
                  icon: item.icon,
                  iconSize: 50,
                  onPress: item.onPressed,
                ),
                items: menuOptions(context),
              ),
              /*child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                ),
                itemCount: menuOptions.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.all(Constants.SPACING),
                    padding: const EdgeInsets.all(Constants.SPACING),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        DecoratedBox(
                          decoration: BoxDecoration(
                            color: theme.colorScheme.primary,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(Constants.ROUNDNESS * 10),
                            ),
                          ),
                          child: IconButton(
                            onPressed: () {},
                            iconSize: 50,
                            color: theme.colorScheme.onPrimary,
                            icon: Icon(menuOptions[index].icon),
                          ),
                        ),
                        Text(
                          menuOptions[index].title ?? "",
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  );
                },
              ),*/
            ),
          ],
        ),
      ),
    );
  }
}
