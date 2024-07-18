import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:nishauri/src/features/bp/data/data_store/repositories/blood_pressure_repository.dart';
import 'package:nishauri/src/features/bp/data/data_store/repositories/medicine_intake_repository.dart';
import 'package:nishauri/src/features/bp/data/data_store/repositories/note_repository.dart';
import 'package:nishauri/src/features/bp/data/data_store/types/date_range.dart';
import 'package:nishauri/src/features/bp/data/models/storage/export_columns_store.dart';
import 'package:nishauri/src/features/bp/data/models/storage/export_csv_settings_store.dart';
import 'package:nishauri/src/features/bp/data/models/storage/export_pdf_settings_store.dart';
import 'package:nishauri/src/features/bp/data/models/storage/export_settings_store.dart';
import 'package:nishauri/src/features/bp/data/models/storage/intervall_store.dart';
import 'package:nishauri/src/features/bp/data/models/storage/settings_store.dart';
import 'package:nishauri/src/features/bp/presentation/components/confirm_deletion_dialoge.dart';

class DeleteDataScreen extends StatefulWidget {
  const DeleteDataScreen({super.key});

  @override
  State<DeleteDataScreen> createState() => _DeleteDataScreenState();
}

class _DeleteDataScreenState extends State<DeleteDataScreen> {
  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.delete),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.settings),
            title: Text(localizations.deleteAllSettings),
            trailing: const Icon(Icons.delete_forever),
            onTap: () async {
              final messanger = ScaffoldMessenger.of(context);
              if (await showConfirmDeletionDialoge(context, localizations.warnDeletionUnrecoverable)) {
                context.read<Settings>().reset();
                context.read<ExportSettings>().reset();
                context.read<CsvExportSettings>().reset();
                context.read<PdfExportSettings>().reset();
                context.read<IntervallStoreManager>().reset();
                context.read<ExportColumnsManager>().reset();
                messanger.showSnackBar(SnackBar(
                  content: Text(localizations.deletionConfirmed),
                ));
              }
            },
          ),
          ListTile(
            leading: const Icon(Icons.timeline),
            title: Text(localizations.deleteAllMeasurements),
            trailing: const Icon(Icons.delete_forever),
            onTap: () async {
              final messanger = ScaffoldMessenger.of(context);
              if (await showConfirmDeletionDialoge(context, localizations.warnDeletionUnrecoverable)) {
                final repo = RepositoryProvider.of<BloodPressureRepository>(context);
                final previousRecords = await repo.get(DateRange.all());
                for (final record in previousRecords) {
                  await repo.remove(record);
                }
                messanger.showSnackBar(SnackBar(
                  content: Text(localizations.deletionConfirmed),
                  action: SnackBarAction(
                    label: localizations.btnUndo,
                    onPressed: () => Future.forEach(previousRecords, repo.add),
                  ),
                ));
              }
            },
          ),
          ListTile(
            leading: const Icon(Icons.notes),
            title: Text(localizations.deleteAllNotes),
            trailing: const Icon(Icons.delete_forever),
            onTap: () async {
              final messanger = ScaffoldMessenger.of(context);
              if (await showConfirmDeletionDialoge(context, localizations.warnDeletionUnrecoverable)) {
                final repo = RepositoryProvider.of<NoteRepository>(context);
                final previousNotes = await repo.get(DateRange.all());
                for (final note in previousNotes) {
                  await repo.remove(note);
                }
                messanger.showSnackBar(SnackBar(
                  content: Text(localizations.deletionConfirmed),
                  action: SnackBarAction(
                    label: localizations.btnUndo,
                    onPressed: () => Future.forEach(previousNotes, repo.add),
                  ),
                ));
              }
            },
          ),
          ListTile(
            leading: const Icon(Icons.medication),
            title: Text(localizations.deleteAllMedicineIntakes),
            trailing: const Icon(Icons.delete_forever),
            onTap: () async {
              if (await showConfirmDeletionDialoge(context, localizations.warnDeletionUnrecoverable)) {
                final repo = context.read<MedicineIntakeRepository>();
                final allIntakes = await repo.get(DateRange.all());
                for (final intake in allIntakes) {
                  await repo.remove(intake);
                }
                final messanger = ScaffoldMessenger.of(context);
                messanger.showSnackBar(SnackBar(
                  content: Text(localizations.deletionConfirmed),
                ));
              }
            },
          ),
        ],
      ),
    );
  }
}
