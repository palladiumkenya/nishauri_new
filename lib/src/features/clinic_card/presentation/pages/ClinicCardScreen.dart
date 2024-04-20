import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:nishauri/src/features/clinic_card/data/providers/programProvider.dart';
import 'package:nishauri/src/features/clinic_card/presentation/widgets/clinicalDetails.dart';

class ClinicCardScreen extends ConsumerWidget {
  const ClinicCardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final programAsync = ref.watch(programProvider);

    return programAsync.when(
      data: (data) {
        return DefaultTabController(
          length: data.length,
          child: Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: () => context.pop(),
                icon: const Icon(Icons.chevron_left),
              ),
              title: const Text("My Clinic Card"),
              bottom: TabBar(
                tabs: data.map((program) => Tab(text: program.name)).toList(),
              ),
            ),
            body: TabBarView(
              children: data.map((program) => ClinicalDetailsTab(program: program)).toList(),
            ),
          ),
        );
      },
      error: (error, _) => Center(child: Text(error.toString())),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}
