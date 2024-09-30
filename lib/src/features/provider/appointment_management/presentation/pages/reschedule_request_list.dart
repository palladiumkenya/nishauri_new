import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nishauri/src/features/provider/appointment_management/data/providers/appointment_management_provider.dart';
import 'package:nishauri/src/features/provider/appointment_management/presentation/widget/current_request.dart';
import 'package:nishauri/src/shared/display/CustomAppBar.dart';
import 'package:nishauri/src/shared/display/CustomTabBar.dart';
import 'package:nishauri/src/shared/display/background_image_widget.dart';
import 'package:nishauri/src/shared/notifications/count_budge.dart';
import 'package:nishauri/src/utils/constants.dart';

class RescheduleRequestListScreen extends HookConsumerWidget {
  const RescheduleRequestListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final appointmentRescheduleAsync = ref.watch(appointmentRescheduleProvider);
    final currIndex = useState(0);

    return appointmentRescheduleAsync.when(data: (data) {
      if (data.isEmpty) {
        return const BackgroundImageWidget(
          customAppBar: CustomAppBar(
            title: "Reschedule Requests 📆",
            color: Constants.providerBgColor,
          ),
          svgImage: "assets/images/appointments-empty.svg",
          notFoundText: "No Content",
        );
      }

      final screen = [
        RescheduleRequestList(appointments: data),
        const Center(
          child: BackgroundImageWidget(
            svgImage: 'assets/images/lab-empty-state.svg',
            notFoundText: "No Past reschedule request",
          ),
        ),
      ];

      return Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const CustomAppBar(
              title: "Reschedule Requests 📆",
              color: Constants.providerBgColor,
            ),
            CustomTabBar(
              onTap: (item, index) {
                currIndex.value = index;
              },
              activeColor: Constants.providerBgColor.withOpacity(0.5),
              activeIndex: currIndex.value,
              items: [
                CustomTabBarItem(
                  title: "Appointments Reschedule Request",
                  trailing: CountBadge(count: data.length),
                ),
                const CustomTabBarItem(title: "History"),
              ],
            ),
            Expanded(
              child: screen[currIndex.value],
            ),
          ],
        ),
      );
    },
        error: (error, _) => Center(child: Text(error.toString())),
        loading: () => const CircularProgressIndicator());
  }
}
