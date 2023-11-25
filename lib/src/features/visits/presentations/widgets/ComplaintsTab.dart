import 'package:flutter/material.dart';
import 'package:nishauri/src/features/visits/data/models/complaint.dart';

class ComplaintsTab extends StatelessWidget {
  final List<Complaint> complaints;
  const ComplaintsTab({super.key, this.complaints=const[]});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("Complaints"),);
  }
}
