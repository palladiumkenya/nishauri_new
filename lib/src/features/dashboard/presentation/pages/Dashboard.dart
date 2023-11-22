import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nishauri/src/features/dashboard/presentation/pages/widgets/GeneralDashboard.dart';
import 'package:nishauri/src/features/hiv/presentation/pages/dashboard/HIVDashboard.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => context.pop(),
            icon: const Icon(Icons.chevron_left),
          ),
          title: const Text("Dashboard"),
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.directions_car), text: "General"),
              Tab(icon: Icon(Icons.vaccines), text: "HIV",),
              Tab(icon: Icon(Icons.speed), text: "Hypertension",),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            GeneralDashboard(),
            HIVDashboardScreen(),
            Icon(Icons.directions_bike),
          ],
        ),
      ),
    );
  }
}
