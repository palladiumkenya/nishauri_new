import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HIVDashboardScreen extends StatelessWidget {
  const HIVDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.chevron_left),
        ),
        title: const Text("HIV Dashboard"),
      ),
    );
    ;
  }
}
