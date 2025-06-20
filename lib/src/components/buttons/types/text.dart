import 'package:flutter/material.dart';
import 'package:myspace_ui/myspace_ui.dart';
import 'package:myspace_ui/src/components/shared/disabled_component.dart';

Widget _disabled(Widget child, VoidCallback? onPressed) {
  return DisabledComponent(isDisabled: onPressed == null, child: child);
}

class TextButtonComponent extends ButtonComponent {
  const TextButtonComponent({
    super.key,
    super.onPressed,
    required String text,
    super.icon,
    super.style,
    super.padding,
  }) : super(text: text);

  @override
  Widget build(BuildContext context) {
    if (icon != null) {
      return _disabled(
        TextButton.icon(
          style: TextButton.styleFrom(
            iconSize: iconSize,
            padding: padding ?? const EdgeInsets.all(4),
          ),
          onPressed: onPressed,
          label: Text(text!, style: style),
          icon: Icon(icon),
        ),
        onPressed,
      );
    }
    return _disabled(
      TextButton(
        style: TextButton.styleFrom(
          padding: padding ?? const EdgeInsets.all(4),
        ),
        onPressed: onPressed,
        child: Text(text!, style: style),
      ),
      onPressed,
    );
  }
}
