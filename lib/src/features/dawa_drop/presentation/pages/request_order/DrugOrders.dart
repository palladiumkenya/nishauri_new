import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nishauri/src/features/dawa_drop/data/models/order_request/drug_order.dart';
import 'package:nishauri/src/features/dawa_drop/data/providers/drug_order_provider.dart';
import 'package:nishauri/src/features/dawa_drop/presentation/widget/orders/active_orders.dart';
import 'package:nishauri/src/features/dawa_drop/presentation/widget/orders/FulfilledOrders.dart';
import 'package:nishauri/src/shared/display/CustomTabBar.dart';
import 'package:nishauri/src/shared/display/CustomeAppBar.dart';
import 'package:nishauri/src/shared/display/background_image_widget.dart';
import 'package:nishauri/src/utils/constants.dart';

class DrugOrdersScreen extends HookConsumerWidget {
  const DrugOrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orderAsync = ref.watch(drugOrderProvider);
    final theme = Theme.of(context);
    final currIndex = useState(0);

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
        final screens = [
          ActiveOrders(orders: pendingOrders),
          // PendingOrders(orders: pendingOrders),
          // ApprovedOrders(orders: approvedOrders),
          FulfilledOrders(orders: fulfilledOrders),
        ];

        return Scaffold(
            body: Column(
          children: [
            CustomAppBar(
              title: "Drug Requests 🛒",
              // icon: Icons.shopping_cart_checkout_sharp,
              color: Constants.dawaDropColor.withOpacity(0.5),
            ),
            CustomTabBar(
              activeIndex: currIndex.value,
              onTap: (item, index) {
                currIndex.value = index;
              },
              activeColor: Constants.dawaDropColor.withOpacity(0.5),
              items: const [
                CustomTabBarItem(
                  title: "Active Request",
                  icon: Icons.all_inbox,
                ),
                CustomTabBarItem(
                  title: "Fulfilled Request",
                  icon: Icons.done_all,
                ),
              ],
            ),
            Expanded(child: screens[currIndex.value]),
          ],
        ));
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
