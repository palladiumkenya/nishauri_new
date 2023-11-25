import 'package:flutter/material.dart';
import 'package:nishauri/src/features/visits/data/models/diagnosis.dart';

class DiagnosisTab extends StatelessWidget {
  final List<Diagnosis> diagnosis;
  const DiagnosisTab({super.key, this.diagnosis =const[]});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("Diagnosis"),);
  }
}
