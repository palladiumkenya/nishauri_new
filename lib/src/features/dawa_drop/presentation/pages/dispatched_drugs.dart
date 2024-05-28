import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:nishauri/src/features/appointments/data/providers/appointment_provider.dart';
import 'package:nishauri/src/features/hiv/data/models/art_orders/art_drug_order.dart';
import 'package:nishauri/src/features/hiv/data/providers/art_drug_order_provider.dart';
import 'package:nishauri/src/shared/display/CustomeAppBar.dart';
import 'package:nishauri/src/shared/display/background_image_widget.dart';
import 'package:nishauri/src/utils/constants.dart';
import 'package:nishauri/src/utils/routes.dart';

class DispatchedDrugs extends ConsumerWidget {
  const DispatchedDrugs({Key? key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final dispatchedAsync = ref.watch(getOrderProvider);

    return dispatchedAsync.when(
      data: (data) {
        List<ARTDrugOrder> allOrders = data;
        List<ARTDrugOrder> dispatchedOrders =
            allOrders.where((order) => order.status == 'Dispatched').toList();

        if (dispatchedOrders.isEmpty) {
          return Scaffold(
            // appBar: AppBar(
            //   leading: IconButton(
            //     onPressed: () => context.pop(),
            //     icon: const Icon(Icons.chevron_left),
            //   ),
            //   title: const Text("Dispatched Drug Orders"),
            //   backgroundColor: Theme.of(context).primaryColor,
            // ),
            body: BackgroundImageWidget(
                customAppBar: CustomAppBar(
                  title: "Dispatched Orders",
                  icon: Icons.vaccines_sharp,
                  color: Constants.dawaDropColor.withOpacity(0.5),
                ),
                svgImage: 'assets/images/lab-empty-state.svg',
                notFoundText: "No Dispatched drug orders"),
          );
        }

        return Scaffold(
          // appBar: AppBar(
          //   leading: IconButton(
          //     onPressed: () => context.pop(),
          //     icon: const Icon(Icons.chevron_left),
          //   ),
          //   title: const Text("Dispatched Drug Orders"),
          //   backgroundColor: Theme.of(context).primaryColor,
          // ),
          body: ListView.builder(
            itemCount: dispatchedOrders.length,
            itemBuilder: (context, index) {
              final order = dispatchedOrders[index];
              return ListTile(
                leading: const Icon(Icons.calendar_month_sharp),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Appointment Date: ${DateFormat("dd MMM yyy").format(DateTime.parse(order.appointment?.appointment_date ?? ''))}',
                      style: theme.textTheme.titleMedium
                          ?.merge(TextStyle(color: Colors.green)),
                    ),
                    Text(
                      'Dispatched Date : ${DateFormat("dd MMM yyy").format(DateTime.parse(order.dispatched_date ?? ''))}',
                      style: theme.textTheme.titleSmall
                          ?.merge(TextStyle(color: Colors.grey)),
                    ),
                  ],
                ),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  context.goNamed(RouteNames.CONFIRM_DELIVERY,
                      extra: {"OrderId": order.order_id});
                },
              );
            },
          ),
        );
      },
      error: (error, _) => BackgroundImageWidget(
        customAppBar: CustomAppBar(
          title: "Dispatched Drug Orders",
          icon: Icons.vaccines_sharp,
          color: Constants.dawaDropColor.withOpacity(0.5),
        ),
        svgImage: 'assets/images/lab-empty-state.svg',
        notFoundText: "No Dispatched order",
      ),
      loading: () => Center(
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
    );
  }
}
