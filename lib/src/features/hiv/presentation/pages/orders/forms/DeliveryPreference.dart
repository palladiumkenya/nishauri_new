import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:nishauri/src/features/orders/data/providers/courier_provider.dart';

import '../../../../../../shared/styles/input_styles.dart';
import '../../../../../../utils/constants.dart';
import '../../../../../user/data/providers/user_provider.dart';

class DeliveryPreference extends HookConsumerWidget {
  const DeliveryPreference({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orderDeliveryMethod = useState<String?>(null);
    final asyncUser = ref.watch(userProvider);
    final asyncCourierServices = ref.watch(courierProvider);
    final theme = Theme.of(context);
    return asyncUser.when(
      data: (user) => Column(
        children: [
          FormBuilderRadioGroup<String>(
              name: 'deliveryMethod',
              onChanged: (method_) {
                orderDeliveryMethod.value = method_;
              },
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(errorText: "Required"),
              ]),
              decoration: const InputDecoration(
                border: InputBorder.none,
                labelText: "Preferred delivery method",
              ),
              options: [
                FormBuilderFieldOption(
                  value: "in_person",
                  child: ListTile(
                    trailing: const Icon(Icons.person),
                    title: const Text("In person"),
                    subtitle: Text(
                      "Have someone trusted pick up drugs for you",
                      style: TextStyle(
                          color: theme.colorScheme.onTertiaryContainer),
                    ),
                  ),
                ),
                FormBuilderFieldOption(
                  value: "in_parcel",
                  child: ListTile(
                    trailing: const Icon(Icons.card_giftcard),
                    title: const Text("In parcel"),
                    subtitle: Text(
                        style: TextStyle(
                            color: theme.colorScheme.onTertiaryContainer),
                        "Have drugs delivered through trusted courier services"),
                  ),
                ),
              ]),
          const SizedBox(height: Constants.SPACING),
          if (orderDeliveryMethod.value == "in_parcel")
            asyncCourierServices.when(
              data: (courierService) => FormBuilderDropdown(
                name: "courierService",
                decoration: inputDecoration(
                  prefixIcon: Icons.delivery_dining,
                  label: "Courier",
                ),
                validator: FormBuilderValidators.compose([
                  if (orderDeliveryMethod.value == "in_parcel")
                    FormBuilderValidators.required(errorText: "Required"),
                ]),
                items: courierService
                    .map(
                      (e) => DropdownMenuItem(
                        value: e.id,
                        child: Text(
                          e.name,
                        ),
                      ),
                    )
                    .toList(),
              ),
              error: (error, _) => Center(child: Text(error.toString())),
              loading: () => const Center(
                child: CircularProgressIndicator(),
              ),
            ),
          if (orderDeliveryMethod.value == "in_person")
            FormBuilderTextField(
              name: "deliveryPersonFullName",
              decoration: inputDecoration(
                placeholder: "e.g John Doe",
                prefixIcon: Icons.account_circle_outlined,
                label: "Full name",
              ),
              validator: FormBuilderValidators.compose([
                if (orderDeliveryMethod.value == "in_person")
                  FormBuilderValidators.required(errorText: "Required"),
              ]),
            ),
          if (orderDeliveryMethod.value == "in_person")
            const SizedBox(height: Constants.SPACING),
          if (orderDeliveryMethod.value == "in_person")
            FormBuilderTextField(
              name: "deliveryPersonNationalId",
              decoration: inputDecoration(
                placeholder: "e.g 12345678",
                prefixIcon: Icons.perm_identity,
                label: "National Id",
              ),
              validator: FormBuilderValidators.compose([
                if (orderDeliveryMethod.value == "in_person")
                  FormBuilderValidators.required(errorText: "Required"),
              ]),
            ),
          if (orderDeliveryMethod.value == "in_person")
            const SizedBox(height: Constants.SPACING),
          if (orderDeliveryMethod.value == "in_person")
            FormBuilderTextField(
              name: "deliveryPersonPhoneNumber",
              keyboardType: TextInputType.phone,
              decoration: inputDecoration(
                placeholder: "e.g 0712345678",
                prefixIcon: Icons.phone,
                label: "Phone number",
              ),
              validator: FormBuilderValidators.compose([
                if (orderDeliveryMethod.value == "in_person")
                  FormBuilderValidators.required(errorText: "Required"),
              ]),
            ),
          if (orderDeliveryMethod.value == "in_person")
            const SizedBox(height: Constants.SPACING),
          if (orderDeliveryMethod.value == "in_person")
            FormBuilderDateTimePicker(
              firstDate: DateTime.now(),
              lastDate: DateTime.now().add(const Duration(days: 7)),
              name: "pickupTime",
              format: DateFormat('dd MMM yyy HH:mm a'),
              inputType: InputType.both,
              decoration: inputDecoration(
                placeholder: "dd/MM/yyyy ",
                prefixIcon: Icons.schedule,
                label: "Pickup time",
              ),
              validator: FormBuilderValidators.compose([
                if (orderDeliveryMethod.value == "in_person")
                  FormBuilderValidators.required(errorText: "Required"),
              ]),
              valueTransformer: (date) => date?.toIso8601String(),
            ),
          const SizedBox(height: Constants.SPACING),
        ],
      ),
      error: (error, _) => Center(child: Text(error.toString())),
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
    );
    ;
  }
}
