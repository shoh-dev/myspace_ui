import 'package:flutter/material.dart';
import 'package:myspace_ui/myspace_ui.dart';

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
    final formatted = context.uiConfiguration.numberFormat.format(number);
    return Text(
      builder?.call(formatted) ?? formatted,
      key: key,
      style: style,
      textAlign: textAlign,
    );
  }
}
