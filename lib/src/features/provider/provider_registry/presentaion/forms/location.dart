import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nishauri/src/features/user/data/providers/user_provider.dart';
import 'package:nishauri/src/shared/styles/input_styles.dart';
import 'package:nishauri/src/utils/constants.dart';

class LocationInformation extends StatefulWidget {
  const LocationInformation({super.key});

  @override
  _LocationInformationState createState() => _LocationInformationState();
}

class _LocationInformationState extends State<LocationInformation> {
  String? selectedCounty;
  String? selectedSubCounty;
  String? facility;

  @override
  Widget build(BuildContext context) {
    final counties = [
      const DropdownMenuItem(value: "NAI", child: Text("Nairobi")),
      const DropdownMenuItem(value: "MSA", child: Text("Mombasa")),
      const DropdownMenuItem(value: "NAK", child: Text("Nakuru")),
      const DropdownMenuItem(value: "KIS", child: Text("Kisumu")),
    ];

    final subCounties = [
      const DropdownMenuItem(value: "RUA", child: Text("Ruaraka")),
      const DropdownMenuItem(value: "ROY", child: Text("Roysambu")),
      const DropdownMenuItem(value: "KAS", child: Text("Kasarani")),
      const DropdownMenuItem(value: "LAN", child: Text("Langata")),
    ];

    final facilities = [
      const DropdownMenuItem(value: "23855", child: Text("Huruma Hospital - Mathare North Annex")),
      const DropdownMenuItem(value: "29146", child: Text("Seaton Park Medical Centre")),
      const DropdownMenuItem(value: "29283", child: Text("Provide Medical Centre")),
      const DropdownMenuItem(value: "13246", child: Text("St. Scholastica Uzima Hospital")),
    ];

    return Consumer(
      builder: (context, ref, child) {
        final asyncUser = ref.watch(userProvider);
        return asyncUser.when(
          data: (user) => Column(
            children: [
              const SizedBox(height: Constants.SPACING),
              FormBuilderDropdown(
                initialValue: selectedCounty,
                name: "county",
                items: counties,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedCounty = newValue;
                    selectedSubCounty = null; // Reset sub-county and facility
                    facility = null;
                  });
                },
                decoration: inputDecoration(
                  prefixIcon: Icons.map_sharp,
                  label: "County",
                ),
              ),
              const SizedBox(height: Constants.SPACING),
              if (selectedCounty != null) ...[
                FormBuilderDropdown(
                  initialValue: selectedSubCounty,
                  name: "sub_county",
                  items: subCounties,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedSubCounty = newValue;
                      facility = null; // Reset facility
                    });
                  },
                  decoration: inputDecoration(
                    prefixIcon: Icons.map_sharp,
                    label: "Sub County",
                  ),
                ),
              ],
              if (selectedSubCounty != null) ...[
                FormBuilderDropdown(
                  initialValue: facility,
                  name: "facility_mfl",
                  items: facilities,
                  onChanged: (String? newValue) {
                    setState(() {
                      facility = newValue;
                    });
                  },
                  decoration: inputDecoration(
                    prefixIcon: Icons.local_hospital_outlined,
                    label: "Facility",
                  ),
                ),
              ],
            ],
          ),
          error: (error, _) => Center(child: Text(error.toString())),
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
