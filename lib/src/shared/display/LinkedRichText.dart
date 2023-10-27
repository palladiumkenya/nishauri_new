import 'package:flutter/material.dart';

class LinkedRichText extends StatelessWidget {
  final String linked;
  final String unlinked;
  final double spacing;
  final MainAxisAlignment mainAxisAlignment;
  final void Function()? onPress;

  const LinkedRichText({
    super.key,
    this.onPress,
    required this.linked,
    required this.unlinked,
    this.spacing = 2,
    this.mainAxisAlignment = MainAxisAlignment.center,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      mainAxisAlignment: mainAxisAlignment,
      children: [
        Text(linked),
        SizedBox(
          height: spacing,
        ),
        GestureDetector(
          onTap: onPress,
          child: Text(
            unlinked,
            style: TextStyle(color: theme.primaryColor),
          ),
        )
      ],
    );
  }
}
