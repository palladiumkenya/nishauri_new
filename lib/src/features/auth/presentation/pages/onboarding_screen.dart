import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:nishauri/src/features/bmi/onboardng_step.dart';
import 'package:nishauri/src/features/user_preference/data/providers/settings_provider.dart';
import 'package:nishauri/src/utils/data.dart';

import '../../../../shared/input/Button.dart';
import '../../../../utils/constants.dart';
import '../../../../utils/routes.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>
    with TickerProviderStateMixin {
  late PageController _pageViewController;
  late TabController _tabController;
  int _currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageViewController = PageController();
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _pageViewController.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenSize = MediaQuery.of(context).size;
    final screens = onboardingSteps
        .map(
          (e) => OnboardingStep(
            title: e["title"]!,
            icon: e["icon"]!,
            description: e["description"]!,
            index: int.parse(e["id"]!),
          ),
        )
        .toList();

    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomRight,
        fit: StackFit.expand,
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: Constants.SPACING * 12,
            child: PageView(
              controller: _pageViewController,
              onPageChanged: _handlePageViewChanged,
              children: screens,
            ),
          ),
          // Positioned(
          //   bottom: Constants.SPACING * 2,
          //   left: Constants.SPACING,
          //   child: DotsIndicator(
          //     dotsCount: screens.length,
          //     position: _currentPageIndex,
          //     decorator: DotsDecorator(
          //         size: const Size.square(9.0),
          //         activeSize: const Size(18.0, 9.0),
          //         activeShape: RoundedRectangleBorder(
          //           borderRadius: BorderRadius.circular(5.0),
          //         ),
          //         activeColor: theme.colorScheme.primary),
          //   ),
          // ),
          if (_currentPageIndex < 4)
            Positioned(
              bottom: Constants.SPACING * 2,
              left: Constants.SPACING,
              right: Constants.SPACING,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      _updateCurrentPageIndex(4);
                    },
                    icon: Text(
                      "Skip",
                      style: theme.textTheme.titleLarge?.copyWith(
                          color: theme.colorScheme.primary,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  IconButton.filledTonal(
                    icon: const FaIcon(
                      FontAwesomeIcons.arrowRight,
                    ),
                    onPressed: _currentPageIndex >= 4
                        ? null
                        : () {
                            _updateCurrentPageIndex(_currentPageIndex + 1);
                          },
                  ),
                ],
              ),
            ),
          if (_currentPageIndex == 4)
            Positioned(
              width: MediaQuery.of(context).size.width,
              bottom: Constants.SPACING * 2,
              child: Padding(
                padding: const EdgeInsets.all(Constants.SPACING),
                child: Consumer(
                  builder: (context, ref, child) {
                    return Button(
                      backgroundColor: theme.colorScheme.primary,
                      textColor: Colors.white,
                      title: "Get started",
                      surfixIcon: const FaIcon(FontAwesomeIcons.arrowRight),
                      onPress: () {
                        final settings =
                            ref.read(settingsNotifierProvider.notifier);
                        settings.updateSettings(firstNuruAccess: true);
                        context.goNamed(RouteNames.LOGIN_SCREEN);
                      },
                    );
                  },
                ),
              ),
            )
        ],
      ),
    );
  }

  void _handlePageViewChanged(int currentPageIndex) {
    _tabController.index = currentPageIndex;
    setState(() {
      _currentPageIndex = currentPageIndex;
    });
  }

  void _updateCurrentPageIndex(int index) {
    _tabController.index = index;
    _pageViewController.animateToPage(
      index,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }
}
