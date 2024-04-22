import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:nishauri/src/app/navigation/menu/MenuItemsBuilder.dart';
import 'package:nishauri/src/app/navigation/menu/MenuOption.dart';
import 'package:nishauri/src/app/navigation/menu/menuItems.dart';
import 'package:nishauri/src/features/common/presentation/helpers/constants.dart';
import 'package:nishauri/src/features/common/presentation/widgets/Greeting2.dart';
import 'package:nishauri/src/features/user_programs/data/providers/program_provider.dart';
import 'package:nishauri/src/shared/display/AppCard.dart';
import 'package:nishauri/src/shared/input/FormInputTextField.dart';
import 'package:nishauri/src/utils/constants.dart';
import 'package:nishauri/src/utils/routes.dart';

class MainMenuScreen extends StatelessWidget {
  const MainMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("App modules", style: theme.textTheme.headlineLarge)),
      ),
      body: SafeArea(
        child: Consumer(
          builder: (context, ref, child) {
            final userProgram = ref.watch(programProvider);
            return Column(
              children: [
                // Container(
                //   padding: const EdgeInsets.all(Constants.SPACING),
                //   child: const FormInputTextField(
                //     prefixIcon: Icons.search,
                //     placeholder: "Search...",
                //   ),
                // ),
                const SizedBox(height: Constants.SPACING * 2),
                Expanded(
                  child: userProgram.when(
                    data: (data) => MenuItemsBuilder(
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
                                  image:
                                      AssetImage("assets/images/contours.png"),
                                  opacity: 0.2,
                                  fit: BoxFit.cover

                                  // image: AssetImage("assets/images/contours.png"),
                                  ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Icon(
                                  item.icon,
                                  size: 70,
                                  color: theme.colorScheme.primary,
                                ),
                                const SizedBox(height: Constants.SPACING),
                                Text(
                                  item.title ?? "",
                                  style: theme.textTheme.titleLarge?.copyWith(
                                      color: theme.canvasColor,
                                      fontWeight: FontWeight.bold,
                                      overflow: TextOverflow.ellipsis),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      // itemBuilder: (item) => MenuOption(
                      //   title: item.title ?? "",
                      //   icon: item.icon,
                      //   // iconSize: 50,
                      //   onPress: item.onPressed,
                      //   // iconColor: theme.colorScheme.primary,
                      //   bgColor: item.title == "Add Programme"
                      //       ? theme.colorScheme.secondary
                      //       : null,
                      // ),
                      items: [
                        // get generic menu items
                        ...getGenericMenuItems(context),
                        // // get program menu items
                        // ...data.map((e) {
                        //   final programCode = e.id;
                        //   print(e.id);
                        //   return getProgramMenuItemByProgramCode(context, programCode?? '');
                        // }).toList(),
                        // Register new program
                        MenuItem(
                          icon: Icons.add,
                          title: "Add Programme",
                          onPressed: () => context
                              .goNamed(RouteNames.PROGRAME_REGISTRATION_SCREEN),
                        ),
                      ],
                    ),
                    error: (error, _) => Center(child: Text(error.toString())),
                    loading: () => const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
