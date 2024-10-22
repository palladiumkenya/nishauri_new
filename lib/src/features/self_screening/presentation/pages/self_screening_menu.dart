import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nishauri/src/features/common/presentation/pages/chat_feeback_form.dart';
import 'package:nishauri/src/features/self_screening/presentation/widgets/health_card.dart';
import 'package:nishauri/src/features/self_screening/presentation/widgets/health_list.dart';
import 'package:nishauri/src/features/self_screening/presentation/widgets/image_card.dart';
import 'package:nishauri/src/shared/display/CustomAppBar.dart';
import 'package:nishauri/src/utils/constants.dart';
import 'package:nishauri/src/utils/routes.dart';

class SelfScreening extends HookConsumerWidget {
  const SelfScreening({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    int _currIndex = 0;
    int _messagesCount = 0;

    return Scaffold(
      body: Column(
          children: [
            const CustomAppBar(
              title: "Self Screening🌡",
              subTitle: "Easily track your health. Stay informed and take control of well-being.",
              color: Constants.selfScreeningBgColor,
            ),
            Expanded(
                child: SingleChildScrollView(
                  child: Stack(
                    alignment: AlignmentDirectional.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Cards showing health data
                            Wrap(
                              spacing: 5,
                              runSpacing: 16,
                              children: [
                                HealthCard(
                                  svgAsset: "assets/images/boldDuotoneLikeHearts.svg",
                                  title: "Blood Pressure",
                                  value1: "120",
                                  text1: "mmHG",
                                  vName1: "Systolic",
                                  value2: "80",
                                  text2: "mmHG",
                                  vName2: "Diastolic",
                                  value3: "73",
                                  text3: "Pulse/Min",
                                  vName3: "Pulse Rate",
                                  onPressed: (){
                                    context.goNamed(RouteNames.BLOOD_PRESSURE);
                                  },
                                ),
                                HealthCard(
                                  svgAsset: "assets/images/boldDuotoneMedicinePulse.svg",
                                  title: "Blood Sugar",
                                  value1: "120",
                                  text1: "mmHG",
                                  value3: "73/Min",
                                  vName3: "Pulse Rate",
                                  onPressed: (){
                                    context.goNamed(RouteNames.BLOOD_SUGAR);
                                  },
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            ItemList(items: ["Blood Sugar", "Blood Pressure", "BMI", "Period Calendar"]),
                            const SizedBox(height: 20),
                            // Title for the next section
                            Text(
                              "About Self Screening",
                              style: theme.textTheme.headline6,
                            ),
                            const SizedBox(height: 10),
                            Wrap(
                              alignment: WrapAlignment.center,
                              spacing: 1,
                              runSpacing: 16,
                              children: [
                                ImageCard(imagePath: 'assets/images/hospital_building.svg'),
                                ImageCard(imagePath: 'assets/images/hospital_building.svg'),
                              ],
                            ),
                            const SizedBox(height: 20),
                            // Title for the understanding health section
                            Text(
                              "Understanding Your Health",
                              style: theme.textTheme.headline6,
                            ),
                            const SizedBox(height: 10),
                            Text(
                              "Understanding your health metrics is crucial for maintaining a healthy lifestyle. "
                                  "Stay informed about your numbers and consult your healthcare provider when needed.",
                              style: theme.textTheme.bodyText2,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
            ),
          ],
        ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        selectedItemColor: theme.colorScheme.primary,
        unselectedItemColor: theme.disabledColor,
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset("assets/images/Home.svg"),
            label: "Home",
            activeIcon: SvgPicture.asset("assets/images/Home-Active.svg"),
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset("assets/images/Modules.svg"),
            label: "Apps",
            activeIcon: SvgPicture.asset("assets/images/Modules-active.svg"),
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset("assets/images/Chatbot.svg"),
            label: "Ask Nuru",
            activeIcon: SvgPicture.asset("assets/images/Chatbot-Active.svg"),
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset("assets/images/Settings.svg"),
            label: "Settings",
            activeIcon: SvgPicture.asset("assets/images/Settings-Active.svg"),
          ),
        ],
        currentIndex: _currIndex,
        onTap: (index) async {
          if (_currIndex == 2 && index != 2 && _messagesCount > 2) {
            await showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => AlertDialog(
                content: Stack(
                  children: [
                    const ChatFeedbackForm(),
                    Positioned(
                      right: 0,
                      top: 0,
                      child: IconButton(
                        onPressed: () => Navigator.of(context).pop(),
                        icon: const FaIcon(FontAwesomeIcons.xmark),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          // Update current index and messages count
          _currIndex = index;
          _messagesCount = 0;
        },
      ),
    );
  }
}


// List<MenuItem> _menuItems(BuildContext context, WidgetRef ref) => [
//   MenuItem(
//     icon: const Icon(Icons.calculate),
//     shortcutIcon: const Icon(Icons.calculate),
//     color: Constants.bmiCalculatorShortcutBgColor,
//     shortcutBackgroundColor: Constants.bmiCalculatorShortcutBgColor,
//     title: "BMI Calculator",
//     onPressed: () => context.goNamed(RouteNames.BMI_CALCULATOR),
//   ),
//   MenuItem(
//     icon: const Icon(Icons.trending_up),
//     shortcutIcon: const Icon(Icons.trending_up),
//     color: Constants.bpShortCutBgColor,
//     shortcutBackgroundColor: Constants.bpShortCutBgColor,
//     title: "B P Monitor",
//     onPressed: () => context.goNamed(RouteNames.BLOOD_PRESSURE),
//   ),
//   MenuItem(
//     shortcutBackgroundColor: Constants.dawaDropShortcutBgColor,
//     icon: const Icon(Icons.sanitizer),
//     shortcutIcon: const Icon(Icons.sanitizer),
//     title: MenuItemNames.BLOOD_SUGAR,
//     onPressed: () => context.goNamed(MenuItemNames.BLOOD_SUGAR),
//     color: Constants.bloodSugarColor.withOpacity(0.5),
//   ),
//   MenuItem(
//     shortcutBackgroundColor: Constants.periodPlannerShortcutBgColor,
//     icon: const Icon(Icons.calendar_month_outlined),
//     shortcutIcon: const Icon(Icons.calendar_month_outlined),
//     title: MenuItemNames.PERIOD_PLANNER,
//     onPressed: () {
//       ref.read(cyclesProvider.notifier).fetchCycles()
//       .then((cycles) {
//         // if (cycles.isEmpty) {
//         //   context.goNamed(RouteNames.NEW_USER_SCREEN);
//         // }
//         // else {
//         //   context.goNamed(RouteNames.PERIOD_PLANNER_SCREEN);
//         // }
//         context.goNamed(RouteNames.PERIOD_PLANNER_SCREEN);
//       });
//     },
//     color: Constants.periodPlannerShortcutBgColor.withOpacity(0.5),
//   ),
// ];

// class SelfScreening extends HookConsumerWidget {
//   const SelfScreening({super.key});
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final theme = Theme.of(context);
//     final _items = _menuItems(context, ref);
//     final insightAsync = ref.watch(insightProvider);
//
//     return Scaffold(
//       body: Column(
//         children: [
//           const CustomAppBar(
//             title: "Self Screening🌡",
//             subTitle: "Easily track your health. Stay informed and take control of well-being.",
//             color: Constants.selfScreeningBgColor,
//           ),
//           Expanded(
//             child: MenuItemsBuilder(
//               crossAxisCount: 3,
//               itemBuilder: (item) => MenuOption(
//                 title: item.title ?? "",
//                 icon: item.shortcutIcon,
//                 bgColor: item.color ?? Constants.bmiCalculatorShortcutBgColor,
//                 onPress: item.onPressed,
//               ),
//               items: _items,
//             ),
//           ),
//         ],
//       ),
//       floatingActionButton: Column(
//         mainAxisAlignment: MainAxisAlignment.end,
//         children: [
//           FloatingActionButton(
//             tooltip: "Module insight",
//             hoverColor: Constants.bmiCalculatorShortcutBgColor,
//             onPressed: () {
//               context.goNamed(RouteNames.INSIGHT);
//             },
//             backgroundColor: Constants.bmiCalculatorShortcutBgColor,
//             child: const Icon(Icons.insights),
//           ),
//         ],
//       ),
//     );
//   }
// }
