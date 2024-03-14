import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:nishauri/src/features/hiv/presentation/pages/treatment_support/ARTTreatentSupport.dart';

import '../../../../utils/routes.dart';
import '../../../user_programs/data/models/user_program.dart';
import '../../../user_programs/data/providers/program_provider.dart';

class TreatmentSupport extends ConsumerWidget {
  const TreatmentSupport({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userPrograms = ref.watch(programProvider);

    return userPrograms.when(
      data: (data) {
        final programsWithTreatmentSupporters = data
            .where(_hasTreatmentSupporters);
        return DefaultTabController(
          length: programsWithTreatmentSupporters.length + 2,
          child: Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: () => context.pop(),
                icon: const Icon(Icons.chevron_left),
              ),
              title: const Text("Treatment Supporters"),
              bottom: TabBar(
                tabs: [
                  const Tab(text: "TB",),
                  const Tab(text: "MNCH",),
                  ...programsWithTreatmentSupporters
                      .map(_getProgramTabBar)
                      .toList(),
                ],
              ),
            ),
            body: TabBarView(
              children: [
                const Center(child: Text("TB Supporters")),
                const Center(child: Text("MNCH Supporters")),
                ...programsWithTreatmentSupporters
                    .map(_getProgramAppointments)
                    .toList(),

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



bool _hasTreatmentSupporters(UserProgram program) {
  final codes = [
    ProgramCodeNameIds.HIV,
  ];
  return codes.any((code) => code == program.program.program_code);
}

Tab _getProgramTabBar(UserProgram program) {
  final programCode = program.program.program_code;
  if (programCode == ProgramCodeNameIds.HIV) {
    return const Tab(
      text: "ART",
    );
  }
  return Tab(
    // icon: const Icon(Icons.directions_car),
    text: program.program.name,
  );
}

Widget _getProgramAppointments(UserProgram program) {
  final programCode = program.program.program_code;
  if (programCode == ProgramCodeNameIds.HIV) {
    return const ARTTreatmentSupportersScreen();
  }
  return Center(child: Text(program.program.name?? ''));
}
