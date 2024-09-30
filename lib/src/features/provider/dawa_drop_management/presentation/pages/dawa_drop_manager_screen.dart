import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nishauri/src/features/dawa_drop/data/models/order_request/drug_order.dart';
import 'package:nishauri/src/features/dawa_drop/data/providers/drug_order_provider.dart';
import 'package:nishauri/src/features/provider/dawa_drop_management/presentation/widgets/drug_approved_list.dart';
import 'package:nishauri/src/features/provider/dawa_drop_management/presentation/widgets/drug_dispatched_list.dart';
import 'package:nishauri/src/features/provider/dawa_drop_management/presentation/widgets/drug_fulfilled_list.dart';
import 'package:nishauri/src/features/provider/dawa_drop_management/presentation/widgets/drug_request_list.dart';
import 'package:nishauri/src/shared/display/CustomAppBar.dart';
import 'package:nishauri/src/shared/display/CustomTabBar.dart';
import 'package:nishauri/src/shared/display/background_image_widget.dart';
import 'package:nishauri/src/shared/notifications/count_budge.dart';
import 'package:nishauri/src/utils/constants.dart';

class DawaDropManagemerScreen extends HookConsumerWidget {
  const DawaDropManagemerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final dawaDropRequestsAsync = ref.watch(drugOrderProvider);
    final currentIndex = useState(0);

    return dawaDropRequestsAsync.when(data: (data) {
      if (data.isEmpty) {
        return const BackgroundImageWidget(
          customAppBar: CustomAppBar(
            title: "Dawa Drop Requests",
            color: Constants.providerBgColor,
          ),
          svgImage: "assets/images/appointments-empty.svg",
          notFoundText: "No Requests found",
        );
      }

      List<DrugOrder> pending = data.where((order) => order.status == 'Pending').toList();
      List<DrugOrder> approved = data.where((order) => order.status == 'Approved').toList();
      List<DrugOrder> dispatched = data.where((order) => order.status == 'Dispatched').toList();
      List<DrugOrder> fulfilled = data.where((order) => order.status == 'Fullfilled').toList();

      final screen = [
        pending.isEmpty ?
          const Center(
            child: BackgroundImageWidget(
                svgImage: 'assets/images/lab-empty-state.svg',
                notFoundText: "No current drug requests to approve"),
          ) :

          DrugRequestList(orders: pending),

        approved.isEmpty ? const Center(
          child: BackgroundImageWidget(
              svgImage: 'assets/images/lab-empty-state.svg',
              notFoundText: "No current drug request to dispatch"),
        ):
        DrugApprovedRequestList(orders: approved),
        dispatched.isEmpty ? const Center(
          child: BackgroundImageWidget(
              svgImage: 'assets/images/lab-empty-state.svg',
              notFoundText: "No current drug dispatched"),
        ):
        DrugDispatchedList(orders: dispatched),
        fulfilled.isEmpty ? const Center(
          child: BackgroundImageWidget(
              svgImage: 'assets/images/lab-empty-state.svg',
              notFoundText: "No Fulfilled orders."),
        ):
        DrugFulfilledList(orders: fulfilled),
      ];
      return Scaffold(
        body: Column(
          mainAxisAlignment:  MainAxisAlignment.start,
          children: [
            const CustomAppBar(
              title: "Dawa Drop Requests 📋",
              color: Constants.providerBgColor,
            ),
            CustomTabBar(
              onTap: (item, index) {
                currentIndex.value = index;
              },
              activeColor: Constants.providerBgColor.withOpacity(0.5),
              activeIndex: currentIndex.value,
              items: [
                CustomTabBarItem(title: "Drug Requests", trailing: CountBadge(count: pending.length,)),
                CustomTabBarItem(title: "Approved Requests", trailing: CountBadge(count: approved.length,)),
                const CustomTabBarItem(title: "Dispatched Requests"),
                const CustomTabBarItem(title: "Fulfilled Requests"),
              ],
            ),
            Expanded(child: screen[currentIndex.value]),
          ],
        ),
      );
    },
    error: (error, _) => Center(child: Text(error.toString()),),
    loading: () => CircularProgressIndicator()
    );

  }
}