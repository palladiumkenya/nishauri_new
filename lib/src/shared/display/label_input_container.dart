import 'package:flutter/material.dart';
import 'package:nishauri/src/utils/constants.dart';

class LabelInputContainer extends StatelessWidget {
  final String label;
  final Widget child;
  const LabelInputContainer({super.key, required this.label, required this.child});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold),),
        const SizedBox(height: Constants.SPACING*0.5),
        child,
      ],
    );
  }
}
