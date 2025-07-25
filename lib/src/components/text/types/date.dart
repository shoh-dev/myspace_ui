import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myspace_ui/src/components/text/text_component.dart';

class DateTextComponent extends TextComponent {
  const DateTextComponent(
    this.date, {
    super.key,
    super.style,
    this.format,
    super.builder,
  });

  final DateTime date;
  final DateFormat? format;

  @override
  Widget build(BuildContext context) {
    final formattedDate = format?.format(date) ?? DateFormat.yMd().format(date);
    return Text(builder?.call(formattedDate) ?? formattedDate, style: style);
  }
}
