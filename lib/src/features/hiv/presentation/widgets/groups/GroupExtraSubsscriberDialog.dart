import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:nishauri/src/features/hiv/data/models/group/art_group_extra_subscriber.dart';
import 'package:nishauri/src/shared/input/Button.dart';
import 'package:nishauri/src/shared/styles/input_styles.dart';
import 'package:nishauri/src/utils/constants.dart';

class GroupExtraSubscriberDialog extends HookWidget {
  const GroupExtraSubscriberDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final cccNumber = useTextEditingController();
    final name = useTextEditingController();
    final phoneNumber = useTextEditingController();
    return AlertDialog(
      title: const Text("Extra Subscribers"),
      content: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                controller: name,
                decoration:
                    inputDecoration(prefixIcon: Icons.person, label: "Name"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Required';
                  }
                  return null;
                },
              ),
              const SizedBox(height: Constants.SPACING),
              TextFormField(
                keyboardType: TextInputType.number,
                controller: cccNumber,
                decoration: inputDecoration(
                    prefixIcon: Icons.shield_outlined, label: "CCC Number"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Required';
                  }
                  return null;
                },
              ),
              const SizedBox(height: Constants.SPACING),
              TextFormField(
                keyboardType: TextInputType.phone,
                controller: phoneNumber,
                decoration: inputDecoration(
                    prefixIcon: Icons.phone, label: "Phone number"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              )
            ],
          ),
        ),
      ),
      actions: [
        Button(
            title: "Add",
            onPress: () {
              if (formKey.currentState!.validate()) {
                formKey.currentState!.save();
                context.pop(
                  ARTGroupExtraSubscriber(
                    cccNumber: cccNumber.text,
                    name: name.text,
                    phoneNumber: phoneNumber.text,
                  ),
                );
              }
            }),
        Button(
            title: "Cancel",
            textColor: Theme.of(context).colorScheme.error,
            onPress: () {
              context.pop();
            }),
      ],
    );
  }
}
