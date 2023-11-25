import 'package:flutter/material.dart';
import 'package:nishauri/src/features/visits/data/models/vital.dart';

class VitalsTab extends StatelessWidget {
  final List<Vital> vitals;
  const VitalsTab({super.key, this.vitals =const []});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("Vitals"),);
  }
}
