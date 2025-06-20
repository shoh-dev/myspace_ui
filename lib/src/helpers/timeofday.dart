import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension TimeOfDayHelpers on TimeOfDay {
  String toFormattedString({bool includeSeconds = false}) {
    final format = (includeSeconds ? 'HH:mm:ss' : 'HH:mm');
    return DateFormat(format).format(DateTime(0, 1, 1, hour, minute));
  }
}
