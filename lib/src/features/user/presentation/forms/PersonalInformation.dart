import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:nishauri/src/features/user/data/providers/user_provider.dart';
import 'package:nishauri/src/shared/styles/input_styles.dart';
import 'package:nishauri/src/utils/constants.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class PersonalInformation extends StatefulWidget {
  const PersonalInformation({Key? key}) : super(key: key);

  @override
  _PersonalInformationState createState() => _PersonalInformationState();
}

class _PersonalInformationState extends State<PersonalInformation> {
  DateTime? _selectedDate;

  int calculateAge(DateTime? dob) {
    if (dob == null) return 0;
    var now = DateTime.now();
    var age = now.year - dob.year;
    if (now.month < dob.month || (now.month == dob.month && now.day < dob.day)) {
      age--;
    }
    return age;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final asyncUser = ref.watch(userProvider);
        return asyncUser.when(
          data: (user) => Column(
            children: [
              const SizedBox(height: Constants.SPACING),
              FormBuilderTextField(
                initialValue: user.firstName,
                name: "f_name",
                decoration: inputDecoration(
                  placeholder: "Enter your firstname",
                  prefixIcon: Icons.account_circle_outlined,
                  label: "First name",
                ),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                ]),
              ),
              const SizedBox(height: Constants.SPACING),
              FormBuilderTextField(
                initialValue: user.lastName,
                name: "l_name",
                decoration: inputDecoration(
                  placeholder: "Enter your last name",
                  prefixIcon: Icons.account_circle_outlined,
                  label: "Last name",
                ),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                ]),
              ),
              const SizedBox(height: Constants.SPACING),
              FormBuilderDateTimePicker(
                initialValue: DateTime.tryParse(user.dateOfBirth ?? ""),
                firstDate: DateTime(1950),
                lastDate: DateTime.now(),
                name: "dob",
                format: DateFormat('yyyy-MM-dd'),
                inputType: InputType.date,
                decoration: widgetSurfixIconDecoration(
                  placeholder: "Enter your date of birth",
                  prefixIcon: Icons.calendar_month_rounded,
                  surfixIcon: Text(
                    _selectedDate != null ? '${calculateAge(_selectedDate!).toString()} years' : 'some',
                    style: TextStyle(fontSize: 16),
                  ),
                  label: "Date of birth",
                ),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                      (date) {
                    if (date == null) return "Date of birth is required";
                    if (calculateAge(date) < 12) return "You must be at least 12 years old";
                    return null;
                  },
                ]),
                onChanged: (date) {
                  setState(() {
                    _selectedDate = date;
                  });
                },
                valueTransformer: (date) => date?.toIso8601String(),
              ),
              const SizedBox(height: Constants.SPACING),
              FormBuilderDropdown(
                initialValue: user.gender,
                name: "gender",
                decoration: inputDecoration(
                  prefixIcon: Icons.accessibility,
                  label: "Gender",
                ),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                ]),
                items: const [
                  DropdownMenuItem(
                    value: "Male",
                    child: Text("Male"),
                  ),
                  DropdownMenuItem(
                    value: "Female",
                    child: Text("Female"),
                  ),
                ],
              ),
              const SizedBox(height: Constants.SPACING),
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
