import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import '../../utils/helpers.dart';
import '../input/Button.dart';

Future<bool?> showConfirmDeleteDialog(
    BuildContext context, String? message) async {
  final theme = Theme.of(context);
  final delete = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      content: Wrap(children: [
        Center(
          child: FaIcon(
            FontAwesomeIcons.circleXmark,
            size: 50,
            color: theme.colorScheme.error,
          ),
        ),
        Center(
          child: Text(
            message ?? "Confirm delete, Once deleted not reversible",
            textAlign: TextAlign.center,
            style: theme.textTheme.titleLarge,
          ),
        ),
        Wrap(
          children: [
            Button(
              title: "Delete",
              textColor: theme.colorScheme.error,
              onPress: () => context.pop(true),
            ),
            Button(
              title: "Cancel",
              textColor: theme.colorScheme.onSurface,
              onPress: () => context.pop(false),
            )
          ],
        )
      ]),
    ),
  );
  return delete;
}

Future<bool?> showSuccessMessageDialog(
    BuildContext context, String? message) async {
  final theme = Theme.of(context);
  final size = getOrientationAwareScreenSize(context);
  final delete = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      content: Wrap(children: [
        Center(
          child: FaIcon(
            FontAwesomeIcons.circleCheck,
            size: 100,
            color: Colors.green[600],
          ),
        ),
        Center(
          child: Text(
            message ?? "Confirm delete, Once deleted not reversible",
            textAlign: TextAlign.center,
            style: theme.textTheme.titleLarge,
          ),
        ),
        Wrap(
          children: [
            Button(
              title: "Ok",
              textColor: Colors.green[600],
              onPress: () => context.pop(true),
            ),
          ],
        )
      ]),
    ),
  );
  return delete;
}
