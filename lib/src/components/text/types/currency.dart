import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import 'package:myspace_ui/src/components/text/text_component.dart';

class CurrencyTextComponent extends TextComponent {
  const CurrencyTextComponent(this.number, {super.key, this.style});

  final num number;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    final format = intl.NumberFormat.compactSimpleCurrency(
      locale: 'en_US',
      decimalDigits: 2,
    );
    return Text(format.format(number), style: style);
  }
}
