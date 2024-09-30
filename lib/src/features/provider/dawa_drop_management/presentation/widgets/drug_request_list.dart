import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:nishauri/src/features/dawa_drop/data/models/order_request/drug_order.dart';
import 'package:nishauri/src/features/dawa_drop/data/providers/drug_order_provider.dart';
import 'package:nishauri/src/shared/dialog/dialog.dart';
import 'package:nishauri/src/shared/list_view_builder/list_view_builder.dart';
import 'package:nishauri/src/utils/constants.dart';

class DrugRequestList extends HookConsumerWidget {

  final List<DrugOrder> orders;

  const DrugRequestList({Key? key, required this.orders}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
              child: ListView.builder(
                  itemCount: orders.length,
                  itemBuilder: (context, index) {
                    final order = orders[index];
                    return RowViewList(
                      details: [
                        {"icon": Icons.ac_unit_outlined, 'text': "Delivery Method: ${order.delivery_method ?? ''}"},
                        if (order.courierService?.name != null && order.courierService?.name != '')
                        {"icon": Icons.bike_scooter_sharp, 'text': "Courier Service: ${order.courierService?.name ?? ''}"},
                        if (order.deliveryPerson?.fullName != null && order.deliveryPerson?.fullName != '')
                        {"icon": Icons.person, 'text': "Delivery Person: ${order.deliveryPerson?.fullName ?? ''}"},
                        if (order.deliveryPerson?.fullName != null && order.deliveryPerson?.fullName != '')
                        {"icon": Icons.phone_android, 'text': "Delivery Person: ${order.deliveryPerson?.phoneNumber ?? ''}"},
                        {"icon": Icons.today, 'text': "Date order posted: ${DateFormat('dd-MM-yyyy').format(DateTime.parse(order.date_order_posted ?? ''))}"},
                        {"icon": Icons.rotate_left_outlined, 'text': "Delivery Status: ${order.status ?? ''}"},
                      ],
                      onRowTap: (index) {
                        HealthProgramDialog(
                          context,
                          "Order id : ${order.order_id}",
                          "Approve Drug order request bellow",
                          Constants.providerBgColor.withOpacity(0.5),
                          "Approve",
                          Constants.providerBgColor.withOpacity(0.2),
                          "Reject",
                          Constants.providerBgColor,
                              (){
                            ref.refresh(drugOrderProvider);
                          },
                              (){
                            ref.refresh(drugOrderProvider);
                          },
                        ).show();
                      },
                    );
                  },
              ),
          ),
        ],
      ),
    );
  }
}