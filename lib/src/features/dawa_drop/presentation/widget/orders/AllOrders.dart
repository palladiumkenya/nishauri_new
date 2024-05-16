import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nishauri/src/features/dawa_drop/data/models/order_request/drug_order.dart';
import 'package:nishauri/src/features/dawa_drop/presentation/widget/orders/DeliveryProgression.dart';
import 'package:nishauri/src/utils/constants.dart';

class AllOrders extends StatelessWidget {
  final List<DrugOrder> orders;

  const AllOrders({Key? key, required this.orders}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        // Padding(
        //   padding: const EdgeInsets.all(Constants.SPACING),
        //   child: Text(
        //     "Active Drug Requests",
        //     style: theme.textTheme.headlineMedium,
        //   ),
        // ),
        Expanded(
          child: ListView.builder(
            itemCount: orders.length,
            itemBuilder: (BuildContext context, int index) {
              final order = orders[index];
              return buildOrderTile(context, order);
            },
          ),
        ),
      ],
    );
  }

  Widget buildOrderTile(BuildContext context, DrugOrder order) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: () => navigateToDeliveryProgression(context, order),
      child: Column(
        children: [
          const Divider(),
          ListTile(
            title: Card(
              child: Padding(
                padding: const EdgeInsets.all(Constants.SPACING),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Delivery Method: ${order.delivery_method ?? ''}',
                      style: theme.textTheme.headline6,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    const SizedBox(height: Constants.SPACING),
                    Row(
                      children: [
                        Icon(
                          Icons.date_range_sharp,
                          color: Constants.dawaDropColor.withOpacity(0.5),
                        ),
                        const SizedBox(width: Constants.SPACING),
                        Text("Appointment Date: ${DateFormat("dd MMM yyy").format(DateTime.parse(order.appointment?.appointment_date ?? ''))}"),
                      ],
                    ),
                    const SizedBox(height: Constants.SPACING),
                    Row(
                      children: [
                        Icon(
                          Icons.bike_scooter_sharp,
                          color: Constants.dawaDropColor.withOpacity(0.5),
                        ),
                        const SizedBox(width: Constants.SPACING),
                        Text("Courier Service: ${order.courierService?.name ?? ''}"),
                      ],
                    ),
                    const SizedBox(height: Constants.SPACING),
                    Row(
                      children: [
                        Icon(
                          Icons.person,
                          color: Constants.dawaDropColor.withOpacity(0.5),
                        ),
                        const SizedBox(width: Constants.SPACING),
                        Text("Deliver Person: ${order.deliveryPerson?.fullName ?? ''}"),
                      ],
                    ),
                    const SizedBox(height: Constants.SPACING),
                    Row(
                      children: [
                        Icon(
                          Icons.phone_android,
                          color: Constants.dawaDropColor.withOpacity(0.5),
                        ),
                        const SizedBox(width: Constants.SPACING),
                        Text("Deliver Person Phone: ${order.deliveryPerson?.phoneNumber ?? ''}"),
                      ],
                    ),
                    const SizedBox(height: Constants.SPACING),

                    Row(
                      children: [
                        Icon(
                          Icons.rotate_left_outlined,
                          color: Constants.dawaDropColor.withOpacity(0.5),
                        ),
                        const SizedBox(width: Constants.SPACING),
                        Text("Deliver Status: ${order.status ?? ''}"),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            // title: Text("Delivery Method: ${order.delivery_method ?? ''}"),
            // subtitle: Column(
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   children: [
            //     Text("Appointment Date: ${DateFormat("dd MMM yyy").format(DateTime.parse(order.appointment?.appointment_date ?? ''))}"),
            //     Text("Courier Service: ${order.courierService?.name ?? ''}"),
            //     Text("Deliver Person: ${order.deliveryPerson?.fullName ?? ''}"),
            //     Text("Deliver Person Phone: ${order.deliveryPerson?.phoneNumber ?? ''}"),
            //     Text("Deliver Status: ${order.status ?? ''}"),
            //   ],
            // ),
            // trailing: const Icon(Icons.chevron_right),
          ),
        ],
      ),
    );
  }

  void navigateToDeliveryProgression(BuildContext context, DrugOrder order) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DeliverProgression(order: order),
      ),
    );
  }
}
