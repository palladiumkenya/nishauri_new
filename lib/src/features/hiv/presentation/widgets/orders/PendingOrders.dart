import 'package:flutter/material.dart';
import 'package:nishauri/src/features/hiv/data/models/art_orders/art_drug_order.dart';
import 'package:nishauri/src/shared/display/AppSearch.dart';
import 'package:nishauri/src/utils/constants.dart';

class PendingOrders extends StatelessWidget {
  final List<ARTDrugOrder> orders;

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
                    leading: const Icon(Icons.all_inbox),
                    title: Text("Delivery Method: ${order.delivery_method??''}"),
                    subtitle: Text("Deliver Status: ${order.status??''}"),
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
