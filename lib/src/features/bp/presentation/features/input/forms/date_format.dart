import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:nishauri/src/features/bp/presentation/components/date_time_picker.dart';

class DateForm extends StatelessWidget {
  final dateFormatString;
  final initialTime;
  final validate;
  final void Function(DateTime time) onTimeSelected;

  const DateForm({
    super.key,
    required this.dateFormatString,
    required this.initialTime,
    required this.validate,
    required this.onTimeSelected,
});

  @override
  Widget build(BuildContext context) => ListTile(
    title: Text(DateFormat(dateFormatString).format(initialTime)),
    trailing: const Icon(Icons.edit),
    onTap: () async {
      final messenger = ScaffoldMessenger.of(context);
      var selectedTime = await showDateTimePicker(
        context: context,
        firstDate: DateTime.fromMillisecondsSinceEpoch(1),
        lastDate: DateTime.now(),
        initialDate: initialTime,
      );
      if (selectedTime == null) {
        return;
      }
      final now = DateTime.now();
      if (validate && selectedTime.isAfter(now)){
        messenger.showSnackBar(SnackBar(content: Text(AppLocalizations.of(context)!.errTimeAfterNow),),);
        selectedTime = selectedTime.copyWith(
          hour: max(selectedTime.hour, now.hour),
          minute: max(selectedTime.minute, now.minute),
        );
      }
      if (selectedTime != initialTime) onTimeSelected(selectedTime);
    },
  );

}