import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nishauri/src/features/dawa_drop/data/models/order_request/drug_order.dart';
import 'package:nishauri/src/utils/constants.dart';

class PendingOrders extends StatelessWidget {
  final List<DrugOrder> orders;

  const PendingOrders({Key? key, required this.orders}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(Constants.SPACING),
          child: Text(
            "All Pending Requests",
            style: theme.textTheme.headlineMedium,
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: orders.length,
            itemBuilder: (BuildContext context, int index) {
              final order = orders[index];
              return Column(
                children: [
                  const Divider(),
                  ListTile(
                    // leading: const Icon(Icons.all_inbox),
                    title: Text("Delivery Method: ${order.delivery_method ?? ''}"),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Appointment Date: ${ DateFormat("dd MMM yyy").format(
                            DateTime.parse(order.appointment?.appointment_date??''))}"),
                        Text("Courier Service: ${order.courierService?.name ?? ''}"),
                        Text("Deliver Person: ${order.deliveryPerson?.fullName ?? ''}"),
                        Text("Deliver Person Phone: ${order.deliveryPerson?.phoneNumber ?? ''}"),
                        Text("Deliver Status: ${order.status ?? ''}"),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
