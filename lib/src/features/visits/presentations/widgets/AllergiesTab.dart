import 'package:flutter/material.dart';
import 'package:nishauri/src/features/visits/data/models/allergy.dart';

class AllergiesTab extends StatelessWidget {
  final List<Allergy> allergies;

  const AllergiesTab({super.key, this.allergies = const []});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("Allergies"),
    );
  }
}
