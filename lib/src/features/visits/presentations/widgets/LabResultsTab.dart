import 'package:flutter/material.dart';
import 'package:nishauri/src/features/visits/data/models/lab_result.dart';

class LabResultsTab extends StatelessWidget {
  final List<LabResult> labResult;
  const LabResultsTab({super.key, this.labResult=const[]});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("Lab results"),);
  }
}
