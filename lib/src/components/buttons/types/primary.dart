import 'package:flutter/material.dart';
import 'package:myspace_ui/myspace_ui.dart';
import 'package:myspace_ui/src/components/shared/disabled_component.dart';

Widget _disabled(Widget child, VoidCallback? onPressed) {
  return DisabledComponent(isDisabled: onPressed == null, child: child);
}

class PrimaryButtonComponent extends ButtonComponent {
  const PrimaryButtonComponent({
    super.key,
    super.onPressed,
    required String text,
    super.icon,
    super.isLoading,
    super.backgroundColor,
    super.foregroundColor,
    super.fontSize,
    super.style,
  }) : super(text: text);

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return _disabled(
        FilledButton(
          onPressed: null,
          style: FilledButton.styleFrom(
            backgroundColor: backgroundColor,
            foregroundColor: foregroundColor,
            textStyle: style ?? TextStyle(fontSize: fontSize),
          ),
          child: CircularProgressIndicator.adaptive(),
        ),
        null,
      );
    }
    if (icon != null) {
      return _disabled(
        FilledButton.icon(
          style: FilledButton.styleFrom(
            backgroundColor: backgroundColor,
            foregroundColor: foregroundColor,
            textStyle: style ?? TextStyle(fontSize: fontSize),
          ),
          onPressed: onPressed,
          label: Text(text!),
          icon: icon,
        ),
        onPressed,
      );
    }
    return _disabled(
      FilledButton(
        style: FilledButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          textStyle: style ?? TextStyle(fontSize: fontSize),
        ),
        onPressed: onPressed,
        child: Text(text!),
      ),
      onPressed,
    );
  }
}
