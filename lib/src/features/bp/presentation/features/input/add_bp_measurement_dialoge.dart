import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nishauri/src/features/bp/data/data_store/repositories/medicine_repository.dart';
import 'package:nishauri/src/features/bp/data/data_store/types/blood_pressure_record.dart';
import 'package:nishauri/src/features/bp/data/data_store/types/full_entry.dart';
import 'package:nishauri/src/features/bp/data/data_store/types/medicine.dart';
import 'package:nishauri/src/features/bp/data/data_store/types/medicine_intake.dart';
import 'package:nishauri/src/features/bp/data/data_store/types/note.dart';
import 'package:nishauri/src/features/bp/data/data_store/types/units/weight.dart';
import 'package:nishauri/src/features/bp/data/models/blood_pressure/pressure_unit.dart';
import 'package:nishauri/src/features/bp/data/models/storage/settings_store.dart';
import 'package:nishauri/src/features/bp/presentation/components/fullscreen_dialoge.dart';
import 'package:nishauri/src/features/bp/presentation/features/bluetooth/bluetooth_input.dart';
import 'package:nishauri/src/features/bp/presentation/features/input/forms/date_format.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:nishauri/src/features/bp/presentation/features/settings/tiles/color_picker_tile.dart';

class AddEntryDialoge extends StatefulWidget {
  final FullEntry? initialRecord;
  final List<Medicine> availableMeds;

  const AddEntryDialoge({
    super.key,
    required this.availableMeds,
    this.initialRecord,
});

  @override
  State<AddEntryDialoge> createState() => _AddEntryDialogeState();
}

class _AddEntryDialogeState extends State<AddEntryDialoge> {
  final recordFormKey = GlobalKey<FormState>();
  final medicationFormKey = GlobalKey<FormState>();

  final sysFocusNode = FocusNode();
  final diaFocusNode = FocusNode();
  final pulFocusNode = FocusNode();
  final noteFocusNode = FocusNode();
  final dosisFocusNote = FocusNode();

  late final TextEditingController sysController;
  late final TextEditingController diaController;
  late final TextEditingController pulController;
  late final TextEditingController noteController;

  late DateTime time;
  Color? color;
  int? systolic;
  int? diastolic;
  int? pulse;
  Medicine? selectedMed;
  bool _showMedicineDosisInput = false;
  double? medicineDosis;

  @override
  void initState() {
    super.initState();
    sysController = TextEditingController();
    diaController = TextEditingController();
    pulController = TextEditingController();
    noteController = TextEditingController();
    _loadFields(widget.initialRecord);

    sysFocusNode.requestFocus();
    ServicesBinding.instance.keyboard.addHandler(_onKey);
  }

  @override
  void dispose() {
    sysController.dispose();
    diaController.dispose();
    pulController.dispose();
    noteController.dispose();

    sysFocusNode.dispose();
    diaFocusNode.dispose();
    pulFocusNode.dispose();
    noteFocusNode.dispose();
    ServicesBinding.instance.keyboard.removeHandler(_onKey);
    super.dispose();
  }

  void _loadFields(FullEntry? entry) {
    final settings = context.read<Settings>();
    time = entry?.time ?? DateTime.now();
    final int? colorValue = entry?.color;
    final sysValue = switch(settings.preferredPressureUnit) {
      PressureUnit.mmHg => entry?.sys?.mmHg,
      PressureUnit.kPa => entry?.sys?.kPa.round(),
    };
    final diaValue = switch(settings.preferredPressureUnit) {
      PressureUnit.mmHg => entry?.dia?.mmHg,
      PressureUnit.kPa => entry?.dia?.kPa.round(),
    };
    if (colorValue != null) color = Color(colorValue);
    if (entry?.sys != null) sysController.text = sysValue.toString();
    if (entry?.dia != null) diaController.text = diaValue.toString();
    if (entry?.pul != null) pulController.text = entry!.pul!.toString();
    if (entry?.note != null) noteController.text = entry!.note!;
  }

  bool _onKey(KeyEvent event) {
    if (event is! KeyDownEvent) return false;
    final isBackspace = event.logicalKey.keyId == 0x00100000008;
    if (!isBackspace) return false;
    recordFormKey.currentState?.save();
    if (diaFocusNode.hasFocus && diastolic == null
        || pulFocusNode.hasFocus && pulse == null
        || noteFocusNode.hasFocus && noteController.text.isEmpty
    ) {
      FocusScope.of(context).previousFocus();
    }
    return false;
  }

