import 'package:flutter/material.dart';
import 'package:myspace_ui/myspace_ui.dart';
import 'package:myspace_ui/src/components/shared/disabled_component.dart';

Widget _disabled(Widget child, VoidCallback? onPressed) {
  return DisabledComponent(isDisabled: onPressed == null, child: child);
}

class IconButtonComponent extends ButtonComponent {
  const IconButtonComponent({
    required Widget super.icon,
    String? tooltip,
    super.key,
    super.onPressed,
    super.backgroundColor,
    super.foregroundColor,
    super.iconSize,
    super.padding,
    super.elevation,
    super.shadowColor,
  }) : super(text: tooltip);

  @override
  Widget build(BuildContext context) {
    return _disabled(
      IconButton(
        tooltip: text,
        onPressed: onPressed,
        icon: icon!,
        style: IconButton.styleFrom(
          iconSize: iconSize,
          padding: padding ?? const EdgeInsets.all(4),
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          elevation: elevation,
          shadowColor: shadowColor,
          disabledBackgroundColor: context.colorScheme.primaryContainer
              .withValues(alpha: 0.3),
          disabledForegroundColor: context.colorScheme.onSurface.withValues(
            alpha: 0.3,
          ),
        ),
      ),
      onPressed,
    );
  }
}

class IconButtonComponentDesctructive extends ButtonComponent {
  const IconButtonComponentDesctructive({
    required Widget super.icon,
    String? tooltip,
    super.key,
    super.onPressed,
    super.iconSize,
  }) : super(text: tooltip);

  @override
  Widget build(BuildContext context) {
    return _disabled(
      IconButton(
        tooltip: text,
        onPressed: onPressed,
        icon: icon!,
        style: IconButton.styleFrom(
          iconSize: iconSize,
          backgroundColor: context.colorScheme.error,
          foregroundColor: context.colorScheme.onError,
          disabledForegroundColor: context.colorScheme.onSurface.withValues(
            alpha: 0.3,
          ),
          disabledBackgroundColor: context.colorScheme.error.withValues(
            alpha: 0.1,
          ),
        ),
      ),
      onPressed,
    );
  }
}

class IconButtonComponentOutlined extends ButtonComponent {
  const IconButtonComponentOutlined({
    required Widget super.icon,
    String? tooltip,
    super.key,
    super.onPressed,
    super.foregroundColor,
    super.iconSize,
  }) : super(text: tooltip);

  @override
  Widget build(BuildContext context) {
    return _disabled(
      IconButton(
        tooltip: text,
        onPressed: onPressed,
        icon: icon!,
        isSelected: true,
        style: IconButton.styleFrom(
          iconSize: iconSize,
          padding: const EdgeInsets.all(4),
          backgroundColor: Colors.transparent,
          foregroundColor: foregroundColor ?? context.colorScheme.onSurface,
          disabledForegroundColor: context.colorScheme.onSurface.withValues(
            alpha: 0.3,
          ),
          side: BorderSide(
            color: onPressed == null
                ? context.colorScheme.outline.withValues(alpha: 0.3)
                : context.colorScheme.outline,
          ),
        ),
      ),
      onPressed,
    );
  }
}

class IconButtonComponentPrimary extends ButtonComponent {
  const IconButtonComponentPrimary({
    required Widget super.icon,
    String? tooltip,
    super.key,
    super.onPressed,
    super.foregroundColor,
    super.iconSize,
  }) : super(text: tooltip);

  @override
  Widget build(BuildContext context) {
    return _disabled(
      IconButton(
        tooltip: text,
        onPressed: onPressed,
        icon: icon!,
        isSelected: true,
        style: IconButton.styleFrom(
          iconSize: iconSize,
          padding: const EdgeInsets.all(4),
          backgroundColor: context.colorScheme.primaryContainer,
          foregroundColor:
              foregroundColor ?? context.colorScheme.onPrimaryContainer,
          disabledForegroundColor: context.colorScheme.onSurface.withValues(
            alpha: 0.1,
          ),
          side: BorderSide(
            color: onPressed == null
                ? context.colorScheme.outline.withValues(alpha: 0.3)
                : context.colorScheme.primary,
          ),
        ),
      ),
      onPressed,
    );
  }
}
