import 'package:flutter/material.dart';

class SliderListTile extends StatelessWidget {

  final Widget title;
  final Widget? subtitle;
  final Widget? leading;
  final Widget? trailing;
  final double min;
  final double max;
  final double stepSize;
  final double value;
  final void Function(double newValue) onChanged;
  const SliderListTile({
    super.key,
    required this.title,
    this.subtitle,
    required this.onChanged,
    required this.value,
    required this.min,
    required this.max,
    this.stepSize = 1,
    this.leading,
    this.trailing,});

  @override
  Widget build(BuildContext context) => ListTile(
      title: title,
      leading: leading,
      trailing: trailing,
      subtitle: (subtitle == null) ? _buildSlider() : Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          subtitle!,
          _buildSlider(),
        ],
      ),
    );

  Widget _buildSlider() => SizedBox(
      height: 30,
      child: Slider(
        value: value,
        min: min,
        max: max,
        divisions: (max - min) ~/ stepSize,
        onChanged: onChanged,
      ),
    );

}
