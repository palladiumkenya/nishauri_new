import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:nishauri/src/app/navigation/drawer/customeDrawer.dart';
import 'package:nishauri/src/app/navigation/menu/MenuItemsBuilder.dart';
import 'package:nishauri/src/app/navigation/menu/MenuOption.dart';
import 'package:nishauri/src/app/navigation/menu/menuItems.dart';
import 'package:nishauri/src/features/common/presentation/helpers/constants.dart';
import 'package:nishauri/src/features/common/presentation/widgets/Greeting2.dart';
import 'package:nishauri/src/features/user/data/providers/user_provider.dart';
import 'package:nishauri/src/features/user_programs/data/providers/program_provider.dart';
import 'package:nishauri/src/shared/display/AppCard.dart';
import 'package:nishauri/src/shared/input/FormInputTextField.dart';
import 'package:nishauri/src/utils/constants.dart';
import 'package:nishauri/src/utils/helpers.dart';
import 'package:nishauri/src/utils/routes.dart';

class MainMenuScreen extends ConsumerWidget {
  const MainMenuScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final size = getOrientationAwareScreenSize(context);

    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    void toggleDrawer() {
      if (_scaffoldKey.currentState != null) {
        if (_scaffoldKey.currentState!.isDrawerOpen) {
          _scaffoldKey.currentState!.closeDrawer();
        } else {
          _scaffoldKey.currentState!.openDrawer();
        }
      }
    }

    final userAdminAsync = ref.watch(userProvider);
    return userAdminAsync.when(
        data: (admin){
          final isAdmin = admin.roles.contains("provider");
          return Scaffold(
            key: _scaffoldKey,
            drawer: CustomDrawer(),
            body: Stack(
              children: [
                Positioned(
                    top: 0,
                    right: 0,
                    child: SvgPicture.asset(
                      "assets/images/rect-bg.svg",
                      semanticsLabel: "Doctors",
                      fit: BoxFit.contain,
                      height: size.width * 0.45,
                      width: size.width * 0.45,
                    )),
                SafeArea(
                  child: Consumer(
                    builder: (context, ref, child) {
                      final userProgram = ref.watch(userProgramProvider);
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: Constants.SPACING),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: Constants.SPACING,
                                vertical: Constants.SPACING),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "App Modules📱",
                                  style: TextStyle(
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold,
                                    color: theme.colorScheme.primary,
                                  ),
                                ),
                                Wrap(
                                  children: [
                                    IconButton(
                                      onPressed: toggleDrawer,
                                      icon: const Icon(Icons.more_vert_outlined),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          const SizedBox(height: Constants.SPACING * 2),
                          Expanded(
                            child: userProgram.when(
                              data: (data) {
                                return MenuItemsBuilder(
                                  crossAxisCount: 2,
                                  itemBuilder: (item) => Card(
                                    margin: const EdgeInsets.all(Constants.SPACING),
                                    clipBehavior: Clip.antiAlias,
                                    child: InkWell(
                                      splashColor: theme.colorScheme.primary,
                                      onTap: item.onPressed,
                                      child: Container(
                                        padding:
                                        const EdgeInsets.all(Constants.SPACING),
                                        decoration: BoxDecoration(
                                          color:
                                          item.color ?? theme.colorScheme.primary,
                                          image: const DecorationImage(
                                            image: AssetImage(
                                                "assets/images/contours.png"),
                                            opacity: 0.2,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: <Widget>[
                                            item.icon,
                                            const SizedBox(height: Constants.SPACING),
                                            Text(
                                              item.title ?? "",
                                              style: theme.textTheme.titleMedium
                                                  ?.copyWith(
                                                color: Colors.white,
                                                fontWeight: FontWeight.normal,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                              softWrap: true,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  items: [
                                    ...getGenericMenuItems(context, isAdmin),
                                  ],
                                );
                              },
                              error: (error, _) =>
                                  Center(child: Text(error.toString())),
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
              ],
            ),
          );
        },
        error: (error,_)=> Center(),
        loading: () => Center(child: CircularProgressIndicator(),));
  }
}
