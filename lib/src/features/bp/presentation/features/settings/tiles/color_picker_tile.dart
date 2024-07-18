import 'package:flutter/material.dart';
import 'package:nishauri/src/features/bp/presentation/components/color_picker.dart';

class ColorSelectionListTile extends StatelessWidget {
  final Widget title;
  final Widget? subtitle;
  final ValueChanged<Color> onMainColorChanged;
  final Color initialColor;
  final ShapeBorder? shape;

  const ColorSelectionListTile(
      {super.key,
        required this.title,
        required this.onMainColorChanged,
        required this.initialColor,
        this.subtitle,
        this.shape,});


  @override
  Widget build(BuildContext context) => ListTile(
    title: title,
    subtitle: subtitle,
    shape: shape,
    leading: (initialColor == Colors.transparent) ? null : CircleAvatar(
      backgroundColor: initialColor,
      radius: 12,
    ),
    onTap: () async {
      final color = await showColorPickerDialog(context, initialColor);
      if (color != null) onMainColorChanged(color);
    },
  );
}