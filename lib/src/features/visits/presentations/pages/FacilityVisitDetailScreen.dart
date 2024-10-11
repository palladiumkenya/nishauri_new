import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nishauri/src/features/visits/data/providers/visits_provider.dart';
import 'package:nishauri/src/features/visits/presentations/widgets/AllergiesTab.dart';
import 'package:nishauri/src/features/visits/presentations/widgets/ComplaintsTab.dart';
import 'package:nishauri/src/features/visits/presentations/widgets/ConditionsTab.dart';
import 'package:nishauri/src/features/visits/presentations/widgets/Diagnosis.dart';
import 'package:nishauri/src/features/visits/presentations/widgets/LabResultsTab.dart';
import 'package:nishauri/src/features/visits/presentations/widgets/VitalsTab.dart';
import 'package:nishauri/src/shared/display/CustomAppBar.dart';
import 'package:nishauri/src/shared/display/CustomTabBar.dart';
import 'package:nishauri/src/shared/display/background_image_widget.dart';

class FacilityVisitDetailScreen extends HookConsumerWidget {
  final String visitId;

  const FacilityVisitDetailScreen({super.key, required this.visitId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final visitsAsync = ref.watch(visitProvider);
    final theme = Theme.of(context);
    final currentIndex = useState(0);

    final tabItems = [
      CustomTabBarItem(title: "Vitals"),
      CustomTabBarItem(title: "Allergies"),
      CustomTabBarItem(title: "Complaints"),
      CustomTabBarItem(title: "Conditions"),
      CustomTabBarItem(title: "Lab Results"),
      CustomTabBarItem(title: "Diagnosis"),
    ];

    return visitsAsync.when(
      data: (data) {
        final visitDetail =
            data.where((element) => element.uuid == visitId).first;

        final screen = [
          visitDetail.allergies.isEmpty ?
          const Center(
            child: BackgroundImageWidget(
                svgImage: 'assets/images/lab-empty-state.svg',
                notFoundText: "No vital records"),
          ) :

          VitalsTab(vitals: visitDetail.vitals),

          visitDetail.allergies.isEmpty ? const Center(
            child: BackgroundImageWidget(
                svgImage: 'assets/images/lab-empty-state.svg',
                notFoundText: "No Allergies records"),
          ):
          AllergiesTab(allergies: visitDetail.allergies),
          visitDetail.complaints.isEmpty ? const Center(
            child: BackgroundImageWidget(
                svgImage: 'assets/images/lab-empty-state.svg',
                notFoundText: "No complaints records"),
          ):
          ComplaintsTab(complaints: visitDetail.complaints),
          visitDetail.conditions.isEmpty ? const Center(
            child: BackgroundImageWidget(
                svgImage: 'assets/images/lab-empty-state.svg',
                notFoundText: "No condition records."),
          ):
          ConditionsTab(conditions: visitDetail.conditions),
          visitDetail.labResults.isEmpty ? const Center(
            child: BackgroundImageWidget(
                svgImage: 'assets/images/lab-empty-state.svg',
                notFoundText: "No Lab result records."),
          ):
          LabResultsTab(labResult: visitDetail.labResults),
          visitDetail.diagnosis.isEmpty ? const Center(
            child: BackgroundImageWidget(
                svgImage: 'assets/images/lab-empty-state.svg',
                notFoundText: "No Diagnosis records."),
          ):
          DiagnosisTab(diagnosis: visitDetail.diagnosis),
        ];

        return Scaffold(
            body: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CustomAppBar(
                  title: "Shared Health Records",
                  color: theme.primaryColor,
                ),
                CustomTabBar(onTap: (item, index){
                  currentIndex.value = index;
                },
                  activeColor: theme.primaryColor,
                  activeIndex: currentIndex.value,
                  items: tabItems,
                ),
                Expanded(child: screen[currentIndex.value]),
              ],
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
