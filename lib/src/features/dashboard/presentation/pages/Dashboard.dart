import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:nishauri/src/features/hiv/presentation/pages/dashboard/HIVDashboard.dart';
import 'package:nishauri/src/features/user_programs/data/models/user_program.dart';
import 'package:nishauri/src/features/user_programs/data/providers/program_provider.dart';
import 'package:nishauri/src/utils/routes.dart';

import '../widgets/GeneralDashboard.dart';

class Dashboard extends ConsumerStatefulWidget {
  const Dashboard({super.key});

  @override
  ConsumerState<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends ConsumerState<Dashboard> {
  @override
  Widget build(BuildContext context) {
    final userPrograms = ref.watch(programProvider);

    return userPrograms.when(
      data: (data) => DefaultTabController(
        length: data.where(_hasDashboardData).length + 1,
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () => context.pop(),
              icon: const Icon(Icons.chevron_left),
            ),
            title: const Text("Dashboard"),
            bottom: TabBar(
              tabs: [
                const Tab(text: "General"),
                ...data
                    .where(_hasDashboardData)
                    .map(_getProgramTabBar)
                    .toList(),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              const GeneralDashboard(),
              ...data
                  .where(_hasDashboardData)
                  .map(_getProgramDashboard)
                  .toList(),
            ],
          ),
        ),
      ),
      error: (error, _) => Center(child: Text(error.toString())),
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

bool _hasDashboardData(UserProgram program) {
  final codes = [
    ProgramCodeNameIds.HIV,
  ];
  return codes.any((code) => code == program.program.program_code);
}

Tab _getProgramTabBar(UserProgram program) {
  final programCode = program.program.program_code;
  if(programCode==ProgramCodeNameIds.HIV){
    return const Tab(text: "ART",);
  }
  return Tab(
    // icon: const Icon(Icons.directions_car),
    text: program.program.name,
  );
}

Widget _getProgramDashboard(UserProgram program) {
  final programCode = program.program.program_code;
  if(programCode==ProgramCodeNameIds.HIV){
    return const HIVDashboardScreen();
  }
  return Center(child: Text(program.program.name?? ''));
}
