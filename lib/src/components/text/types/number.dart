import 'package:flutter/material.dart';
import 'package:myspace_ui/src/components/text/text_component.dart';
import 'package:intl/intl.dart';

class NumberTextComponent extends TextComponent {
  const NumberTextComponent(this.number, {super.key, this.style});

  final num number;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    final NumberFormat format = NumberFormat.decimalPattern();
    return Text(format.format(number), style: style);
  }
}
