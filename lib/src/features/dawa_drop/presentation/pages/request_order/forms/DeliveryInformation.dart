import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nishauri/src/features/common/data/models/maps/place_search_result.dart';

import '../../../../../../shared/styles/input_styles.dart';
import '../../../../../../utils/constants.dart';
import '../../../../../user/data/providers/user_provider.dart';

class DeliveryInformation extends HookConsumerWidget {
  const DeliveryInformation({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final place = useState<PlaceSearchResult?>(null);
    final asyncUser = ref.watch(userProvider);
    final theme = Theme.of(context);
    return asyncUser.when(
      data: (user) => Column(
        children: [
          const SizedBox(height: Constants.SPACING),
          FormBuilderTextField(
            name: "client_phone_no",
            initialValue: user.phoneNumber,
            keyboardType: TextInputType.phone,
            decoration: inputDecoration(
              placeholder: "e.g 0712345678",
              prefixIcon: Icons.phone,
              label: "Phone number",
            ),
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.minLength(10,
                  errorText: 'Phone number must be 10 digits long'),
              FormBuilderValidators.maxLength(10,
                  errorText: 'Phone number must be 10 digits long'),
              (value) {
                if (value != null &&
                    value.isNotEmpty &&
                    !value.startsWith('0')) {
                  return 'Phone number must start with zero';
                }
                return null;
              },
            ]),
          ),
          const SizedBox(height: Constants.SPACING),
          // TODO Replace with https://pub.dev/packages/map_location_picker
          FormBuilderTextField(
            name: "delivery_address",
            // initialValue: user.phoneNumber,
            keyboardType: TextInputType.text,
            decoration: inputDecoration(
              placeholder: "e.g Kimbo",
              prefixIcon: Icons.map_outlined,
              label: "Location Name",
            ),
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(errorText: "Required"),
            ]),
          ),
          const SizedBox(height: Constants.SPACING),
          FormBuilderTextField(
            name: "delivery_estate",
            // initialValue: user.phoneNumber,
            keyboardType: TextInputType.text,
            decoration: inputDecoration(
              placeholder: "e.g Riverside",
              prefixIcon: Icons.map_outlined,
              label: "Estate",
            ),
            // validator: FormBuilderValidators.compose([
            //   FormBuilderValidators.required(errorText: "Required"),
            // ]),
          ),
          const SizedBox(height: Constants.SPACING),
          FormBuilderTextField(
            name: "delivery_apartment",
            // initialValue: user.phoneNumber,
            keyboardType: TextInputType.text,
            decoration: inputDecoration(
              placeholder: "e.g Pahali Rentals",
              prefixIcon: Icons.map_outlined,
              label: "Apartment",
            ),
            // validator: FormBuilderValidators.compose([
            //   FormBuilderValidators.required(errorText: "Required"),
            // ]),
          ),

          // FormBuilderField<Map<String, dynamic>>(
          //   validator: FormBuilderValidators.compose([
          //     FormBuilderValidators.required(errorText: "Required"),
          //   ]),
          //   builder: (state) {
          //     final controller = TextEditingController(text: state.value?["address"]);
          //     return TextField(
          //       controller: controller,
          //       readOnly: true,
          //       decoration: inputDecoration(
          //         placeholder: "Search location ...",
          //         prefixIcon: Icons.map,
          //         label: "Delivery Location",
          //       ).copyWith(errorText: state.errorText),
          //       onTap: () {
          //         showModalBottomSheet(
          //             isScrollControlled: true,
          //             context: context,
          //             isDismissible: true,
          //             showDragHandle: true,
          //             useSafeArea: true,
          //             builder: (context) {
          //               return LocationPicker(
          //                 onChange: (place) {
          //                   // controller.text = place.display;
          //                   state.didChange({
          //                     "latitude": place.coordinates.lat,
          //                     "longitude": place.coordinates.lng,
          //                     "address": place.display
          //                   });
          //                 },
          //               );
          //             });
          //       },
          //     );
          //   },
          //   name: "deliveryAddress",
          // ),
          const SizedBox(height: Constants.SPACING),
        ],
      ),
      error: (error, _) => Center(child: Text(error.toString())),
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
