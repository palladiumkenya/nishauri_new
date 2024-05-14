import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:nishauri/src/features/dawa_drop/data/models/order_request/drug_order.dart';
import 'package:nishauri/src/features/dawa_drop/data/providers/drug_order_provider.dart';
import 'package:nishauri/src/features/dawa_drop/presentation/widget/orders/AllOrders.dart';
import 'package:nishauri/src/features/dawa_drop/presentation/widget/orders/FulfilledOrders.dart';
import 'package:nishauri/src/shared/display/CustomeAppBar.dart';
import 'package:nishauri/src/shared/display/background_image_widget.dart';
import 'package:nishauri/src/utils/constants.dart';

class DrugOrdersScreen extends ConsumerWidget {
  const DrugOrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orderAsync = ref.watch(drugOrderProvider);
    final theme = Theme.of(context);

    return orderAsync.when(
      data: (data) {
        // Separate orders based on their status
        List<DrugOrder> allOrders = data;
        List<DrugOrder> pendingOrders =
            allOrders.where((order) => order.status != 'Fullfilled').toList();
        List<DrugOrder> approvedOrders =
            allOrders.where((order) => order.status == 'Approved').toList();
        List<DrugOrder> fulfilledOrders =
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
              backgroundColor: Constants.dawaDropColor.withOpacity(0.5),
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
      error: (error, _) => BackgroundImageWidget(
        customAppBar: CustomAppBar(
          title: "Confirm Delivery",
          icon: Icons.vaccines_sharp,
          color: Constants.dawaDropColor.withOpacity(0.5),
        ),
        svgImage: 'assets/images/background.svg',
        notFoundText: error.toString(),
      ),
      // Text(error.toString())),
      loading: () => Center(
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
