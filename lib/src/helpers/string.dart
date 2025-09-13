import 'package:flutter/material.dart';

extension StringHelpers on String {
  TimeOfDay? toTimeOfDay() {
    try {
      final parts = split(':');
      if (parts.length != 2) return null;

      final hour = int.tryParse(parts[0]);
      final minute = int.tryParse(parts[1]);

      if (hour == null ||
          minute == null ||
          hour < 0 ||
          hour > 23 ||
          minute < 0 ||
          minute > 59) {
        return null;
      }

      return TimeOfDay(hour: hour, minute: minute);
    } catch (e) {
      return null;
    }
  }

  List<String>? splitOrNull(String separator) {
    try {
      if (isEmpty) return [];
      return split(separator);
    } catch (e) {
      return null;
    }
  }

  String capitalize() {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1)}';
  }

  String cleanUp() {
    return trim().replaceAll(' ', '');
  }
}

extension StringNullHelpers on String? {
  bool get isEmptyOrNull {
    return this == null || this!.isEmpty || this! == 'null';
  }
}
