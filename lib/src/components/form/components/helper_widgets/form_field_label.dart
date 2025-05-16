import 'package:flutter/material.dart';
import 'package:myspace_ui/myspace_ui.dart';

class FormFieldLabel extends StatelessWidget {
  const FormFieldLabel(
    this.label, {
    super.key,
    this.onPressed,
    this.hasError = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool hasError;

  @override
  Widget build(BuildContext context) {
    final style = context.textTheme.bodyMedium!.copyWith(
      color: hasError ? context.theme.colorScheme.error : null,
    );
    if (onPressed == null) {
      return Text(label, style: style);
    }
    return GestureDetector(onTap: onPressed, child: Text(label, style: style));
  }
}
