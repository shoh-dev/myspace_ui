import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myspace_ui/src/components/text/text_component.dart';

class DateTextComponent extends TextComponent {
  const DateTextComponent(this.date, {super.key, this.style, this.format});

  final DateTime date;
  final DateFormat? format;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return Text(
      format?.format(date) ?? DateFormat.yMd().format(date),
      style: style,
    );
  }
}
