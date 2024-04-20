import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nishauri/src/features/hiv/data/models/art_orders/art_drug_order.dart';
import 'package:nishauri/src/features/hiv/presentation/widgets/orders/DeliveryProgression.dart';
import 'package:nishauri/src/utils/constants.dart';

class FulfilledOrders extends StatelessWidget {
  final List<ARTDrugOrder> orders;

  const FulfilledOrders({Key? key, required this.orders}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(Constants.SPACING),
          child: Text(
            "Fulfilled Drug Requests",
            style: theme.textTheme.headlineMedium,
          ),
        ),
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

  Widget buildOrderTile(BuildContext context, ARTDrugOrder order) {
    return GestureDetector(
      onTap: () => navigateToDeliveryProgression(context, order),
      child: Column(
        children: [
          const Divider(),
          ListTile(
            title: Text("Delivery Method: ${order.delivery_method ?? ''}"),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Appointment Date: ${DateFormat("dd MMM yyy").format(DateTime.parse(order.appointment?.appointment_date ?? ''))}"),
                Text("Courier Service: ${order.courierService?.name ?? ''}"),
                Text("Deliver Person: ${order.deliveryPerson?.fullName ?? ''}"),
                Text("Deliver Person Phone: ${order.deliveryPerson?.phoneNumber ?? ''}"),
                Text("Deliver Status: ${order.status ?? ''}"),
              ],
            ),
            trailing: const Icon(Icons.chevron_right),
          ),
        ],
      ),
    );
  }

  void navigateToDeliveryProgression(BuildContext context, ARTDrugOrder order) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DeliverProgression(order: order),
      ),
    );
  }
}
