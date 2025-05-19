import 'package:flutter/material.dart';

extension ColorHelpers on Color {
  String toHex() {
    return '#${toARGB32().toRadixString(16).padLeft(8, '0')}';
  }
}
