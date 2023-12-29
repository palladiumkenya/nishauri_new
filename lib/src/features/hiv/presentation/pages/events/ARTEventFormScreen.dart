import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:nishauri/src/features/auth/data/providers/auth_provider.dart';
import 'package:nishauri/src/features/hiv/data/models/event/art_event.dart';
import 'package:nishauri/src/features/hiv/data/providers/art_events_provider.dart';
import 'package:nishauri/src/features/hiv/data/providers/art_group_provider.dart';
import 'package:nishauri/src/shared/input/Button.dart';
import 'package:nishauri/src/shared/layouts/ResponsiveWidgetFormLayout.dart';
import 'package:nishauri/src/shared/styles/input_styles.dart';
import 'package:nishauri/src/utils/constants.dart';
import 'package:nishauri/src/utils/helpers.dart';

class ARTEventFormScreen extends HookWidget {
  final ARTEvent? event;

  const ARTEventFormScreen({super.key, this.event});

  @override
  Widget build(BuildContext context) {
    final formKey = useMemoized(() => GlobalKey<FormBuilderState>());
    final loading = useState<bool>(false);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          event == null ? "Add Event" : "Update Event",
        ),
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.chevron_left),
        ),
      ),
      body: Consumer(
        builder: (context, ref, child) {
          final groupsAsync = ref.watch(art_group_provider);

          return groupsAsync.when(
              data: (groups) => ResponsiveWidgetFormLayout(
                    buildPageContent: (BuildContext context, Color? color) =>
                        SafeArea(
                            child: FormBuilder(
                      key: formKey,
                      child: Container(
                        padding: const EdgeInsets.all(Constants.SPACING * 2),
                        decoration: BoxDecoration(
                          color: color,
                          borderRadius:
                              BorderRadius.circular(Constants.ROUNDNESS),
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
                                  "assets/images/event.svg",
                                  semanticsLabel: "Event",
                                  fit: BoxFit.contain,
                                  height: 150,
                                ),
                              ),
                              const SizedBox(height: 20),
                              Text(
                                event == null ? "Add Event" : "Update Event",
                                style: const TextStyle(
                                    fontSize: 40, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: Constants.SPACING),
                              FormBuilderTextField(
                                name: "title",
                                validator: FormBuilderValidators.compose([
                                  FormBuilderValidators.required(),
                                ]),
                                initialValue: event?.title,
                                decoration: inputDecoration(
                                  prefixIcon: Icons.label_important_outlined,
                                  label: "Title",
                                  placeholder: "Enter event title",
                                ),
                              ),
                              const SizedBox(height: Constants.SPACING),
                              FormBuilderTextField(
                                initialValue: event?.venue,
                                validator: FormBuilderValidators.compose([
                                  FormBuilderValidators.required(),
                                ]),
                                name: "venue",
                                decoration: inputDecoration(
                                  prefixIcon: Icons.location_on_rounded,
                                  label: "Venue",
                                  placeholder: "Enter event venue",
                                ),
                              ),
                              const SizedBox(height: Constants.SPACING),
                              FormBuilderDateTimePicker(
                                initialValue: DateTime.tryParse(
                                    event?.distributionTime ?? ""),
                                validator: FormBuilderValidators.compose([
                                  FormBuilderValidators.required(),
                                ]),
                                name: "distributionTime",
                                decoration: inputDecoration(
                                  prefixIcon: Icons.watch_later,
                                  label: "Distribution time",
                                  placeholder: "Enter event date and time",
                                ),
                                valueTransformer: (date) =>
                                    date?.toIso8601String(),
                              ),
                              const SizedBox(height: Constants.SPACING),
                              FormBuilderDropdown(
                                name: "group",
                                initialValue: event?.group.id,
                                decoration: inputDecoration(
                                  prefixIcon: Icons.group,
                                  placeholder: "Select group",
                                  label: "Group",
                                ),
                                items: groups
                                    .map(
                                      (e) => DropdownMenuItem(
                                        child: Text(e.group.title),
                                        value: e.group.id,
                                      ),
                                    )
                                    .toList(),
                                validator: FormBuilderValidators.compose([
                                  FormBuilderValidators.required(),
                                ]),
                              ),
                              const SizedBox(height: Constants.SPACING),
                              FormBuilderField(
                                builder: (FormFieldState<Iterable<DateTime?>>
                                        state) =>
                                    Wrap(
                                  children: (state.value ?? [])
                                      .map(
                                        (e) => Chip(
                                          label: Text(
                                              DateFormat("dd/MM/yyy hh:mm:ss")
                                                  .format(e!)),
                                        ),
                                      )
                                      .toList(),
                                ),
                                name: "reminderNotificationDates",
                                initialValue: event?.reminderNotificationDates
                                    .map((e) => DateTime.tryParse(e)),
                                validator: FormBuilderValidators.compose([
                                  FormBuilderValidators.required(),
                                ]),
                              ),
                              const SizedBox(height: Constants.SPACING * 2),
                              Consumer(
                                builder: (context, ref, child) {
                                  return Button(
                                    title: "Submit",
                                    disabled: true,
                                    loading: loading.value,
                                    onPress: () {
                                      if (formKey.currentState!
                                          .saveAndValidate()) {
                                        // If the form is valid, display a snack-bar. In the real world,
                                        // you'd often call a server or save the information in a database.
                                        loading.value = true;

                                        ref
                                            .read(art_event_provider.notifier)
                                            .addEvent(
                                                formKey.currentState!.value)
                                            .then((value) {
                                          context.pop();
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                                content: Text(
                                                    'Event added successfully!')),
                                          );
                                        }).catchError((error) {
                                          handleResponseError(
                                              context,
                                              formKey.currentState!.fields,
                                              error, ref.read(authStateProvider.notifier).logout);
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
              error: (error, _) => Center(child: Text(error.toString())),
              loading: () => Center(
                    child: CircularProgressIndicator(),
                  ));
        },
      ),
    );
  }
}
