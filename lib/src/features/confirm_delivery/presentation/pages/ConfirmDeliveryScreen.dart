import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:nishauri/src/features/auth/data/providers/auth_provider.dart';
import 'package:nishauri/src/shared/display/Logo.dart';
import 'package:nishauri/src/shared/display/verify.dart';
import 'package:nishauri/src/shared/input/Button.dart';
import 'package:nishauri/src/shared/layouts/ResponsiveWidgetFormLayout.dart';
import 'package:nishauri/src/shared/styles/input_styles.dart';
import 'package:nishauri/src/utils/constants.dart';
import 'package:nishauri/src/utils/helpers.dart';

class ConfirmDeliveryScreen extends StatelessWidget {
  const ConfirmDeliveryScreen({super.key});


  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormBuilderState>();
    bool _loading = false;
    // void handleSubmit() {
    //   if (_formKey.currentState!.saveAndValidate()) {
    //     setState(() {
    //       _loading = true;
    //     });
    //     final userStateNotifier = ref.read(userProvider.notifier);
    //     final authStateNotifier = ref.read(authStateProvider.notifier);
    //     userStateNotifier.verify(_formKey.currentState!.value).then((value) {
    //       authStateNotifier.markProfileAsAccountVerified();
    //       authStateNotifier.markProfileAsUpdated();
    //       ScaffoldMessenger.of(context).showSnackBar(
    //         SnackBar(content: Text(value)),
    //       );
    //     }).catchError((err) {
    //       handleResponseError(context, _formKey.currentState!.fields, err, authStateNotifier.logout);
    //     }).whenComplete(() {
    //       setState(() {
    //         _loading = false;
    //       });
    //     });
    //   }
    // }
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.chevron_left),
        ),
        title: const Text("Confirm drug delivery"),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: ResponsiveWidgetFormLayout(
        buildPageContent: (BuildContext context, Color? color) => SafeArea(
            child: FormBuilder(
              key: _formKey,
              child: Container(
                padding: const EdgeInsets.all(Constants.SPACING * 2),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(Constants.ROUNDNESS),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: Constants.SPACING),
                      const DecoratedBox(
                        decoration: BoxDecoration(),
                        child: Verify(),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "Confirm Deliver",
                        style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: Constants.SPACING),
                      FormBuilderTextField(
                        name: "code",
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(),
                          FormBuilderValidators.min(10),
                        ]),
                        decoration: inputDecoration(
                          prefixIcon: Icons.abc_outlined,
                          label: "Confirmation Code",
                          placeholder: "754WEd",
                        ),
                      ),
                      const SizedBox(height: Constants.SPACING),
                      FormBuilderTextField(
                        name: "feedback",
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(),
                          FormBuilderValidators.min(10),
                        ]),
                        decoration: inputDecoration(
                          prefixIcon: Icons.abc_outlined,
                          label: "Feedback",
                          placeholder: "Write a feedback on the delivery",
                        ),
                      ),

                      const SizedBox(height: Constants.SPACING),
                      Consumer(
                        builder: (context, ref, child) {
                          return                               Button(
                            title: "Confirm Delivery",
                            // onPress: handleSubmit,
                            loading: _loading,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            )),
      ),
    );
  }
}
