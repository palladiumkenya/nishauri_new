import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
      data: (data) => _buildData(context, data, currIndex),
      error: (error, _) => _buildError(context, error),
      loading: () => _buildLoading(theme),
    );
  }

  Widget _buildData(BuildContext context, List<DrugOrder> data, ValueNotifier<int> currIndex) {
    List<DrugOrder> pendingOrders = data.where((order) => order.status != 'Fullfilled').toList();
    List<DrugOrder> fulfilledOrders = data.where((order) => order.status == 'Fullfilled').toList();

    final screens = [
      ActiveOrders(orders: pendingOrders),
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
      ),
    );
  }

  Widget _buildError(BuildContext context, Object error) {
    return BackgroundImageWidget(
      customAppBar: CustomAppBar(
        title: "Confirm Delivery",
        icon: Icons.vaccines_sharp,
        color: Constants.dawaDropColor.withOpacity(0.5),
      ),
      svgImage: 'assets/images/background.svg',
      notFoundText: error.toString(),
    );
  }

  Widget _buildLoading(ThemeData theme) {
    return Center(
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
    );
  }
}
