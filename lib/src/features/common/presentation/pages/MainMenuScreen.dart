import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
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
import 'package:nishauri/src/utils/helpers.dart';
import 'package:nishauri/src/utils/routes.dart';

class MainMenuScreen extends StatelessWidget {
  const MainMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = getOrientationAwareScreenSize(context);
    return Scaffold(
      // appBar: AppBar(
      //   title: Center(
      //       child: Text("App modules", style: theme.textTheme.headlineLarge)),
      // ),
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
                      child: Text(
                        "App Modules📱",
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.primary,
                        ),
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
                                    // gradient: LinearGradient(
                                    //   begin: Alignment.topCenter,
                                    //   end: Alignment.bottomCenter,
                                    //   colors: [
                                    //     theme.colorScheme.onSurface,
                                    //     item.color ?? theme.colorScheme.primary,
                                    //   ],
                                    // ),
                                    image: const DecorationImage(
                                        image: AssetImage(
                                            "assets/images/contours.png"),
                                        opacity: 0.2,
                                        fit: BoxFit.cover

                                        // image: AssetImage("assets/images/contours.png"),
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
                                        softWrap:
                                            true, // Add this line to enable text wrapping
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
  }
}
