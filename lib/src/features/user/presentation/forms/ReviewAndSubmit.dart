import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:nishauri/src/shared/display/AppAvatar.dart';
import 'package:nishauri/src/utils/helpers.dart';

class ReviewAndSubmit extends StatelessWidget {
  final Map<String, dynamic> formState;

  const ReviewAndSubmit({super.key, required this.formState});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // return Placeholder();
    return Container(
      child: Wrap(children: [
        const Divider(),

        ListTile(
          leading:
              AppAvatar(alt: Icon(Icons.person), image: formState["image"]),
          title: const Text("Username"),
          subtitle: Text(formState['username'] ?? "None"),
        ),
        const Divider(),

        ListTile(
          title: const Text("Full name"),
          subtitle: Text(
              "${formState['firstName'] ?? "None"} ${formState['lastName'] ?? "None"}"),
        ),
        const Divider(),

        ListTile(
          title: const Text("Date of birth"),
          subtitle: Text(
            formState['dateOfBirth'] != null
                ? DateFormat("yyy-MM-dd")
                    .format(DateTime.parse("${formState['dateOfBirth']}"))
                : "None",
          ),
        ),
        const Divider(),

        ListTile(
          title: const Text("Gender"),
          subtitle: Text(
            formState['gender'] != null
                ? (formState['gender'] == "M" ? "Male" : "Female")
                : "None",
          ),
        ),
        const Divider(),

        ListTile(
          title: const Text("Email"),
          subtitle: Text(formState['email'] ?? "None"),
        ),
        const Divider(),

        ListTile(
          title: const Text("Phone number"),
          subtitle: Text(
            formState['phoneNumber'] ?? "None",
          ),
        ),
        const Divider(),

        ListTile(
          title: const Text("Landmark"),
          subtitle: Text(
            formState['constituency'] ?? "None",
          ),
        ),
        // Row(
        //   children: [
        //     Expanded(
        //       child: ListTile(
        //         title: const Text("County"),
        //         subtitle: Text(
        //           formState['county'] ?? "None",
        //         ),
        //       ),
        //     ),
        //     Expanded(
        //       child: ListTile(
        //         title: const Text("Constituency"),
        //         subtitle: Text(
        //           formState['constituency'] ?? "None",
        //         ),
        //       ),
        //     ),
        //   ],
        // ),
        // TODO Remove null checks
        const Divider(),
        ListTile(
          title: const Text("Blood Group"),
          subtitle: Text(formState['bloodGroup'] ?? "None"),
        ),
        const Divider(),
        ListTile(
          title: const Text("Allergies"),
          subtitle: Text(formState['allergies']?? "None"),
        ),
        const Divider(),
        ListTile(
          title: const Text("Disabilities"),
          subtitle: Text(formState['disabilities']?? "None"),
        ),
        const Divider(),
        ListTile(
          title: const Text("Chronic Illnesses"),
          subtitle: Text(formState['chronics']?? "None"),
        ),
        const Divider(),
        Row(
          children: [
            Expanded(
              child: ListTile(
                title: const Text("Weight"),
                subtitle: Text("${formState['weight'] ?? "None"} kgs"),
              ),
            ),
            Expanded(
              child: ListTile(
                title: const Text("Height"),
                subtitle: Text("${formState['height'] ?? "None"} cm"),
              ),
            ),
          ],
        ),
        const Divider(),
        ListTile(
          title: const Text("Marital status"),
          subtitle: Text(formState['maritalStatus'] ?? "None"),
        ),
        const Divider(),
        ListTile(
          title: const Text("Primary language"),
          subtitle: Text(formState['primaryLanguage'] ?? "None"),
        ),
        const Divider(),
        ListTile(
          title: const Text("Education level"),
          subtitle: Text(formState['educationLevel'] ?? "None"),
        ),
        const Divider(),
        ListTile(
          title: const Text("Occupation"),
          subtitle: Text(formState['occupation'] ?? "None"),
        ),
        const Divider(),
      ]),
    );
  }
}
