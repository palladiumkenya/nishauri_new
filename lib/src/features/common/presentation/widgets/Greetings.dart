import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:material_dialogs/dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:material_dialogs/widgets/buttons/icon_outline_button.dart';
import 'package:nishauri/src/features/user_programs/data/providers/program_provider.dart';
import 'package:nishauri/src/utils/constants.dart';
import 'package:nishauri/src/utils/routes.dart';

class Greetings extends ConsumerWidget {
  final String? image;
  final String name;

  const Greetings({super.key, this.image, required this.name});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final programState = ref.watch(userProgramProvider);

    // Check if the program list is empty or if all programs are inactive
    final showUpdateProgram = programState.when(
      data: (programs) => programs.isEmpty ||
          programs.every((program) => program.isActive == false),
      error: (error, stack) => false,
      loading: () => false,
    );

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(Constants.SPACING),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Constants.SMALL_SPACING),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hey, 👋",
                        style: theme.textTheme.headlineSmall?.copyWith(
                          color: theme.colorScheme.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      if (name == 'Null Null' || name == null)
                        GestureDetector(
                          onTap: () {
                            context.goNamed(RouteNames.PROFILE_EDIT_FORM);
                          },
                          child: Text(
                            'Click here to update your profile',
                            style: theme.textTheme.titleMedium?.copyWith(
                              color: Colors.red,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        )
                      else
                        Text(
                          name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.bodyLarge?.copyWith(
                            color: theme.colorScheme.primary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      const SizedBox(height: Constants.SPACING),
                      Text(
                        DateFormat("EEEE, MMMM dd").format(DateTime.now()),
                        style: theme.textTheme.titleMedium,
                      ),
                    ],
                  ),
                ),
                if (showUpdateProgram)
                  Expanded(
                    child: BlinkingText(),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class BlinkingText extends StatefulWidget {
  @override
  _BlinkingTextState createState() => _BlinkingTextState();
}

class _BlinkingTextState extends State<BlinkingText> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onTap() {
    Dialogs.bottomMaterialDialog(
      msg: 'Tap to Choose and Enrol in a Program',
      msgStyle: const TextStyle(color: Constants.labResultsColor),
      context: context,
      color: Constants.labResultsShortcutBgColor,
      title: 'Take Control of Your Health – Join A Program and Start Your Journey Today!',
      titleStyle: const TextStyle(color: Constants.labResultsColor, fontWeight: FontWeight.w600),
      actions: [
        IconsOutlineButton(
          onPressed: () {
            context.goNamed(RouteNames.PROGRAME_REGISTRATION_SCREEN);
            Navigator.of(context).pop();
          },
          text: 'Opt-In',
          iconData: Icons.add,
          textStyle: const TextStyle(color: Colors.white),
          color: Constants.labResultsColor,
          iconColor: Colors.white,
        ),
        IconsButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          text: 'Not now',
          iconData: Icons.cancel_outlined,
          color: Constants.labResultsShortcutBgColor,
          textStyle: TextStyle(color: Colors.white),
          iconColor: Colors.white,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: _onTap,
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Opacity(
            opacity: _animationController.value,
            child: Text(
              "Tap to update program",
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.primary,
                fontWeight: FontWeight.w400,
              ),
            ),
          );
        },
      ),
    );
  }
}
