import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nishauri/src/shared/display/AppAvatar.dart';

class ReviewAndSubmitLocation extends StatelessWidget {
  final Map<String, dynamic> formState;

  const ReviewAndSubmitLocation({Key? key, required this.formState}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      child: Wrap(children: [
        const Divider(),

        ListTile(
          leading: AppAvatar(alt: Icon(Icons.person), image: formState["image"]),
          title: const Text("Full Name"),
          subtitle: Text("${formState['salutation'] ?? "None"} ${formState['family_name'] ?? "None"} ${formState['given_name'] ?? "None"}"),
        ),
        const Divider(),

        ListTile(
          title: const Text("Facility"),
          subtitle: Text("${formState['facility_mfl'] ?? "None"}"),
        ),
        const Divider(),
      ]),
    );
  }
}
