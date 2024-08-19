import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nishauri/src/features/appointments/presentation/widgets/CurrentAppoints.dart';
import 'package:nishauri/src/features/appointments/presentation/widgets/PreviousAppointments.dart';
import 'package:nishauri/src/shared/display/CustomTabBar.dart';
import 'package:nishauri/src/shared/display/CustomeAppBar.dart';
import 'package:nishauri/src/utils/constants.dart';

class AppointmentsScreen extends HookConsumerWidget {
  const AppointmentsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final currIndex = useState(0);

    final screens = [
      CurrentAppointments(),
      PreviousAppointments(),
    ];

    return Scaffold(
      body: Column(
        children: [
          const CustomAppBar(
            title: "Appointments 📅",
            // icon: Icons.calendar_month_outlined,
            subTitle: "Unlock you health insights with appointments",
            color: Constants.appointmentsColor,
          ),
          CustomTabBar(
            activeIndex: currIndex.value,
            activeColor: Constants.appointmentsColor,
            onTap: (item, index) {
              currIndex.value = index;
            },
            items: const [
              CustomTabBarItem(
                title: "Upcoming",
                icon: Icons.calendar_month,
              ),
              CustomTabBarItem(
                title: "Previous",
                icon: Icons.calendar_month,
              ),
            ],
          ),
          Expanded(child: screens[currIndex.value]),
        ],
      ),
    );
  }
}
