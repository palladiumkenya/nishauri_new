import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:nishauri/src/features/dawa_drop/data/models/order_request/drug_order.dart';
import 'package:nishauri/src/features/dawa_drop/data/providers/drug_order_provider.dart';
import 'package:nishauri/src/local_storage/LocalStorage.dart';
import 'package:nishauri/src/shared/display/CustomeAppBar.dart';
import 'package:nishauri/src/shared/display/background_image_widget.dart';
import 'package:nishauri/src/shared/interfaces/notification_service.dart';
import 'package:nishauri/src/utils/constants.dart';
import 'package:nishauri/src/utils/routes.dart';

class DispatchedDrugs extends ConsumerWidget {
  const DispatchedDrugs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final dispatchedAsync = ref.watch(drugOrderProvider);

    return dispatchedAsync.when(
      data: (data) {
        List<DrugOrder> allOrders = data;
        List<DrugOrder> dispatchedOrders =
            allOrders.where((order) => order.status == 'Dispatched').toList();
        _saveAndSubscribeToDispatchedOrders(dispatchedOrders);

        // Subscribe to dispatched orders
        NotificationService.subscribeToTopic(
            dispatchedOrders, SubscriptionType.drugDeliveryDispatched);
        if (dispatchedOrders.isEmpty) {
          return Scaffold(
            body: BackgroundImageWidget(
                customAppBar: CustomAppBar(
                  title: "Dispatched Orders 🛒",
                  // icon: Icons.shopping_cart_checkout,
                  color: Constants.dawaDropColor.withOpacity(0.5),
                ),
                svgImage: 'assets/images/lab-empty-state.svg',
                notFoundText: "No Dispatched drug orders"),
          );
        } else {
          return Scaffold(
            body: Column(
              children: [
                CustomAppBar(
                  title: "Dispatched Drug Orders 🛒",
                  // icon: Icons.shopping_cart_checkout,
                  color: Constants.dawaDropColor.withOpacity(0.5),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: dispatchedOrders.length,
                    itemBuilder: (context, index) {
                      final order = dispatchedOrders[index];
                      return Column(
                        children: [
                          const Divider(),
                          ListTile(
                            title: Card(
                              child: Padding(
                                padding:
                                    const EdgeInsets.all(Constants.SPACING),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.calendar_month_outlined,
                                                color: Constants.dawaDropColor
                                                    .withOpacity(0.5),
                                              ),
                                              const SizedBox(
                                                  width: Constants.SPACING),
                                              Text(
                                                'Appointment: ${DateFormat("dd MMM yyy").format(DateTime.parse(order.appointment?.appointment_date ?? ''))}',
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                              height: Constants.SPACING),
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.calendar_month_outlined,
                                                color: Constants.dawaDropColor
                                                    .withOpacity(0.5),
                                              ),
                                              const SizedBox(
                                                  width: Constants.SPACING),
                                              Text(
                                                'Dispatched: ${DateFormat("dd MMM yyy").format(DateTime.parse(order.dispatched_date ?? ''))}',
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                              height: Constants.SPACING),
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.rotate_left_outlined,
                                                color: Constants.dawaDropColor
                                                    .withOpacity(0.5),
                                              ),
                                              const SizedBox(
                                                  width: Constants.SPACING),
                                              Text(
                                                  'Order Status: ${order.status ?? ''}'),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        color:
                                            theme.primaryColor.withOpacity(0.5),
                                        shape: BoxShape.rectangle,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: IconButton(
                                        onPressed: () {
                                          context.goNamed(
                                            RouteNames.CONFIRM_DELIVERY,
                                            extra: {"OrderId": order.order_id},
                                          );
                                        },
                                        icon: const Icon(Icons.forward),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        }
      },
      error: (error, _) => Scaffold(
        body: BackgroundImageWidget(
          customAppBar: CustomAppBar(
            title: "Dispatched Drug Orders 🛒",
            // icon: Icons.vaccines_sharp,
            color: Constants.dawaDropColor.withOpacity(0.5),
          ),
          svgImage: 'assets/images/lab-empty-state.svg',
          notFoundText: "No Dispatched order",
        ),
      ),
      loading: () => Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Loading Dispatched Orders",
                style: theme.textTheme.headline6,
              ),
              const SizedBox(height: Constants.SPACING * 2),
              const CircularProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _saveAndSubscribeToDispatchedOrders(
      List<DrugOrder> dispatchedOrders) async {
    String dispatchedOrdersJson =
        jsonEncode(dispatchedOrders.map((order) => order.toJson()).toList());
    await LocalStorage.save('dispatched_orders', dispatchedOrdersJson);

    // Retrieve dispatched orders from local storage
    String? cachedDispatchedOrdersJson =
        await LocalStorage.get('dispatched_orders');

    List<DrugOrder> cachedDispatchedOrders =
        (jsonDecode(cachedDispatchedOrdersJson) as List)
            .map((orderJson) => DrugOrder.fromJson(orderJson))
            .toList();

    NotificationService.subscribeToTopic(
        cachedDispatchedOrders, SubscriptionType.drugDeliveryDispatched);
    }
}
