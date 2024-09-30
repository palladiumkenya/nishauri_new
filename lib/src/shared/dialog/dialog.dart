import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:material_dialogs/widgets/buttons/icon_outline_button.dart';
import 'package:nishauri/src/utils/constants.dart';
import 'package:nishauri/src/utils/routes.dart';

class HealthProgramDialog {
  final BuildContext context;
  final msg;
  final tittle;
  final color;
  final okBtnTxt;
  final okBtnColor;
  final xBtnTxt;
  final xBtnColor;
  final Function()? okOnTap;
  final Function()? xOnTap;

  HealthProgramDialog(this.context, this.msg, this.tittle, this.color, this.okBtnTxt,this.okBtnColor, this.xBtnTxt, this.xBtnColor, this.okOnTap, this.xOnTap);

  void show() {
    Dialogs.bottomMaterialDialog(
      msg: msg,
      msgStyle: const TextStyle(color: Constants.labResultsColor),
      context: context,
      color: color,
      title: tittle,
      titleStyle: const TextStyle(color: Constants.labResultsColor, fontWeight: FontWeight.w600),
      actions: [
        IconsOutlineButton(
          onPressed: () {
            if (okOnTap != null) okOnTap!();
            Navigator.of(context).pop();
          },
          text: okBtnTxt,
          iconData: Icons.add,
          textStyle: const TextStyle(color: Colors.white),
          color: xBtnColor,
          iconColor: Colors.white,
        ),
        IconsButton(
          onPressed: () {
            if (xOnTap != null) xOnTap!();
            Navigator.of(context).pop();
          },
          text: xBtnTxt,
          iconData: Icons.cancel_outlined,
          color: xBtnColor,
          textStyle: const TextStyle(color: Colors.white),
          iconColor: Colors.white,
        ),
      ],
    );
  }
}
