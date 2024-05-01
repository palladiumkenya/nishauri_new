import 'package:flutter/material.dart';

class MenuOption extends StatelessWidget {
  final String title;
  final Widget icon;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color? bgColor;
  final void Function()? onPress;

  const MenuOption({
    super.key,
    required this.title,
    required this.icon,
    this.padding,
    this.margin,
    this.bgColor,
    this.onPress,
  });

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
          FloatingActionButton(
            shape: const CircleBorder(),
            heroTag: null,
            onPressed: onPress,
            backgroundColor: bgColor,
            child: icon,
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
