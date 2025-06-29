import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myspace_ui/src/components/text/text_component.dart';

class DateTextComponent extends TextComponent {
  const DateTextComponent(
    this.date, {
    super.key,
    this.style,
    this.format,
    this.builder,
  });

  final DateTime date;
  final DateFormat? format;
  final TextStyle? style;
  final String Function(String formattedDate)? builder;

  @override
  Widget build(BuildContext context) {
    final formattedDate = format?.format(date) ?? DateFormat.yMd().format(date);
    return Text(builder?.call(formattedDate) ?? formattedDate, style: style);
  }
}
