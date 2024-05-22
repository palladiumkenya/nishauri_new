import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:nishauri/src/app/navigation/menu/MenuItemsBuilder.dart';
import 'package:nishauri/src/app/navigation/menu/MenuOption.dart';
import 'package:nishauri/src/app/navigation/menu/menuItems.dart';
import 'package:nishauri/src/shared/display/CustomeAppBar.dart';
import 'package:nishauri/src/shared/display/background_image_widget.dart';
import 'package:nishauri/src/shared/input/Button.dart';
import 'package:nishauri/src/utils/routes.dart';

import '../../../../utils/constants.dart';
import '../../../user_programs/data/providers/program_provider.dart';

class ProgramsMenuScreen extends StatelessWidget {
  const ProgramsMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: Consumer(
        builder: (context, ref, child) {
          final userProgram = ref.watch(userProgramProvider);
          return Column(
            children: [
              const CustomAppBar(
                color: Constants.programsColor,
                subTitle: "Keep track of all your programs you belong to",
                title: "Enrolled Programs",
                icon: Icons.file_copy_sharp,
                // color: Colors.white30,
              ),
              Expanded(
                child: userProgram.when(
                  data: (data) {
                    final activePrograms = data
                        .where((program) => program.isActive == true)
                        .toList();
                    if (activePrograms.isEmpty) {
                      return const Center(
                        child: BackgroundImageWidget(
                          notFoundText:
                              "Your are not enrolled to a program yet.Get \nstarted by adding a program",
                          svgImage: "assets/images/add-appointment-large.svg",
                        ),
                      );
                    }
                    return Padding(
                      padding: const EdgeInsets.all(Constants.SPACING),
                      child: ListView.builder(
                        itemCount: activePrograms.length,
                        itemBuilder: (context, index) {
                          final item = activePrograms[index];
                          return Card(
                            elevation: 0.5,
                            child: ListTile(
                              title: Text(
                                item.program_name ?? "",
                                style: theme.textTheme.titleLarge
                                    ?.copyWith(fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text("Date enrolled: ${DateFormat("dd/MM/yyyy").format(item.createdAt!)}"),
                              leading: const FaIcon(
                                FontAwesomeIcons.layerGroup,
                                color: Constants.programsColor,
                              ),
                              onTap: getProgramMenuItemByProgramCode(context,item.id ?? "").onPressed,
                            ),
                          );
                        },
                      ),
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
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: Constants.SPACING,
                    vertical: Constants.SPACING * 2),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Button(
                        textColor: Colors.white,
                        backgroundColor: Constants.programsColor,
                        title: "Add Program",
                        surfixIcon: const FaIcon(FontAwesomeIcons.plus),
                        onPress: () => context.goNamed(
                          RouteNames.PROGRAME_REGISTRATION_SCREEN,
                        ),
                      ),
                    ),
                    const SizedBox(width: Constants.SPACING),
                    if (userProgram.valueOrNull
                            ?.where((program) => program.isActive == true)
                            .isNotEmpty ==
                        true)
                      Expanded(
                        child: Button(
                          textColor: Colors.white,
                          backgroundColor: Constants.programsColor,
                          title: "Remove program",
                          surfixIcon:
                              const FaIcon(FontAwesomeIcons.solidTrashCan),
                          onPress: () {
                            context.goNamed(
                              RouteNames.REMOVE_PROGRAM,
                            );
                          },
                        ),
                      )
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
