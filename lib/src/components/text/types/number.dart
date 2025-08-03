import 'package:flutter/material.dart';
import 'package:myspace_ui/src/components/text/text_component.dart';
import 'package:intl/intl.dart';

class NumberTextComponent extends TextComponent {
  const NumberTextComponent(
    this.number, {
    super.textAlign,
    super.key,
    super.style,
    super.builder,
  });

  final num number;

  @override
  Widget build(BuildContext context) {
    final NumberFormat format =
        NumberFormat.decimalPattern(); //todo: add to ui_configuration.dart
    final formatted = format.format(number);
    return Text(
      builder?.call(formatted) ?? formatted,
      style: style,
      textAlign: textAlign,
    );
  }
}
