import 'package:flutter/material.dart';
import 'package:nishauri/src/utils/constants.dart';

class MenuOption extends StatelessWidget {
  final String title;
  final IconData icon;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? iconSize;
  final Color? iconColor;
  final void Function()? onPress;

  const MenuOption(
      {super.key,
      required this.title,
      required this.icon,
      this.padding,
      this.margin,
      this.iconSize,
      this.iconColor,
      this.onPress});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: padding,
      margin: margin,
      child: Column(
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
              onPressed: onPress,
              color: iconColor ?? theme.colorScheme.onPrimary,
              iconSize: iconSize,
              icon: Icon(icon),
            ),
          ),
          Text(
            title,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
