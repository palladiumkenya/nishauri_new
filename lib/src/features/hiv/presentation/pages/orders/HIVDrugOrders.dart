import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class HIVDrugOrdersScreen extends StatelessWidget {
  const HIVDrugOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    debugPrint("********************| Order |**********************");
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.chevron_left),
        ),
        title: const Text("ARV Drug Orders"),
      ),
      body: Builder(builder: (context) {
        debugPrint("********************| Builder |**********************");
        return Consumer(
          builder: (child, ref, widget) => Column(
            children: [
              Text("${ref.watch(counter)}"),
              IconButton(
                onPressed: () {
                  ref.read(counter.notifier).state++;
                },
                icon: const Icon(Icons.plus_one),
              )
            ],
          ),
        );
      }),
    );
  }
}

final counter = StateProvider<int>((ref) => 0);
