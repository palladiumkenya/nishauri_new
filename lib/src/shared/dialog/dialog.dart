import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:material_dialogs/widgets/buttons/icon_outline_button.dart';
import 'package:nishauri/src/utils/constants.dart';
import 'package:nishauri/src/utils/routes.dart';

class HealthProgramDialog {
  final BuildContext context;

  HealthProgramDialog(this.context);

  void show() {
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
            Navigator.of(context).pop();
            context.goNamed(RouteNames.PROGRAME_REGISTRATION_SCREEN);
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
          textStyle: const TextStyle(color: Colors.white),
          iconColor: Colors.white,
        ),
      ],
    );
  }
}
