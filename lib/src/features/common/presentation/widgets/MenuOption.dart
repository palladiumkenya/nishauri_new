import 'package:flutter/material.dart';
import 'package:nishauri/src/utils/constants.dart';

class MenuOption extends StatelessWidget {
  final String title;
  final IconData icon;

  const MenuOption({super.key, required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            color: theme.colorScheme.primary,
            borderRadius: const BorderRadius.all(
              Radius.circular(Constants.ROUNDNESS * 10),
            ),
          ),
          child: IconButton(
            onPressed: () {},
            color: theme.colorScheme.onPrimary,
            icon: Icon(icon),
          ),
        ),
        Text(
          title,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
