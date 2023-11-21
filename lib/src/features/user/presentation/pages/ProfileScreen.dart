import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nishauri/src/shared/display/Logo.dart';
import 'package:nishauri/src/utils/constants.dart';
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Constants.SPACING),
        child: ListView(
          children: [
            const CircleAvatar(
              radius: 80,
              child: Padding(
                padding: EdgeInsets.all(Constants.SPACING),
                child: Logo(),
              ),
            ),
            Card(
              color: cardColor,
              child: const ListTile(
                leading: Icon(Icons.perm_identity),
                title: Text("Username"),
                subtitle: Text("omosh"),
              ),
            ),
            Card(
              color: cardColor,
              child: const ListTile(
                leading: Icon(Icons.account_circle_outlined),
                title: Text("Name"),
                subtitle: Text("Laurent Ouma"),
              ),
            ),
            Card(
              color: cardColor,
              child: const ListTile(
                leading: Icon(Icons.email),
                title: Text("Email"),
                subtitle: Text("lawiomosh3@gmail.com"),
              ),
            ),
            Card(
              color: cardColor,
              child: const ListTile(
                leading: Icon(Icons.phone),
                title: Text("Phone number"),
                subtitle: Text("0793889658"),
              ),
            ),
            Card(
              color: cardColor,
              child: const ListTile(
                leading: Icon(Icons.account_circle_outlined),
                title: Text("Gender"),
                subtitle: Text("Male"),
              ),
            ),
            Card(
              color: cardColor,
              child: const ListTile(
                leading: Icon(Icons.calendar_month),
                title: Text("Date of birth"),
                subtitle: Text("21st Oct 2000"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
