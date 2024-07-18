import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nishauri/src/features/bp/data/data_store/repositories/medicine_intake_repository.dart';
import 'package:nishauri/src/features/bp/data/data_store/repositories/note_repository.dart';
import 'package:nishauri/src/features/bp/data/data_store/types/full_entry.dart';
import 'package:nishauri/src/features/bp/data/data_store/types/medicine_intake.dart';
import 'package:nishauri/src/features/bp/data/data_store/types/note.dart';
import 'package:nishauri/src/features/bp/data/data_util/blood_pressure_builder.dart';
import 'package:nishauri/src/features/bp/data/data_util/entry_context.dart';
import 'package:nishauri/src/features/bp/data/data_util/repository_builder.dart';
import 'package:nishauri/src/features/bp/data/models/storage/intervall_store.dart';
import 'package:nishauri/src/features/bp/data/models/storage/settings_store.dart';
import 'package:nishauri/src/features/bp/presentation/features/measurements/legacy_measurements.dart';
import 'package:nishauri/src/features/bp/presentation/features/measurements/measurements.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:nishauri/src/features/bp/presentation/features/statistics/measurement_graph.dart';
import 'package:nishauri/src/features/bp/presentation/pages/settings_screen.dart';
import 'package:nishauri/src/features/bp/presentation/pages/statistics_screen.dart';
import 'package:provider/provider.dart';
bool _appStart = true;

class BPScreen extends StatelessWidget {

  const BPScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    // direct use of settings possible as no listening is required
    // if (_appStart) {
    //   if (Provider.of<Settings>(context, listen: false).startWithAddMeasurementPage) {
    //     SchedulerBinding.instance.addPostFrameCallback((_) => context.createEntry());
    //   }
    // }
    // _appStart = false;

    return Scaffold(
      body: OrientationBuilder(
        builder: (context, orientation) {
          if (orientation == Orientation.landscape) {
            return MeasurementGraph(
              height: MediaQuery.of(context).size.height,
            );
          }
          return Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Consumer<IntervallStoreManager>(builder: (context, intervalls, child) =>
                  Column(children: [
                    /*MeasurementListRow(
                  settings: Settings(), data: (BloodPressureRecord(time: DateTime(2023),
                  sys:Pressure.mmHg(1), dia: Pressure.mmHg(2), pul: 3), Note(time: DateTime(2023), note: 'testTxt',), [])),*/
                    const MeasurementGraph(),
                    Expanded(
                      child: BloodPressureBuilder(
                        rangeType: IntervallStoreManagerLocation.mainPage,
                        onData: (context, records) => RepositoryBuilder<MedicineIntake, MedicineIntakeRepository>(
                          rangeType: IntervallStoreManagerLocation.mainPage,
                          onData: (BuildContext context, List<MedicineIntake> intakes) => RepositoryBuilder<Note, NoteRepository>(
                            rangeType: IntervallStoreManagerLocation.mainPage,
                            onData: (BuildContext context, List<Note> notes) {
                              final entries = FullEntryList.merged(records, notes, intakes);
                              entries.sort((a, b) => b.time.compareTo(a.time)); // newest first
                              if (context.select<Settings, bool>((s) => s.compactList)) {
                                return LegacyMeasurementsList(
                                  data: entries,
                                );
                              }
                              return MeasurementList(
                                entries: entries,
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ],),),
            ),
          );
        },
      ),
      floatingActionButton: OrientationBuilder(
        builder: (context, orientation) {
          if (orientation == Orientation.landscape && MediaQuery.of(context).size.height < 500) {
            SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
            return const SizedBox.shrink();
          }
          SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
          return Consumer<Settings>(builder: (context, settings, child) => Column(
            verticalDirection: VerticalDirection.up,
            children: [
              SizedBox.square(
                dimension: 75,
                child: FittedBox(
                  child: FloatingActionButton(
                    heroTag: 'floatingActionAdd',
                    // tooltip: localizations.addMeasurement,
                    autofocus: true,
                    onPressed: context.createEntry,
                    child: const Icon(Icons.add,),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              FloatingActionButton(
                heroTag: 'floatingActionStatistics',
                // tooltip: localizations.statistics,
                backgroundColor: const Color(0xFF6F6F6F),
                onPressed: () {
                  _buildTransition(context, const StatisticsScreen(), settings.animationSpeed);
                },
                child: const Icon(Icons.insights, color: Colors.black),
              ),
              const SizedBox(
                height: 10,
              ),
              FloatingActionButton(
                heroTag: 'floatingActionSettings',
                // tooltip: localizations.settings,
                backgroundColor: const Color(0xFF6F6F6F),
                child: const Icon(Icons.settings, color: Colors.black),
                onPressed: () {
                  _buildTransition(context, const SettingsPage(), settings.animationSpeed);
                },
              ),
            ],
          ),);
        },),
    );
  }
}

// TODO: consider removing duration override that only occurs in one on home.
void _buildTransition(BuildContext context, Widget page, int duration) {
  Navigator.push(context,
    _TimedMaterialPageRouter(
      transitionDuration: Duration(milliseconds: duration),
      builder: (context) => page,
    ),
  );
}

class _TimedMaterialPageRouter extends MaterialPageRoute {
  _TimedMaterialPageRouter({
    required super.builder,
    required this.transitionDuration,});

  @override
  final Duration transitionDuration;
}