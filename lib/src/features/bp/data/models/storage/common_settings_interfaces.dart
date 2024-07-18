

import 'package:nishauri/src/features/bp/data/models/export_import/export_configuration.dart';

/// Common fields that are present in both [CsvExportSettings] and [PdfExportSettings].
abstract class CustomFieldsSettings {
  /// Active export columns.
  ///
  /// Implementers must propagate any notifyListener calls.
  ActiveExportColumnConfiguration get exportFieldsConfiguration;
}
