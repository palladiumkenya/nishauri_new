import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:nishauri/src/features/bp/data/data_store/types/blood_pressure_record.dart';
import 'package:nishauri/src/features/bp/data/models/storage/settings_store.dart';
import 'package:nishauri/src/features/bp/presentation/features/statistics/value_distribution.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BloodPressureDistribution extends StatefulWidget {

  final Iterable<BloodPressureRecord> records;
  const BloodPressureDistribution({
    super.key,
    required this.records,
  });

  @override
  State<BloodPressureDistribution> createState() =>
      _BloodPressureDistributionState();
}

class _BloodPressureDistributionState extends State<BloodPressureDistribution>
    with TickerProviderStateMixin {

  late final TabController _controller;
  
  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(50),
          ),
          child: TabBar.secondary(
            labelPadding: const EdgeInsets.symmetric(vertical: 16),
            indicator: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(50),
            ),
            dividerHeight: 0,
            controller: _controller,
            tabs: [
              Text(localizations.sysLong),
              Text(localizations.diaLong),
              Text(localizations.pulLong),
            ],
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: _controller,
            children: [
              // Preferred pressure unit can be ignored as values are relative.
              ValueDistribution(
                key: const Key('sys-dist'),
                values: widget.records.map((e) => e.sys?.mmHg).whereNotNull(),
                color: context.select<Settings, Color>((s) => s.sysColor),
              ),
              ValueDistribution(
                key: const Key('dia-dist'),
                values: widget.records.map((e) => e.dia?.mmHg).whereNotNull(),
                color: context.select<Settings, Color>((s) => s.diaColor),
              ),
              ValueDistribution(
                key: const Key('pul-dist'),
                values: widget.records.map((e) => e.pul).whereNotNull(),
                color: context.select<Settings, Color>((s) => s.pulColor),
              ),
            ],
          ),
        ),
      ],
    );
  }

}
