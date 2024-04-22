import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../app/navigation/menu/MenuItemsBuilder.dart';
import '../../../../app/navigation/menu/MenuOption.dart';
import '../../../../app/navigation/menu/menuItems.dart';
import '../../../../utils/constants.dart';
import '../../../clinic_card/data/providers/programProvider.dart';
import '../../data/providers/shortcut_provider.dart';

class ShortcutsWidget extends HookConsumerWidget {
  const ShortcutsWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final shortcuts = ref.watch(shortcutProvider);

    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(Constants.SPACING),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Shortcuts",
                style: theme.textTheme.titleSmall,
              ),
              InkWell(
                child: Text(
                  "Edit Shortcuts",
                  style: theme.textTheme.titleSmall
                      ?.copyWith(color: theme.colorScheme.primary),
                ),
                onTap: (){
                  _showDialog(context);
                },
              ),

            ],
          ),
        ),
        const SizedBox(height: Constants.SPACING),
        Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: Constants.SPACING * 2),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            ...getMenuItemByNames(context, shortcuts).map((item) {
              return InkWell(

                  onTap: item.onPressed,
                onLongPress: (){
                    _showDialog(context);
                },
                child: MenuOption(
                  title: item.title ?? "",
                  icon: item.icon,
                  bgColor: item.title == "Edit Shortcut"
                      ? theme.colorScheme.secondary
                      : null,
                ),
              );
            }).toList(),
            if (getMenuItemByNames(context, shortcuts).length < 3)
              MenuOption(
                title: "",
                icon: Icons.add,
                bgColor: theme.colorScheme.secondary,
                onPress: () {
                  _showDialog(context);
                },
              )
          ]),
        ),
      ],
    );
  }
}

_showDialog(BuildContext context) {
  final theme = Theme.of(context);
  return showDialog(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      icon: const Icon(Icons.construction),
      title: Text(
        "Select Shortcut MenuOptions",
        style: theme.textTheme.titleMedium,
      ),
      content: SizedBox(
        width: double.maxFinite,
        height: MediaQuery.of(context).size.height * 0.5,
        child: Consumer(
          builder: (context, ref, child) {
            final userProgram = ref.watch(programProvider);
            final shortcuts = ref.watch(shortcutProvider);
            final shortcutsNotifier = ref.watch(shortcutProvider.notifier);
            return userProgram.when(
              data: (data) => MenuItemsBuilder(
                itemBuilder: (item) => MenuOption(
                  title: item.title ?? "",
                  icon: item.icon,
                  onPress: () {
                    if (shortcuts.any((element) => element == item.title)) {
                      // Delete shortcut
                      shortcutsNotifier.deleteShortcut(
                        item.title ?? "",
                      );
                    } else {
                      // Add shortcut
                      if (shortcuts.length >= shortcutsNotifier.maxShortcuts) {
                        context.pop();
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content:
                                    Text("Max number of shortcuts reached")));
                      } else {
                        shortcutsNotifier.addShortcut(
                          item.title ?? "",
                        );
                      }
                    }
                  },
                  bgColor: shortcuts.any((element) => element == item.title)
                      ? theme.colorScheme.secondary
                      : null,
                ),
                items: [
                  // get generic menu items
                  ...getGenericMenuItems(context),
                  // get program menu items
                  ...data.map((e) {
                    final programCode = e.id;
                    return getProgramMenuItemByProgramCode(
                        context, programCode ?? '');
                  }).toList(),
                ],
              ),
              error: (error, _) => Center(child: Text(error.toString())),
              loading: () => const Center(
                child: CircularProgressIndicator(),
              ),
            );
          },
        ),
      ),
    ),
  );
}
