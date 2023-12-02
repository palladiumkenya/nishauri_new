import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:nishauri/src/features/visits/data/providers/visits_provider.dart';
import 'package:nishauri/src/features/visits/presentations/widgets/AllergiesTab.dart';
import 'package:nishauri/src/features/visits/presentations/widgets/ComplaintsTab.dart';
import 'package:nishauri/src/features/visits/presentations/widgets/ConditionsTab.dart';
import 'package:nishauri/src/features/visits/presentations/widgets/Diagnosis.dart';
import 'package:nishauri/src/features/visits/presentations/widgets/LabResultsTab.dart';
import 'package:nishauri/src/features/visits/presentations/widgets/VitalsTab.dart';

class FacilityVisitDetailScreen extends ConsumerWidget {
  final String visitId;

  const FacilityVisitDetailScreen({super.key, required this.visitId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final visitsAsync = ref.watch(visitProvider);
    final theme = Theme.of(context);

    return visitsAsync.when(
      data: (data) {
        final visitDetail =
            data.where((element) => element.uuid == visitId).first;
        return DefaultTabController(
          length: 6,
          child: Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: () => context.pop(),
                icon: const Icon(Icons.chevron_left),
              ),
              title: const Text("Facility visit"),
              bottom: const TabBar(tabs: [
                Tab(text: "Vitals"),
                Tab(text: "Allergies"),
                Tab(text: "Complaints"),
                Tab(text: "Conditions"),
                Tab(text: "Lab Results"),
                Tab(text: "Diagnosis"),
              ]),
            ),
            body: TabBarView(
              children: [
                VitalsTab(vitals: visitDetail.vitals),
                AllergiesTab(allergies: visitDetail.allergies),
                ComplaintsTab(complaints: visitDetail.complaints),
                ConditionsTab(conditions: visitDetail.conditions),
                LabResultsTab(labResult: visitDetail.labResults),
                DiagnosisTab(diagnosis: visitDetail.diagnosis),
              ],
            ),
          ),
        );
      },
      error: (error, _) => Center(child: Text(error.toString())),
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
