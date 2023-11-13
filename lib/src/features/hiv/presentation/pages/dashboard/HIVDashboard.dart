import 'package:fl_chart/fl_chart.dart';
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
      body: ListView(
        children: const [
          //Initialize the chart widget
          Card(
            child: SizedBox(
              height: 300,
            ),
          ),
          Card(
            child: SizedBox(
              height: 300,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                //Initialize the spark charts widget
              ),
            ),
          ),
          Card(
            child: SizedBox(
              height: 300,
            ),
          )
        ],
      ),
    );
  }
}

