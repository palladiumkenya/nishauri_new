import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:nishauri/src/features/user/data/providers/user_provider.dart';
import 'package:nishauri/src/shared/display/AppCard.dart';
import 'package:nishauri/src/shared/extensions/extensions.dart';
import 'package:nishauri/src/utils/constants.dart';
import 'package:nishauri/src/utils/helpers.dart';
import 'package:nishauri/src/utils/routes.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
            data: (user) => Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: Constants.SPACING),
              child: ListView(
                children: [
                  CircleAvatar(
                    radius: 70,
                    backgroundImage: user.image != null
                        ? _buildUserImage(user.image!)
                        : null,
                    child: ClipOval(
                      child: user.image == null
                          ? Text("${user.firstName} ${user.lastName}".abbreviation)
                          : null,
                    ),
                  ),
                  AppCard(
                    child: ListTile(
                      leading: const Icon(Icons.perm_identity),
                      title: const Text("Username"),
                      subtitle: Text(user.username),
                    ),
                  ),
                  AppCard(
                    child: ListTile(
                      leading: const Icon(Icons.account_circle_outlined),
                      title: const Text("Name"),
                      subtitle: Text("${user.firstName} ${user.lastName}".titleCase),
                    ),
                  ),
                  AppCard(
                    child: ListTile(
                      leading: const Icon(Icons.email),
                      title: const Text("Email"),
                      subtitle: Text(user.email),
                    ),
                  ),
                  AppCard(
                    child: ListTile(
                      leading: const Icon(Icons.phone),
                      title: const Text("Phone number"),
                      subtitle: Text(user.phoneNumber),
                    ),
                  ),
                  AppCard(
                    child: ListTile(
                      leading: const Icon(Icons.account_circle_outlined),
                      title: const Text("Gender"),
                      subtitle: Text(user.gender == "M" ? "Male" : "Female"),
                    ),
                  ),
                  AppCard(
                    child: ListTile(
                      leading: const Icon(Icons.calendar_month),
                      title: const Text("Date of birth"),
                      subtitle: Text(
                        DateTime.tryParse(user.dateOfBirth ?? "") != null
                            ? DateFormat("dd MM yyyy")
                                .format(DateTime.parse(user.dateOfBirth!))
                            : "None",
                      ),
                    ),
                  ),
                ],
              ),
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

_buildUserImage(String imagePath) {
  return isNetworkUri(imagePath)
      ? NetworkImage(
          imagePath,
        )
      : FileImage(
          File.fromUri(Uri.parse(imagePath)),
        );
}
