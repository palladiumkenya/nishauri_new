import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nishauri/src/features/clinic_card/data/providers/programProvider.dart';
import 'package:nishauri/src/features/clinic_card/presentation/widgets/clinicalDetails.dart';
import 'package:nishauri/src/shared/display/CustomTabBar.dart';
import 'package:nishauri/src/shared/display/CustomeAppBar.dart';
import 'package:nishauri/src/shared/display/background_image_widget.dart';
import 'package:nishauri/src/utils/constants.dart';

import '../../../user_programs/data/providers/program_provider.dart';

class ClinicCardScreen extends HookConsumerWidget {
  const ClinicCardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final programAsync = ref.watch(programProvider);
    final userPrograms = ref.watch(userProgramProvider);

    final currIndex = useState(0);
    return programAsync.when(
      data: (data) {
        final activePrograms = data.where((element) {
          if (userPrograms.hasValue) {
            return userPrograms.value!
                .where((e) => element.name == e.program_name && e.isActive)
                .isNotEmpty;
          }
          return false;
        });
        // Check if the data list is empty
        if (activePrograms.isEmpty) {
          return BackgroundImageWidget(
            customAppBar: CustomAppBar(
              title: "My Clinic Card",
              icon: Icons.file_present,
              subTitle: "Access medical services using \nyour clinic cards",
              color: Colors.blue[900],
            ),
            svgImage: 'assets/images/lab-empty-state.svg',
            notFoundText: "No programs available",
          );
        }
        final screens =
            activePrograms.map((program) => ClinicalDetailsTab(program: program));

        return Scaffold(
          body: Column(
            children: [
              CustomAppBar(
                title: "My Clinic Card",
                icon: Icons.file_present,
                color: Colors.blue[900],
                subTitle: "Access medical services using \nyour clinic cards",
              ),
              CustomTabBar(
                onTap: (item, index) {
                  currIndex.value = index;
                },
                activeColor: Constants.clinicCardColor,
                items: activePrograms
                    .map(
                      (program) => CustomTabBarItem(
                        title: program.name,
                        icon: Icons.multiple_stop,
                      ),
                    )
                    .toList(),
                activeIndex: currIndex.value,
              ),
              Expanded(child: screens.elementAt(currIndex.value))
            ],
          ),
        );
      },
      error: (error, _) => BackgroundImageWidget(
        svgImage: 'assets/images/lab-empty-state.svg',
        notFoundText: error.toString(),
      ),
      loading: () => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Loading Programs",
              style: theme.textTheme.headline6,
            ),
            const SizedBox(height: Constants.SPACING * 2),
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
