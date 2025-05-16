import 'package:flutter/material.dart';
import 'package:myspace_ui/src/components/text/text_component.dart';

class NumberTextComponent extends TextComponent {
  const NumberTextComponent(this.number, {super.key, this.style});

  final num number;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    //todo: format as number
    return Text(number.toString(), style: style);
  }
}
