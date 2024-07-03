import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nishauri/src/features/auth/data/respositories/auth_repository.dart';
import 'package:nishauri/src/features/auth/data/services/AuthApiService.dart';
import 'package:nishauri/src/features/user/data/providers/user_provider.dart';
import 'package:nishauri/src/shared/display/scafold_stack_body.dart';

import '../../../../shared/display/LinkedRichText.dart';
import '../../../../shared/display/Logo.dart';
import '../../../../shared/display/label_input_container.dart';
import '../../../../shared/input/Button.dart';
import '../../../../shared/styles/input_styles.dart';
import '../../../../utils/constants.dart';
import '../../../../utils/helpers.dart';
import '../../../auth/data/providers/auth_provider.dart';

class PasswordUnlockScreen extends HookConsumerWidget {
  const PasswordUnlockScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(() => GlobalKey<FormBuilderState>());
    final loading = useState(false);
    final hidePassword = useState(true);
    var theme = Theme.of(context);
    final userAsync = ref.watch(userProvider);
    final authNotifier =
    ref.read(authStateProvider.notifier);

    void togglePassword() {
        hidePassword.value = !hidePassword.value;
    }
    void handleSubmit() {
      if (formKey.currentState!.saveAndValidate()) {
        loading.value = true;


        // Form payload
        final payload = {
          ...formKey.currentState!.value,
        };
        authNotifier.unlock(payload).then((value) {
          context.pop();
        }).catchError((error) {
          handleResponseError(
            context,
            formKey.currentState!.fields,
            error,
            authNotifier.logout,
          );
        }).whenComplete(() => loading.value = false);


      }
    }


    return Scaffold(
      body: ScaffoldStackedBody(
        body: userAsync.when(
          data: (user) => FormBuilder(
            key: formKey,
            child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                const DecoratedBox(
                  decoration: BoxDecoration(),
                  child: Logo(
                    size: 100,
                  ),
                ),
                const SizedBox(height: Constants.SMALL_SPACING),
                const Text(
                  "Privacy lock 🔏",
                  style: TextStyle(fontSize: 40),
                ),
                const SizedBox(height: Constants.SPACING),
                RichText(
                  text: TextSpan(
                    text: "Dear ",
                    style: TextStyle(color: theme.colorScheme.onSurface),
                    children: [
                      TextSpan(
                        text: user.username,
                        style: TextStyle(
                          color: theme.colorScheme.primary,
                        ),
                      ),
                      const TextSpan(
                        text: ", Your application is locked due to privacy reasons, Please provide your password to unlock",
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: Constants.SPACING * 3),
                LabelInputContainer(
                  label: "Password",
                  child: FormBuilderTextField(
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                    ]),
                    name: "password",
                    obscureText: hidePassword.value,
                    decoration: outLineInputDecoration(
                      // prefixIcon: Icons.lock,
                      // label: "Password",
                        placeholder: "Enter your password",
                        onSurfixIconPressed: togglePassword,
                        surfixIcon: hidePassword.value
                            ? const Icon(Icons.visibility)
                            : const Icon(Icons.visibility_off)),
                  ),
                ),
                const SizedBox(height: Constants.SPACING * 6),
                Button(
                  title: "Unlock",
                  backgroundColor: theme.colorScheme.primary,
                  textColor: Colors.white,
                  onPress: handleSubmit,
                  loading: loading.value,
                ),
                const SizedBox(height: Constants.SPACING * 2),
                LinkedRichText(
                    linked: "",
                    unlinked: "Logout",
                    onPress: authNotifier.logout),
                const SizedBox(height: Constants.SPACING),

                const SizedBox(height: Constants.SPACING),
              ],
            ),
          ),
            ),
          ),
          error: (error, stack) => Center(child: Text("$error")),
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
