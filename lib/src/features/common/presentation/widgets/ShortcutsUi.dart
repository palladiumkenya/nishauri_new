import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nishauri/src/features/user/data/providers/user_provider.dart';
import 'package:nishauri/src/shared/input/Button.dart';

import '../../../../app/navigation/menu/MenuItemsBuilder.dart';
import '../../../../app/navigation/menu/MenuOption.dart';
import '../../../../app/navigation/menu/menuItems.dart';
import '../../../../utils/constants.dart';
import '../../../user_programs/data/providers/program_provider.dart';
import '../../data/providers/shortcut_provider.dart';

class ShortcutsWidget extends HookConsumerWidget {
  const ShortcutsWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final shortcuts = ref.watch(shortcutProvider);
    final adminAsync = ref.watch(userProvider);
    final List<String> roles = adminAsync.when(
      data: (data) => data.roles,
      error: (_, __) => [],
      loading: () => [],
    );

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
                  style: theme.textTheme.titleSmall?.copyWith(
                    color: theme.colorScheme.primary,
                  ),
                ),
                onTap: () {
                  _showDialog(context, roles);
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: Constants.SPACING),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: Constants.SPACING * 2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ...getMenuItemByNames(context, shortcuts, roles).map((item) {
                return GestureDetector(
                  onTap: item.onPressed,
                  onLongPress: () {
                    _showDialog(context, roles);
                  },
                  child: MenuOption(
                    title: item.title ?? "",
                    icon: item.shortcutIcon,
                    bgColor: item.title == "Edit Shortcut"
                        ? theme.colorScheme.secondary
                        : item.shortcutBackgroundColor,
                  ),
                );
              }).toList(),
              if (getMenuItemByNames(context, shortcuts, roles).length < 3)
                MenuOption(
                  title: "",
                  icon: const Icon(Icons.add),
                  bgColor: theme.colorScheme.secondary,
                  onPress: () {
                    _showDialog(context, roles);
                  },
                ),
            ],
          ),
        ),
      ],
    );
  }

  void _showDialog(BuildContext context, List<String> roles) {
    final theme = Theme.of(context);
    showDialog(
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
              final userProgram = ref.watch(userProgramProvider);
              final shortcuts = ref.watch(shortcutProvider);
              final shortcutsNotifier = ref.watch(shortcutProvider.notifier);
              return userProgram.when(
                data: (data) => MenuItemsBuilder(
                  itemBuilder: (item) => MenuOption(
                    title: item.title ?? "",
                    icon: item.shortcutIcon,
                    onPress: () {
                      if (shortcuts.contains(item.title)) {
                        // Delete shortcut
                        shortcutsNotifier.deleteShortcut(item.title ?? "");
                      } else {
                        // Add shortcut
                        if (shortcuts.length >= shortcutsNotifier.maxShortcuts) {
                          context.pop();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Max number of shortcuts reached"),
                            ),
                          );
                        } else {
                          shortcutsNotifier.addShortcut(item.title ?? "");
                        }
                      }
                    },
                    bgColor: shortcuts.contains(item.title)
                        ? theme.colorScheme.secondary
                        : item.shortcutBackgroundColor,
                  ),
                  items: [
                    // get generic menu items
                    ...getGenericMenuItems(context, roles),
                    // get program menu items
                    ...data.where((element) => element.isActive).map((e) {
                      final programCode = e.id;
                      return getProgramMenuItemByProgramCode(context, programCode ?? '');
                    }),
                  ],
                ),
                error: (error, _) => Center(child: Text(error.toString())),
                loading: () => const Center(child: CircularProgressIndicator()),
              );
            },
          ),
        ),
        actions: [
          Button(
            title: "Ok",
            onPress: () {
              context.pop();
            },
          ),
        ],
      ),
    );
  }
}
