import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nishauri/src/features/C4C/FreeEbooksSCreen.dart';
import 'package:nishauri/src/features/C4C/Literature.dart';
import 'package:nishauri/src/features/appointments/presentation/widgets/CurrentAppoints.dart';

import '../../shared/display/CustomAppBar.dart';
import '../../shared/display/CustomTabBar.dart';
import '../../utils/constants.dart';
import '../appointments/presentation/widgets/PreviousAppointments.dart';
import 'AppScreen.dart';

class ResourceScreen extends HookConsumerWidget {
  const ResourceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final currIndex = useState(0);

    final screens = [
      FreeEbooks(),
      Literature(),
      AppScreen(),

    ];

    return Scaffold(
      body: Column(
        children: [
          const CustomAppBar(
            title: "Resource center ",
            // icon: Icons.calendar_month_outlined,
            subTitle: "Useful medical resources",
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
                title: "Free ebooks",
                icon: Icons.calendar_month,
              ),
              CustomTabBarItem(
                title: "Literature",
                icon: Icons.calendar_month,
              ),
              CustomTabBarItem(
                title: "Apps",
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
