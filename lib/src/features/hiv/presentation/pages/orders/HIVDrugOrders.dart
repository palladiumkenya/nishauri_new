import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:nishauri/src/features/hiv/data/models/art_orders/art_drug_order.dart';
import 'package:nishauri/src/features/hiv/data/providers/art_drug_order_provider.dart';
import 'package:nishauri/src/features/hiv/presentation/widgets/orders/AllOrders.dart';
import 'package:nishauri/src/features/hiv/presentation/widgets/orders/FulfilledOrders.dart';
import 'package:nishauri/src/features/hiv/presentation/widgets/orders/PendingOrders.dart';
import 'package:nishauri/src/utils/constants.dart';
import 'package:nishauri/src/utils/routes.dart';

class HIVDrugOrdersScreen extends ConsumerWidget {
  const HIVDrugOrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orderAsync = ref.watch(getOrderProvider);
    final theme = Theme.of(context);

    return orderAsync.when(
      data: (data) {
        // Separate orders based on their status
        List<ARTDrugOrder> allOrders = data;
        List<ARTDrugOrder> pendingOrders =
        allOrders.where((order) => order.status != 'Fullfilled').toList();
        List<ARTDrugOrder> approvedOrders =
        allOrders.where((order) => order.status == 'Approved').toList();
        List<ARTDrugOrder> fulfilledOrders =
        allOrders.where((order) => order.status == 'Fullfilled').toList();

        return DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: () => context.pop(),
                icon: const Icon(Icons.chevron_left),
              ),
              title: const Text("Drug Request"),
              backgroundColor: Theme.of(context).primaryColor,
              bottom: TabBar(
                tabs: const [
                  Tab(icon: Icon(Icons.all_inbox), text: "Active Drug Request"),
                  // Tab(icon: Icon(Icons.pending), text: "Pending"),
                  // Tab(icon: Icon(Icons.pending), text: "Approved"),
                  Tab(icon: Icon(Icons.done_all), text: "FullFilled Request"),
                ],
                labelColor: theme.colorScheme.onPrimary,
              ),
            ),
            // floatingActionButton: FloatingActionButton.extended(
            //   onPressed: () {
            //     context.goNamed(RouteNames.HIV_ART_DELIVERY_REQUEST_FORM,
            //         extra: {"payload": null, "type": null});
            //   },
            //   label: const Text("Order now"),
            //   icon: const Icon(Icons.add),
            // ),
            body: FractionallySizedBox(
              heightFactor: 1,
              child: TabBarView(
                children: [
                  // Populate tab views with respective orders
                  AllOrders(orders: pendingOrders),
                  // PendingOrders(orders: pendingOrders),
                  // ApprovedOrders(orders: approvedOrders),
                  FulfilledOrders(orders: fulfilledOrders),
                ],
              ),
            ),
          ),
        );
      },
      error: (error, _) => Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            error.toString(),
            style: theme.textTheme.headlineSmall,
          ),
          const SizedBox(height: Constants.SPACING * 2),
        ],
      )),
      // Text(error.toString())),
      loading: ()  => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Loading Drug requests",
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


final counter = StateProvider<int>((ref) => 0);
