import 'package:flutter/material.dart';
import 'package:myspace_ui/myspace_ui.dart';

class FormFieldErrorText extends StatelessWidget {
  const FormFieldErrorText(this.errorText, {super.key});

  final String errorText;

  @override
  Widget build(BuildContext context) {
    return Text(
      errorText,
      style: context.textTheme.bodySmall!.copyWith(
        color: context.colorScheme.error,
      ),
    );
  }
}
