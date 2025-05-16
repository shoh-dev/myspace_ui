import 'package:flutter/material.dart';
import 'package:myspace_ui/src/components/text/text_component.dart';

class CurrencyTextComponent extends TextComponent {
  const CurrencyTextComponent(this.number, {super.key, this.style});

  final num number;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    //todo: format as currency
    return Text(number.toString(), style: style);
  }
}
