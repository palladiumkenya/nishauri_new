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
      return const CircularProgressIndicator();
    }

    return SizedBox(
      width: double.infinity,
      child: mode == ButtonMode.outline
          ? OutlinedButton(
              onPressed: onPress,
              child: Text(title),
            )
          : ElevatedButton(
              onPressed: onPress,
              child: Text(title),
            ),
    );
  }
}
