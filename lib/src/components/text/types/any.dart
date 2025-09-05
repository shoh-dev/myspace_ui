import 'package:flutter/material.dart';
import 'package:myspace_ui/src/components/text/text_component.dart';

final class AnyTextComponent extends TextComponent {
  const AnyTextComponent(this.value, {super.key, super.style});

  final dynamic value;

  @override
  Widget build(BuildContext context) {
    return Text(value.toString(), key: key, style: style);
  }
}
