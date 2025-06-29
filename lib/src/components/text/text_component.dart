import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'types/hardcoded.dart';
import 'types/any.dart';
import 'types/currency.dart';
import 'types/number.dart';
import 'types/date.dart';

abstract class TextComponent extends StatelessWidget {
  const TextComponent({super.key});

  factory TextComponent.hardCoded(
    String text, {
    bool ignoreLog,
    TextStyle? style,
  }) = HardCodedTextComponent;

  const factory TextComponent.number(num number, {TextStyle? style}) =
      NumberTextComponent;

  const factory TextComponent.any(dynamic value, {TextStyle? style}) =
      AnyTextComponent;

  const factory TextComponent.currency(num number, {TextStyle? style}) =
      CurrencyTextComponent;

  const factory TextComponent.date(
    DateTime date, {
    TextStyle? style,
    DateFormat? format,
    String Function(String formattedDate)? builder,
  }) = DateTextComponent;
}
