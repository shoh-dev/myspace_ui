import 'package:flutter/material.dart';

class DropdownItem<T> {
  final T value;
  final String label;
  final bool enabled;
  final Widget? icon;
  final Color? foregroundColor;

  DropdownItem({
    required this.value,
    required this.label,
    this.enabled = true,
    this.icon,
    this.foregroundColor,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DropdownItem<T> && other.value == value;
  }

  @override
  int get hashCode => value.hashCode;
}
