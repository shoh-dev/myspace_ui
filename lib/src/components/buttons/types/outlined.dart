import 'package:flutter/material.dart';
import 'package:myspace_ui/myspace_ui.dart';
import 'package:myspace_ui/src/components/shared/disabled_component.dart';

Widget _disabled(Widget child, VoidCallback? onPressed) {
  return DisabledComponent(isDisabled: onPressed == null, child: child);
}

class OutlinedButtonComponent extends ButtonComponent {
  const OutlinedButtonComponent({
    super.key,
    super.onPressed,
    required String text,
    super.icon,
    super.foregroundColor,
  }) : super(text: text);

  @override
  Widget build(BuildContext context) {
    if (icon != null) {
      return _disabled(
        OutlinedButton.icon(
          onPressed: onPressed,
          style: OutlinedButton.styleFrom(
            foregroundColor: foregroundColor,
            side: BorderSide(
              color: onPressed == null
                  ? context.theme.disabledColor
                  : foregroundColor ?? context.colorScheme.primary,
            ),
          ),
          label: Text(text!),
          icon: icon,
        ),
        onPressed,
      );
    }
    return _disabled(
      OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: foregroundColor,
          side: BorderSide(
            color: onPressed == null
                ? context.theme.disabledColor
                : foregroundColor ?? context.colorScheme.primary,
          ),
        ),
        child: Text(text!),
      ),
      onPressed,
    );
  }
}
