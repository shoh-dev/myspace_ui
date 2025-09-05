import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:myspace_ui/myspace_ui.dart';
import 'package:myspace_ui/src/components/shared/disabled_component.dart';

class DropdownButtonComponent<T> extends StatelessWidget {
  const DropdownButtonComponent({
    super.key,
    required this.items,
    this.onChanged,
    this.hintText,
    this.label,
    this.value,
    this.helperText,
    this.menuWidth,
    this.dropdownColor,
    this.menuMaxHeight,
  });

  final void Function(DropdownItem<T>? value)? onChanged;
  final String? hintText;
  final String? label;
  final Iterable<DropdownItem<T>> items;
  final T? value;
  final String? helperText;
  final double? menuWidth;
  final Color? dropdownColor;
  final double? menuMaxHeight;

  @override
  Widget build(BuildContext context) {
    final inputDecoration =
        context.theme.dropdownMenuTheme.inputDecorationTheme;
    return DisabledComponent(
      isDisabled: onChanged == null,
      child: LayoutComponent.column(
        mainAxisSize: MainAxisSize.min,
        spacing: 4,
        children: [
          if (label != null) FormFieldLabel(label!),
          DropdownButtonFormField<DropdownItem<T>>(
            isExpanded: true,
            elevation: 1,
            borderRadius: context.borderRadius / 2,
            menuMaxHeight: menuMaxHeight,
            items: [
              for (final item in items)
                DropdownMenuItem(
                  value: item,
                  enabled: item.enabled,
                  child: LayoutComponent.row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if (item.icon != null) ...[
                        item.icon!,
                        const SizedBox(width: 4),
                      ],
                      Expanded(
                        child: Text(
                          item.label,
                          style: TextStyle(color: item.foregroundColor),
                        ),
                      ),
                      if (item.value == value)
                        Icon(Icons.check, color: item.foregroundColor),
                    ],
                  ),
                ),
            ],
            dropdownColor: dropdownColor,
            value: items.firstWhereOrNull((element) => element.value == value),
            hint: hintText != null ? Text(hintText!) : null,
            selectedItemBuilder: (context) {
              return [for (final item in items) Text(item.label)];
            },
            decoration: InputDecoration(
              helperText: helperText,
              border: inputDecoration?.border,
              enabledBorder: inputDecoration?.enabledBorder,
              focusedBorder: inputDecoration?.focusedBorder,
              errorBorder: inputDecoration?.errorBorder,
              focusedErrorBorder: inputDecoration?.focusedErrorBorder,
              disabledBorder: inputDecoration?.disabledBorder,
              contentPadding: inputDecoration?.contentPadding,
              fillColor: inputDecoration?.fillColor,
              filled: inputDecoration?.filled,
              isDense: inputDecoration?.isDense,
              hintStyle: inputDecoration?.hintStyle,
              labelStyle: inputDecoration?.labelStyle,
              helperStyle: inputDecoration?.helperStyle,
              errorStyle: inputDecoration?.errorStyle,
              floatingLabelBehavior: inputDecoration?.floatingLabelBehavior,
            ),
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}
