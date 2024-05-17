import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:nishauri/src/app/navigation/menu/MenuItemsBuilder.dart';
import 'package:nishauri/src/app/navigation/menu/MenuOption.dart';
import 'package:nishauri/src/app/navigation/menu/menuItems.dart';
import 'package:nishauri/src/shared/display/CustomeAppBar.dart';
import 'package:nishauri/src/shared/display/background_image_widget.dart';
import 'package:nishauri/src/utils/routes.dart';

import '../../../../utils/constants.dart';
import '../../../user_programs/data/providers/program_provider.dart';

class ProgramsMenuScreen extends StatelessWidget {
  const ProgramsMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      // appBar: AppBar(
      //   // backgroundColor: theme.primaryColor,
      //   leading: IconButton(
      //     icon: const Icon(Icons.chevron_left),
      //     onPressed: () => context.pop(),
      //   ),
      //   title: const Center(child: Text("Programs")),
      // ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            context.goNamed(RouteNames.REMOVE_PROGRAM,);
          },
        label: const Text("Remove program"),
        icon: const Icon(Icons.remove),),
      body:
        Consumer(
          builder: (context, ref, child) {
            final userProgram = ref.watch(userProgramProvider);
            return Column(
              children: [
                CustomAppBar(
                  title: "Enrolled Programs",
                  icon: Icons.file_copy_sharp,
                  // color: Colors.white30,
                ),
                // Container(
                //   padding: const EdgeInsets.all(Constants.SPACING),
                //   child: const FormInputTextField(
                //     prefixIcon: Icons.search,
                //     placeholder: "Search...",
                //   ),
                // ),
                Expanded(
                  child: userProgram.when(
                    data: (data) {
                      final activePrograms = data.where((program) => program.isActive == true).toList();
                      return MenuItemsBuilder(
                        itemBuilder: (item) => MenuOption(
                          title: item.title ?? "",
                          icon: item.shortcutIcon,
                          onPress: item.onPressed,
                        ),
                        items: [
                          // get program menu items for active programs only
                          ...activePrograms.map((e) {
                            final programCode = e.id;
                            log("***********************${e.program_name}-${e.id}****************************");

                            return getProgramMenuItemByProgramCode(context, programCode ?? '');
                          }).toList(),
                          MenuItem(
                            icon: Icon(
                              Icons.add,
                              size: Constants.iconSize,
                              color: theme.colorScheme.inversePrimary,
                            ),
                            shortcutIcon: Icon(
                              Icons.add,
                              color: theme.colorScheme.inversePrimary,
                            ),
                            // color: theme.colorScheme.primary,
                            title: "Add Programme",
                            onPressed: () => context.goNamed(
                                RouteNames.PROGRAME_REGISTRATION_SCREEN),
                          ),
                        ],
                      );
                    },
                    error: (error, _) => BackgroundImageWidget(
                      svgImage: 'assets/images/background.svg',
                      notFoundText: error.toString(),
                    ),
                    loading: () => const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      );
  }
}
