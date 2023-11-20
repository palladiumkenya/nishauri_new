import 'package:flutter/material.dart';
import 'package:nishauri/src/shared/input/MultiChoiceCheckList.dart';

class HealthInformation extends StatelessWidget {
  const HealthInformation({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        SizedBox(child: MultiChoiceCheckList(),height: 100),
      ],
    );
  }
}
