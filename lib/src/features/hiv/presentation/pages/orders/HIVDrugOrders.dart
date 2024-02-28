import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:nishauri/src/features/hiv/presentation/widgets/orders/AllOrders.dart';
import 'package:nishauri/src/features/hiv/presentation/widgets/orders/FulfilledOrders.dart';
import 'package:nishauri/src/features/hiv/presentation/widgets/orders/PendingOrders.dart';
import 'package:nishauri/src/utils/routes.dart';

class HIVDrugOrdersScreen extends StatelessWidget {
  const HIVDrugOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => context.pop(),
            icon: const Icon(Icons.chevron_left),
          ),
          title: const Text("ARV Drug Orders"),
          backgroundColor: Theme
              .of(context)
              .primaryColor,
          bottom: TabBar(tabs: const [
            Tab(icon: Icon(Icons.all_inbox), text: "All"),
            Tab(icon: Icon(Icons.pending), text: "Pending"),
            Tab(icon: Icon(Icons.done_all), text: "FullField"),
          ], labelColor: theme.colorScheme.onPrimary,),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            context.goNamed(RouteNames.HIV_ART_DELIVERY_REQUEST_FORM, extra: {"payload":null, "type":null});
          },
          label: const Text("Order now"),
          icon: const Icon(Icons.add),
        ),
        body: const FractionallySizedBox(
          heightFactor: 1,
          child: TabBarView(
            children: [
              AllOrders(),
              PendingOrders(),
              FulfilledOrders(),
            ],
          ),
        ),
      ),
    );
  }
}

final counter = StateProvider<int>((ref) => 0);
