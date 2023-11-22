import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:nishauri/src/app/navigation/menu/MenuItemsBuilder.dart';
import 'package:nishauri/src/app/navigation/menu/MenuOption.dart';
import 'package:nishauri/src/app/navigation/menu/menuItems.dart';
import 'package:nishauri/src/features/common/data/providers/shortcut_provider.dart';
import 'package:nishauri/src/features/user_programs/data/providers/program_provider.dart';
import 'package:nishauri/src/utils/constants.dart';
import 'package:nishauri/src/utils/routes.dart';

class Greetings extends StatelessWidget {
  final String? image;
  final String name;

  const Greetings({super.key, this.image, required this.name});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    final headerHeight = screenSize.height * 0.25;
    final radius = screenSize.width * 0.12;

    return Container(
      margin: EdgeInsets.only(bottom: headerHeight * 0.3),
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          Container(
            height: headerHeight,
            width: screenSize.width,
            decoration: BoxDecoration(
              color: theme.primaryColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(radius),
                bottomRight: Radius.circular(radius),
              ),
            ),
          ),
          Positioned(
            bottom: -(headerHeight * 0.25),
            height: headerHeight * 1.25,
            width: screenSize.width * 0.85,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Hello 👋,",
                ),
                Text(
                  name,
                  style: const TextStyle(fontSize: 20),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(Constants.SPACING),
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.onPrimary,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(Constants.SPACING * 2),
                      ),
                    ),
                    child: Center(
                      child: Consumer(
                        builder: (context, ref, child) {
                          final shortcuts = ref.watch(shortcutProvider);
                          // final
                          return Wrap(
                            alignment: WrapAlignment.spaceBetween,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            spacing: Constants.SPACING,
                            runSpacing: Constants.SPACING,
                            children: [
                              ...getMenuItemByNames(context, shortcuts)
                                  .map((e) => MenuOption(
                                        title: e.title ?? "",
                                        icon: e.icon,
                                        onPress: e.onPressed,
                                      )),
                              MenuOption(
                                icon: Icons.add,
                                title: "Add Shortcut",
                                onPress: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        AlertDialog(
                                      icon: Icon(Icons.construction),
                                      title: Text(
                                        "Select Shortcut MenuOptions",
                                        style: theme.textTheme.titleMedium,
                                      ),
                                      content: Container(
                                        width: double.maxFinite,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.5,
                                        child: Consumer(
                                          builder: (context, ref, child) {
                                            final userProgram =
                                                ref.watch(programProvider);
                                            final shortcuts =
                                                ref.watch(shortcutProvider);
                                            final shortcutsNotifier = ref.watch(
                                                shortcutProvider.notifier);
                                            return userProgram.when(
                                              data: (data) => MenuItemsBuilder(
                                                itemBuilder: (item) =>
                                                    MenuOption(
                                                  title: item.title ?? "",
                                                  icon: item.icon,
                                                  onPress: () {
                                                    if (shortcuts.any(
                                                        (element) =>
                                                            element ==
                                                            item.title)) {
                                                      shortcutsNotifier
                                                          .deleteShortcut(
                                                        item.title ?? "",
                                                      );
                                                    } else {
                                                      shortcutsNotifier
                                                          .addShortcut(
                                                        item.title ?? "",
                                                      );
                                                    }
                                                  },
                                                  bgColor: shortcuts.any(
                                                          (element) =>
                                                              element ==
                                                              item.title)
                                                      ? theme
                                                          .colorScheme.secondary
                                                      : null,
                                                ),
                                                items: [
                                                  // get generic menu items
                                                  ...getGenericMenuItems(
                                                      context),
                                                  // get program menu items
                                                  ...data.map((e) {
                                                    final programCode =
                                                        e.program.programCode;
                                                    return getProgramMenuItemByProgramCode(
                                                        context, programCode);
                                                  }).toList(),
                                                ],
                                              ),
                                              error: (error, _) => Center(
                                                  child:
                                                      Text(error.toString())),
                                              loading: () => const Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
