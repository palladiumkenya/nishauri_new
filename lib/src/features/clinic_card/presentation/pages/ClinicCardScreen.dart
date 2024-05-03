import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nishauri/src/features/clinic_card/data/providers/programProvider.dart';
import 'package:nishauri/src/features/clinic_card/presentation/widgets/clinicalDetails.dart';
import 'package:nishauri/src/shared/display/CustomTabBar.dart';
import 'package:nishauri/src/shared/display/CustomeAppBar.dart';
import 'package:nishauri/src/utils/constants.dart';

class ClinicCardScreen extends HookConsumerWidget {
  const ClinicCardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final programAsync = ref.watch(programProvider);
    final currIndex = useState(0);
    return programAsync.when(
      data: (data) {
        final screens =
            data.map((program) => ClinicalDetailsTab(program: program));

        return Scaffold(
          body: Column(
            children: [
              CustomAppBar(
                title: "My Clinic card",
                icon: Icons.file_present,
                color: Colors.blue[900],
                subTitle: "Access medical services using \nyour clinic cards",
              ),
              CustomTabBar(
                onTap: (item, index) {
                  currIndex.value = index;
                },
                items: data
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
      error: (error, _) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              error.toString(),
              style: theme.textTheme.headlineSmall,
            ),
            const SizedBox(height: Constants.SPACING * 2),
          ],
        ),
      ),
      // Text(error.toString())),
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
