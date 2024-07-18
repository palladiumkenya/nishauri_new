import 'package:flutter/material.dart';
import 'package:nishauri/src/features/bp/data/data_store/types/date_range.dart';

/// Allow converting to custom [DateRange] implementation.
extension DateRangeCompat on DateTimeRange {
  /// Convert to [DateRange].
  DateRange get dateRange => DateRange(start: start, end: end);
}
