import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:nishauri/src/features/user/data/providers/user_provider.dart';
import 'package:nishauri/src/hooks/use_local_avatar.dart';
import 'package:nishauri/src/shared/display/AppAvatar.dart';
import 'package:nishauri/src/shared/display/AppCard.dart';
import 'package:nishauri/src/shared/display/ProfileCard.dart';
import 'package:nishauri/src/shared/extensions/extensions.dart';
import 'package:nishauri/src/utils/constants.dart';
import 'package:nishauri/src/utils/helpers.dart';
import 'package:nishauri/src/utils/routes.dart';

class ProfileScreen extends HookWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final avatar = useLocalAvatar("images/avatar.jpg");
    log("*****************${avatar.toString()}*********************");
    final cardColor = Theme.of(context).colorScheme.onPrimary;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.chevron_left),
        ),
        title: const Text('Profile'),
        actions: [
          IconButton(
            onPressed: () => context.goNamed(RouteNames.PROFILE_EDIT_FORM),
            icon: const Icon(Icons.mode_edit_outlined),
          )
        ],
      ),
      body: Consumer(
        builder: (context, ref, child) {
          final userAsync = ref.watch(userProvider);
          return userAsync.when(
            data: (user) => ProfileCard(
              height: MediaQuery.of(context).size.height,
              header: user.username == 'null null' || user.username == ""
                  ? GestureDetector(
                      onTap: () {
                        context.goNamed(RouteNames.PROFILE_EDIT_FORM);
                      },
                      child: const Text(
                        'Update your profile',
                        style: TextStyle(
                          color: Colors.red,
                          // decoration: TextDecoration.underline,
                        ),
                      ),
                    )
                  : Text((user.name ?? "").titleCase),
              image: avatar,
              // user.image,
              icon: Icons.person,
              buildItem: (context, item) => item,
              items: [
                const Divider(),
                // ListTile(
                //   leading: const Icon(Icons.perm_identity),
                //   title: const Text("Username"),
                //   subtitle: Text(user.username ?? ''),
                // ),
                ListTile(
                  leading: const Icon(Icons.perm_identity),
                  title: const Text("Username"),
                  subtitle: user.username == 'null null' || user.username == ""
                      ? Text("")
                      : Text(user.username ?? ''),
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.email),
                  title: const Text("Email"),
                  subtitle: Text(user.email ?? ''),
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.phone),
                  title: const Text("Phone number"),
                  subtitle: Text(user.phoneNumber ?? ''),
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.account_circle_outlined),
                  title: const Text("Gender"),
                  subtitle: Text(user.gender ?? ''),
                  // subtitle: Text(user.gender == "M" ? "Male" : "Female"),
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.calendar_month),
                  title: const Text("Date of birth"),
                  subtitle: Text(
                    DateTime.tryParse(user.dateOfBirth ?? "") != null
                        ? DateFormat("dd-MMM-yyyy")
                            .format(DateTime.parse(user.dateOfBirth!))
                        : "None",
                  ),
                ),
                // const Divider(),
                // ListTile(
                //   leading: const Icon(Icons.calendar_month),
                //   title: const Text("Date of birth"),
                //   subtitle: Text(
                //     DateTime.tryParse(user.dateOfBirth ?? "") != null
                //         ? DateFormat("dd MM yyyy")
                //             .format(DateTime.parse(user.dateOfBirth!))
                //         : "None",
                //   ),
                // ),
                const Divider(),
              ],
            ),
            error: (error, _) => Center(child: Text(error.toString())),
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
      ),
    );
  }
}