  Widget _buildValueInput(AppLocalizations localizations, Settings settings, {
    String? labelText,
    void Function(String?)? onSaved,
    FocusNode? focusNode,
    TextEditingController? controller,
    String? Function(String?)? validator,
  }) => Expanded(
    child: TextFormField(
      decoration: InputDecoration(
        labelText: labelText,
      ),
      keyboardType: TextInputType.number,
      focusNode: focusNode,
      onSaved: onSaved,
      controller: controller,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      onChanged: (String value) {
        if (value.isNotEmpty
            && (int.tryParse(value) ?? -1) > 40) {
          FocusScope.of(context).nextFocus();
        }
      },
      validator: (String? value) {
        if (!settings.allowMissingValues
            && (value == null
                || value.isEmpty
                || int.tryParse(value) == null)) {
          return localizations.errNaN;
        } else if (settings.validateInputs
            && (int.tryParse(value ?? '') ?? -1) <= 30) {
          return localizations.errLt30;
        } else if (settings.validateInputs
            && (int.tryParse(value ?? '') ?? 0) >= 400) {
          // https://pubmed.ncbi.nlm.nih.gov/7741618/
          return localizations.errUnrealistic;
        }
        return validator?.call(value);
      },
    ),
  );

  RoundedRectangleBorder _buildShapeBorder([Color? color]) =>
      RoundedRectangleBorder(
        side: Theme.of(context).inputDecorationTheme.border?.borderSide
            ?? const BorderSide(width: 3),
        borderRadius: BorderRadius.circular(20),
      );

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final settings = context.watch<Settings>();
    return FullscreenDialoge(
      onActionButtonPressed: () {
        BloodPressureRecord? record;
        Note? note;
        final List<MedicineIntake> intakes = [];

        final bool shouldHaveRecord = (sysController.text.isNotEmpty
            || diaController.text.isNotEmpty
            || pulController.text.isNotEmpty);

        if (shouldHaveRecord && (recordFormKey.currentState?.validate() ?? false)) {
          recordFormKey.currentState?.save();
          if (systolic != null || diastolic != null || pulse != null) {
            final pressureUnit = settings.preferredPressureUnit;
            record = BloodPressureRecord(
              time: time,
              sys: systolic == null ? null : pressureUnit.wrap(systolic!),
              dia: diastolic == null ? null : pressureUnit.wrap(diastolic!),
              pul: pulse,
            );
          }
        }


        if (noteController.text.isNotEmpty || color != null) {
          note = Note(
            time: time,
            note: noteController.text.isEmpty ? null : noteController.text,
            color: color?.value,
          );
        }
        if (_showMedicineDosisInput
            && (medicationFormKey.currentState?.validate() ?? false)) {
          medicationFormKey.currentState?.save();
          if (medicineDosis != null
              && selectedMed != null) {
            intakes.add(MedicineIntake(
              time: time,
              medicine: selectedMed!,
              dosis: Weight.mg(medicineDosis!),
            ));
          }
        }

        if (record != null || intakes.isNotEmpty || note != null) {
          if (record == null && shouldHaveRecord) return; // Errors are shown
          if (intakes.isEmpty && _showMedicineDosisInput) return; // Errors are shown
          record ??= BloodPressureRecord(time: time);
          note ??= Note(time: time);
          Navigator.pop(context, (record, note, intakes));
        }
      },
      actionButtonText: localizations.btnSave,
      bottomAppBar: settings.bottomAppBars,
      body: SizeChangedLayoutNotifier(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          children: [
            if (settings.bleInput)
              BluetoothInput(
                onMeasurement: (record) => setState(
                      () => _loadFields((record, Note(time: record.time, note: noteController.text, color: color?.value), [])),
                ),
              ),
            if (settings.allowManualTimeInput)
              ListTileTheme(
                shape: _buildShapeBorder(),
                child: DateForm(
                  validate: settings.validateInputs,
                  dateFormatString: settings.dateFormatString,
                  initialTime: time,
                  onTimeSelected: (newTime) => setState(() {
                    time = newTime;
                  }),
                ),
              ),
            Form(
              key: recordFormKey,
              child: Column(
                children: [
                  const SizedBox(height: 16,),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildValueInput(localizations, settings,
                        focusNode: sysFocusNode,
                        labelText: localizations.sysLong,
                        controller: sysController,
                        onSaved: (value) =>
                            setState(() => systolic = int.tryParse(value ?? '')),
                      ),
                      const SizedBox(width: 16,),
                      _buildValueInput(localizations, settings,
                        labelText: localizations.diaLong,
                        controller: diaController,
                        onSaved: (value) =>
                            setState(() => diastolic = int.tryParse(value ?? '')),
                        focusNode: diaFocusNode,
                        validator: (value) {
                          if (settings.validateInputs
                              && (int.tryParse(value ?? '') ?? 0)
                                  >= (int.tryParse(sysController.text) ?? 1)
                          ) {
                            return AppLocalizations.of(context)?.errDiaGtSys;
                          }
                          return null;
                        },
                      ),
                      const SizedBox(width: 16,),
                      _buildValueInput(localizations, settings,
                        labelText: localizations.pulLong,
                        controller: pulController,
                        focusNode: pulFocusNode,
                        onSaved: (value) =>
                            setState(() => pulse = int.tryParse(value ?? '')),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: TextFormField(
                controller: noteController,
                focusNode: noteFocusNode,
                decoration: InputDecoration(
                  labelText: localizations.addNote,
                ),
                minLines: 1,
                maxLines: 4,
              ),
            ),
            ColorSelectionListTile(
              title: Text(localizations.color),
              onMainColorChanged: (Color value) => setState(() {
                color = (value == Colors.transparent) ? null : value;
              }),
              initialColor: color ?? Colors.transparent,
              shape: _buildShapeBorder(color),
            ),
            if (widget.initialRecord == null && widget.availableMeds.isNotEmpty)
              Form(
                key: medicationFormKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Row(
                    children: [
                      Expanded(
                        child: DropdownButtonFormField<Medicine?>(
                          isExpanded: true,
                          value: selectedMed,
                          items: [
                            for (final med in widget.availableMeds)
                              DropdownMenuItem(
                                value: med,
                                child: Text(med.designation),
                              ),
                            DropdownMenuItem(
                              child: Text(localizations.noMedication),
                            ),
                          ],
                          onChanged: (v) {
                            setState(() {
                              if (v != null) {
                                _showMedicineDosisInput = true;
                                selectedMed = v;
                                medicineDosis = v.dosis?.mg;
                                dosisFocusNote.requestFocus();
                              } else {
                                _showMedicineDosisInput = false;
                                selectedMed = null;
                              }
                            });
                          },
                        ),
                      ),
                      if (_showMedicineDosisInput)
                        const SizedBox(width: 14,),
                      if (_showMedicineDosisInput)
                        Expanded(
                          child: TextFormField(
                            initialValue: medicineDosis?.toString(),
                            decoration: InputDecoration(
                              labelText: localizations.dosis,
                            ),
                            focusNode: dosisFocusNote,
                            keyboardType: TextInputType.number,
                            onChanged: (value) {
                              setState(() {
                                final dosis = int.tryParse(value)?.toDouble()
                                    ?? double.tryParse(value);
                                if(dosis != null && dosis > 0) medicineDosis = dosis;
                              });
                            },
                            inputFormatters: [FilteringTextInputFormatter.allow(
                              RegExp(r'([0-9]+(\.([0-9]*))?)'),),],
                            validator: (String? value) {
                              if (!_showMedicineDosisInput) return null;
                              if (((int.tryParse(value ?? '')?.toDouble()
                                  ?? double.tryParse(value ?? '')) ?? 0) <= 0) {
                                return localizations.errNaN;
                              }
                              return null;
                            },
                          ),
                        ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

Future<FullEntry?> showAddEntryDialoge(
    BuildContext context,
    MedicineRepository medRepo,
    [FullEntry? initialRecord,
    ]) async {
  final meds = await medRepo.getAll();
  return showDialog<FullEntry>(
    context: context, builder: (context) => AddEntryDialoge(
    initialRecord: initialRecord,
    availableMeds: meds,
  ),
  );
}