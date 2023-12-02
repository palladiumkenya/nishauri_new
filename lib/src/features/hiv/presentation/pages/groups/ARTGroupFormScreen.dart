import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:nishauri/src/features/hiv/data/models/group/art_group.dart';
import 'package:nishauri/src/features/hiv/data/providers/art_group_provider.dart';
import 'package:nishauri/src/shared/display/Logo.dart';
import 'package:nishauri/src/shared/input/Button.dart';
import 'package:nishauri/src/shared/layouts/ResponsiveWidgetFormLayout.dart';
import 'package:nishauri/src/shared/styles/input_styles.dart';
import 'package:nishauri/src/utils/constants.dart';
import 'package:nishauri/src/utils/helpers.dart';

class ARTGroupFormScreen extends HookWidget {
  final ARTGroup? group;

  const ARTGroupFormScreen({super.key, this.group});

  @override
  Widget build(BuildContext context) {
    final formKey = useMemoized(() => GlobalKey<FormBuilderState>());
    final loading = useState<bool>(false);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          group == null ? "Add Group" : "Update Group",
        ),
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.chevron_left),
        ),
      ),
      body: ResponsiveWidgetFormLayout(
        buildPageContent: (BuildContext context, Color? color) => SafeArea(
            child: FormBuilder(
          key: formKey,
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
                  DecoratedBox(
                    decoration: const BoxDecoration(),
                    child: SvgPicture.asset(
                      "assets/images/group.svg",
                      semanticsLabel: "Security",
                      fit: BoxFit.contain,
                      height: 150,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    group == null ? "Add Group" : "Update Group",
                    style: const TextStyle(
                        fontSize: 40, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: Constants.SPACING),
                  FormBuilderTextField(
                    name: "title",
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                    ]),
                    initialValue: group?.title,
                    decoration: inputDecoration(
                      prefixIcon: Icons.label_important_outlined,
                      label: "Title",
                      placeholder: "Enter group title",
                    ),
                  ),
                  const SizedBox(height: Constants.SPACING),
                  FormBuilderTextField(
                    initialValue: group?.description,
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                    ]),
                    name: "description",
                    decoration: inputDecoration(
                      prefixIcon: Icons.info_outline,
                      label: "Description",
                      placeholder: "Enter group description",
                    ),
                    minLines: 3, // Set this
                    maxLines: 6, // and this
                    keyboardType: TextInputType.multiline,
                  ),
                  const SizedBox(height: Constants.SPACING * 2),
                  Consumer(
                    builder: (context, ref, child) {
                      return Button(
                        title: "Submit",
                        loading: loading.value,
                        onPress: () {
                          if (formKey.currentState!.saveAndValidate()) {
                            // If the form is valid, display a snack-bar. In the real world,
                            // you'd often call a server or save the information in a database.
                            loading.value = true;
                            ref
                                .read(art_group_provider.notifier)
                                .addARTGroup(formKey.currentState!.value)
                                .then((value) {
                              context.pop();
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Group added successfully!')),
                              );
                            }).catchError((error) {
                              handleResponseError(
                                  context, formKey.currentState!.fields, error);
                            }).whenComplete(
                              () => loading.value = false,
                            );
                          }
                        },
                      );
                    },
                  ),
                  const SizedBox(
                    height: Constants.SPACING,
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
