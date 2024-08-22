import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nishauri/src/app/navigation/drawer/UserDrawerHeader.dart';
import 'package:nishauri/src/features/auth/data/providers/auth_provider.dart';
import 'package:nishauri/src/features/auth/presentation/pages/LoginScreen.dart';
import 'package:nishauri/src/features/user/data/providers/user_provider.dart';
import 'package:nishauri/src/hooks/use_local_avatar.dart';
import 'package:nishauri/src/shared/extensions/extensions.dart';
import 'package:nishauri/src/utils/routes.dart';

class CustomDrawer extends StatefulHookConsumerWidget {
  @override
  ConsumerState<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends ConsumerState<CustomDrawer> {
  String _appVersion = "Loading...";

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
    return Drawer(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(0.0)),
      ),
      child: ListView(
        children: [
          if (asyncUser.hasValue)
            GestureDetector(
              child: UserDrawerHeader(
                email: asyncUser.value!.email == "null null" ||
                    asyncUser.value?.name == null
                    ? ""
                    : asyncUser.value!.email ?? '',
                name: asyncUser.value?.name == "null null" ||
                    asyncUser.value?.name == null
                    ? ""
                    : (asyncUser.value?.name ?? "").titleCase,
                phoneNumber: asyncUser.value!.phoneNumber == "null null" ||
                    asyncUser.value?.phoneNumber == null
                    ? ""
                    : asyncUser.value!.phoneNumber ?? '',
                image: avatar, // asyncUser.value!.image,
              ),
              onTap: () => context.goNamed(RouteNames.PROFILE_SETTINGS),
            ),

          ListTile(
            leading: const Icon(Icons.dashboard_customize_rounded),
            title: const Text("Dashboard"),
            onTap: () {
              context.goNamed(RouteNames.DASHBOARD);
              // Close drawer
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.chat_outlined),
            title: const Text("Chat with HCW"),
            onTap: () {
              context.goNamed(RouteNames.CHAT_HCW);
              // Close drawer
              Navigator.pop(context);
            },
          ),

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
                        onPressed: () async {
                          try {
                            final value = await ref.watch(authStateProvider.notifier).logout();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(value)),
                            );
                            context.goNamed(RouteNames.LOGIN_SCREEN);
                          } catch (error) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Logout failed: $error')),
                            );
                          }
                        },
                        child: const Text("Log out"),
                      )

                    ],
                  );
                },
              );
            },
          ),
          const SizedBox(
            height: 10.0,
          ),
          Container(
            padding: const EdgeInsets.only(
                left: 15.0), // Specify the desired width
            child: Text(
              'App Version: $_appVersion',
              // style: theme.textTheme.titleSmall!.copyWith(color: Constants.labResultsColor),
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
    );
  }
}
