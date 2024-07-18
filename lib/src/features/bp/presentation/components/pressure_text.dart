import 'package:flutter/material.dart';
import 'package:nishauri/src/features/bp/data/data_store/types/units/pressure.dart';
import 'package:nishauri/src/features/bp/data/models/blood_pressure/pressure_unit.dart';
import 'package:nishauri/src/features/bp/data/models/storage/settings_store.dart';
import 'package:nishauri/src/features/bp/presentation/components/nullable_text.dart';
import 'package:provider/provider.dart';

/// A display [pressure] in the correct [Settings.preferredPressureUnit].
class PressureText extends StatelessWidget {
  /// Display a [pressure] in the correct [Settings.preferredPressureUnit].
  const PressureText(this.pressure, {super.key});

  /// Pressure to display.
  ///
  /// When this is null a placeholder '-' is displayed.
  final Pressure? pressure;

  @override
  Widget build(BuildContext context) => NullableText(
    switch (context.watch<Settings>().preferredPressureUnit) {
      PressureUnit.mmHg => pressure?.mmHg,
      PressureUnit.kPa => pressure?.kPa.toStringAsFixed(1),
    }?.toString(),
  );
}
