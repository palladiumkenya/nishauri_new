import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:nishauri/src/app/navigation/menu/MenuItemsBuilder.dart';
import 'package:nishauri/src/app/navigation/menu/MenuOption.dart';
import 'package:nishauri/src/app/navigation/menu/menuItems.dart';
import 'package:nishauri/src/utils/routes.dart';

import '../../../user_programs/data/providers/program_provider.dart';

class ProgramsMenuScreen extends StatelessWidget {
  const ProgramsMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.primaryColor,
        leading: IconButton(
          icon: const Icon(Icons.chevron_left),
          onPressed: () => context.pop(),
        ),
        title: const Center(child: Text("Programs")),
      ),
      body:
        Consumer(
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
                Expanded(
                  child: userProgram.when(
                    data: (data) => MenuItemsBuilder(
                      itemBuilder: (item) => MenuOption(
                        title: item.title ?? "",
                        icon: item.icon,
                        // iconSize: 50,
                        onPress: item.onPressed,
                        // iconColor: theme.colorScheme.primary,
                        // bgColor: item.title == "Add Programme"
                        //     ? theme.colorScheme.secondary
                        //     : null,
                      ),
                      items: [
                        // get program menu items
                        ...data.map((e) {
                          final programCode = e.id;
                          print(e.id);
                          return getProgramMenuItemByProgramCode(context, programCode?? '');
                        }).toList(),
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
      );
  }
}
