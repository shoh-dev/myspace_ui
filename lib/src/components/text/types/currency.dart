import 'package:flutter/material.dart';
import 'package:myspace_ui/src/components/text/text_component.dart';
import 'package:myspace_ui/src/ui_configuration.dart';

class CurrencyTextComponent extends TextComponent {
  const CurrencyTextComponent(
    this.number, {
    super.key,
    super.style,
    super.builder,
  });

  final num number;

  @override
  Widget build(BuildContext context) {
    final currencyFormat = context.uiConfiguration.currencyFormat;
    final formatted = currencyFormat.format(number);
    return Text(builder?.call(formatted) ?? formatted, key: key, style: style);
  }
}
