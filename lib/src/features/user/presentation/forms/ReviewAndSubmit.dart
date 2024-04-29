import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:nishauri/src/shared/display/AppAvatar.dart';
import 'package:nishauri/src/utils/helpers.dart';

class ReviewAndSubmit extends StatelessWidget {
  final Map<String, dynamic> formState;

  const ReviewAndSubmit({Key? key, required this.formState}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Convert chronic illnesses list to string
    // List<dynamic>? chronicIllnesses = formState['chronics']?.map((item) => item.value.toString()).toList();
    // String chronicIllnessesString = chronicIllnesses?.join(", ") ?? "None";

    return Container(
      child: Wrap(children: [
        const Divider(),

        ListTile(
          leading: AppAvatar(alt: Icon(Icons.person), image: formState["image"]),
          title: const Text("Username"),
          subtitle: Text(formState['username'] ?? "None"),
        ),
        const Divider(),

        ListTile(
          title: const Text("Full name"),
          subtitle: Text("${formState['f_name'] ?? "None"} ${formState['l_name'] ?? "None"}"),
        ),
        const Divider(),

        ListTile(
          title: const Text("Date of birth"),
          subtitle: Text(
            formState['dob'] != null
                ? DateFormat("yyyy-MM-dd").format(DateTime.parse("${formState['dob']}"))
                : "None",
          ),
        ),
        const Divider(),

        ListTile(
          title: const Text("Gender"),
          subtitle: Text(
              "${formState['gender'] ?? "None"}"
            // formState['gender'] != null
            //     ? (formState['gender'] == "M" ? "Male" : "Female")
            //     : "None",
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
            formState['phone_no'] ?? "None",
          ),
        ),
        const Divider(),

        ListTile(
          title: const Text("Landmark"),
          subtitle: Text(
            formState['landmark'] ?? "None",
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
          subtitle: Text(formState['blood_group'] ?? "None"),
        ),
        const Divider(),
        ListTile(
          title: const Text("Allergies"),
          subtitle: Text(formState['allergies']?.join(", ") ?? "None"),
        ),
        const Divider(),
        ListTile(
          title: const Text("Disabilities"),
          subtitle: Text(formState['disabilities']?.join(", ") ?? "None"),
        ),
        const Divider(),
        ListTile(
          title: const Text("Chronic Illnesses"),
          subtitle: Text(formState['chronics']?.join(", ") ?? "None"),
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
