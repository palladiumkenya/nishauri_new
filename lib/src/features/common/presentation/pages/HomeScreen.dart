import 'dart:io';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nishauri/src/app/navigation/drawer/UserDrawerHeader.dart';
import 'package:nishauri/src/app/navigation/drawer/customeDrawer.dart';
import 'package:nishauri/src/features/auth/data/providers/auth_provider.dart';
import 'package:nishauri/src/features/common/data/providers/announcements_provider.dart';
import 'package:nishauri/src/features/common/presentation/widgets/AnnouncementCard.dart';
import 'package:nishauri/src/features/common/presentation/widgets/Announcements.dart';
import 'package:nishauri/src/features/common/presentation/widgets/Appointments.dart';
import 'package:nishauri/src/features/common/presentation/widgets/Greetings.dart';
import 'package:nishauri/src/features/common/presentation/widgets/ShortcutsUi.dart';
import 'package:nishauri/src/features/hiv/data/providers/art_appointmen_provider.dart';
import 'package:nishauri/src/features/user/data/providers/user_provider.dart';
import 'package:nishauri/src/hooks/use_local_avatar.dart';
import 'package:nishauri/src/local_storage/LocalStorage.dart';
import 'package:nishauri/src/shared/display/AppAvatar.dart';
import 'package:nishauri/src/shared/display/AppCard.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:nishauri/src/shared/extensions/extensions.dart';
import 'package:nishauri/src/utils/constants.dart';
import 'package:nishauri/src/utils/helpers.dart';
import 'package:nishauri/src/utils/routes.dart';
import 'package:nishauri/src/features/auth/presentation/pages/LoginScreen.dart';

class HomeScreen extends StatefulHookConsumerWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  String _appVersion = "Loading...";
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  toggleDrawer() {
    if (_scaffoldKey.currentState!.isDrawerOpen) {
      _scaffoldKey.currentState!.closeDrawer();
    } else {
      _scaffoldKey.currentState!.openDrawer();
    }
  }

  @override
  void initState() {
    super.initState();
    _loadVersion();
    ref.refresh(userProvider.notifier);
  }

  Future<void> _loadVersion() async {
    final appVersion = await version();
    setState(() {
      _appVersion = appVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    final avatar = useLocalAvatar("images/avatar.jpg");
    final theme = Theme.of(context);
    final asyncUser = ref.watch(userProvider);
    final size = getOrientationAwareScreenSize(context);
    return Scaffold(
      key: _scaffoldKey,
      drawer: CustomDrawer(),
      body: Stack(
        children: [
          Positioned(
              top: 0,
              right: 0,
              child: SvgPicture.asset(
                "assets/images/rect-bg.svg",
                semanticsLabel: "Doctors",
                fit: BoxFit.contain,
                height: size.width * 0.55,
                width: size.width * 0.55,
              )),
          SafeArea(
            child: asyncUser.when(
                data: (user) => SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                onPressed: () {
                                  context.goNamed(RouteNames.PROFILE_SETTINGS);
                                },
                                icon: Container(
                                  padding: const EdgeInsets.all(
                                      Constants.SPACING * 0.15),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 1, color: theme.primaryColor),
                                      shape: BoxShape.circle),
                                  child: AppAvatar(
                                    alt: const Icon(Icons.person),
                                    image: avatar,
                                  ),
                                ),
                              ),
                              Wrap(
                                children: [
                                  // IconButton(
                                  //   onPressed: () {},
                                  //   icon: SvgPicture.asset(
                                  //     "assets/images/notification.svg",
                                  //     semanticsLabel: "Doctors",
                                  //     fit: BoxFit.contain,
                                  //   ),
                                  // ),
                                  IconButton(
                                    onPressed: toggleDrawer,
                                    icon: const Icon(Icons.more_vert),
                                  ),
                                ],
                              )
                            ],
                          ),
                          Greetings(
                            name: (user.name ?? "").titleCase,
                          ),
                          const Appointments(),
                          const SizedBox(height: Constants.SPACING),
                          const ShortcutsWidget(),
                          const SizedBox(height: Constants.SPACING),
                          Padding(
                            padding: const EdgeInsets.all(Constants.SPACING),
                            child: Text(
                              "Did you know?",
                              style: theme.textTheme.titleSmall,
                            ),
                          ),
                          const SizedBox(
                            height: Constants.SPACING,
                          ),
                          const Announcements(),
                          const SizedBox(
                            height: Constants.SPACING,
                          ),
                        ],
                      ),
                    ),
                error: (error, _) => Center(child: Text(error.toString())),
                loading: () =>
                    const Center(child: CircularProgressIndicator())),
          ),
        ],
      ),
    );
  }
}
