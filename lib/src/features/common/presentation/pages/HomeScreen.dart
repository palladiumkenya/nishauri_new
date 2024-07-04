import 'dart:io';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nishauri/src/app/navigation/drawer/UserDrawerHeader.dart';
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
      drawer: Drawer(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(0.0)),
        ),
        child: ListView(
          children: [
            if (asyncUser.hasValue)
              GestureDetector(
                child: UserDrawerHeader(
                  email: asyncUser.value!.email == "null null" || asyncUser.value?.name == null
                  ? "" : asyncUser.value!.email ?? '',
                  name: asyncUser.value?.name == "null null" || asyncUser.value?.name == null
                      ? "" : (asyncUser.value?.name ?? "").titleCase,
                  phoneNumber: asyncUser.value!.phoneNumber == "null null" || asyncUser.value?.phoneNumber == null
                      ? "" : asyncUser.value!.phoneNumber ?? '',
                  image: avatar,// asyncUser.value!.image,
                ),
                onTap: () => context.goNamed(RouteNames.PROFILE_SETTINGS),
              ),

            // ListTile(
            //   leading: const Icon(Icons.dashboard_customize_rounded),
            //   title: const Text("Dashboard"),
            //   onTap: () {
            //     context.goNamed(RouteNames.DASHBOARD);
            //     // Close drawer
            //     Navigator.pop(context);
            //   },
            // ),

            // ListTile(
            //   leading: const Icon(Icons.notifications),
            //   title: const Text("Notification"),
            //   onTap: () {
            //     // Close drawer
            //     Navigator.pop(context);
            //   },
            // ),
            // ListTile(
            //   leading: const Icon(Icons.feedback),
            //   title: const Text("Send Feedback"),
            //   onTap: () {
            //     // Close drawer
            //     Navigator.pop(context);
            //   },
            // ),
            ListTile(
              leading: const Icon(Icons.question_answer),
              title: const Text("FAQ's"),
              onTap: () {
                context.goNamed(RouteNames.FAQs);
                // Close drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text("Settings"),
              onTap: () {
                context.goNamed(RouteNames.SETTINGS);
                // Close drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text("Logout"),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text("Confirmation"),
                      content: SvgPicture.asset(
                        "assets/images/warning.svg",
                        height: 200,
                        width: 200,
                      ),
                      actions: [
                        ElevatedButton(
                            onPressed: () {
                              ref.watch(authStateProvider.notifier).logout().then((value) {
                                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                    content: Text('Logout successfully')));
                                context.goNamed(RouteNames.LOGIN_SCREEN);
                              });
                              // context.goNamed(RouteNames.LOGIN_SCREEN);
                            },
                            child: const Text("Log out"))
                      ],
                    );
                  },
                );
              },
            ),
            const SizedBox(height: 10.0,),
            Container(
              padding: const EdgeInsets.only(left: 15.0), // Specify the desired width
              child: Text(
                'App Version: $_appVersion',
                style: theme.textTheme.titleSmall!.copyWith(color: Constants.labResultsColor),
                //textAlign: TextAlign.center, // Optional: Center the text
              ),
            ),


            // ...drawerItems.map(
            //   (e) => ListTile(
            //     leading: Icon(e.icon),
            //     title: Text(e.title),
            //     onTap: () {
            //       if(e.onPress !=null){
            //         e.onPress!(context);
            //       }
            //     },
            //   ),
            // ),
          ],
        ),
      ),
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