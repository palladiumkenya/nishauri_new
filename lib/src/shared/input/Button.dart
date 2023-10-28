import 'package:flutter/material.dart';

import '../../utils/constants.dart';

enum ButtonMode { outline, contained }

class Button extends StatelessWidget {
  final String title;
  final bool loading;
  final bool disabled;
  final Color? backgroundColor;
  final Color? textColor;
  final Widget? prefixIcon;
  final Widget? surfixIcon;
  final ButtonMode mode;
  final int spacing;
  final double borderRadius;
  final MainAxisAlignment mainAxisAlignment;
  final EdgeInsetsGeometry? paddingGeometry;

  final void Function()? onPress;

  const Button(
      {super.key,
      required this.title,
      this.backgroundColor,
      this.onPress,
      this.textColor,
      this.prefixIcon,
      this.surfixIcon,
      this.loading = false,
      this.spacing = 15,
      this.borderRadius = Constants.ROUNDNESS,
      this.mode = ButtonMode.contained,
      this.mainAxisAlignment = MainAxisAlignment.center,
      this.paddingGeometry,
      this.disabled = false});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    if (loading) {
      return CircularProgressIndicator(color: theme.primaryColor);
    }
    final buttonChildren = [
      const SizedBox(width: 15),
      Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
          color: textColor ?? theme.colorScheme.onPrimary,
        ),
      ),
      const SizedBox(width: 15),
    ];
    if (prefixIcon != null) {
      buttonChildren.insert(0, prefixIcon!);
    }
    if (surfixIcon != null) {
      buttonChildren.add(surfixIcon!);
    }

    return GestureDetector(
      onTap: disabled ? null : onPress,
      child: Container(
        height: 50,
        decoration: mode == ButtonMode.contained
            ? BoxDecoration(
                color: disabled ? Colors.black26 :backgroundColor ?? Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(borderRadius),
              )
            : BoxDecoration(
                borderRadius: BorderRadius.circular(borderRadius),
                border: Border.all(
                  color: disabled ? Colors.black26 : theme.primaryColor,
                  width: 1,
                )),
        child: Padding(
          padding: paddingGeometry ?? const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: mainAxisAlignment,
            children: buttonChildren,
          ),
        ),
      ),
    );
  }
}
