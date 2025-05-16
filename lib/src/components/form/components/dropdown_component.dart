import 'package:flutter/material.dart';
import 'package:myspace_ui/myspace_ui.dart';
import 'package:myspace_ui/src/components/shared/disabled_component.dart';

class DropdownComponent<T> extends FormField<DropdownItem<T>> {
  DropdownComponent({
    super.key,
    super.initialValue,
    super.validator,
    super.onSaved,
    super.enabled,
    super.autovalidateMode,
    required Iterable<DropdownItem<T>> items,
    void Function(DropdownItem<T>? value)? onChanged,
    String? hintText,
    String? label,
    String? helperText,
    double? menuWidth,
  }) : super(
         builder: (field) {
           field.didChange(initialValue);
           return _Menu<T>(
             field: field,
             onChanged: onChanged,
             hintText: hintText,
             label: label,
             items: items,
             initialValue: initialValue,
             helperText: helperText,
             menuWidth: menuWidth,
           );
         },
       ) {
    assert(items.isNotEmpty);
    // //check if labels are not duplicated
    // final labels = items.map((e) => e.label);
    // assert(labels.length == labels.toSet().length, 'Labels must be unique');
  }
  @override
  FormFieldState<DropdownItem<T>> createState() => _DropdownComponentState<T>();
}

class _DropdownComponentState<T> extends FormFieldState<DropdownItem<T>> {
  @override
  void initState() {
    super.initState();
    if (widget.initialValue != null) setValue(widget.initialValue);
  }
}

class _Menu<T> extends StatefulWidget {
  const _Menu({
    super.key,
    required this.field,
    this.onChanged,
    this.hintText,
    this.label,
    required this.items,
    this.initialValue,
    this.helperText,
    this.menuWidth,
  });

  final FormFieldState<DropdownItem<T>> field;
  final void Function(DropdownItem<T>? value)? onChanged;
  final String? hintText;
  final String? label;
  final Iterable<DropdownItem<T>> items;
  final DropdownItem<T>? initialValue;
  final String? helperText;
  final double? menuWidth;

  @override
  State<_Menu> createState() => __MenuState<T>();
}

class __MenuState<T> extends State<_Menu<T>> {
  FormFieldState<DropdownItem<T>> get field => widget.field;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.items.any(
        (element) => element.value == widget.initialValue?.value,
      )) {
        field.didChange(widget.initialValue);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return DisabledComponent(
      isDisabled: widget.onChanged == null,
      child: LayoutComponent.column(
        mainAxisSize: MainAxisSize.min,
        spacing: 4,
        children: [
          if (widget.label != null)
            FormFieldLabel(widget.label!, hasError: field.hasError),
          DropdownButtonFormField<DropdownItem<T>>(
            isExpanded: true,
            items: [
              for (final item in widget.items)
                DropdownMenuItem(
                  value: item,
                  enabled: item.enabled,
                  child: LayoutComponent.row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if (item.icon != null) ...[
                        Icon(item.icon, size: 18),
                        const SizedBox(width: 4),
                      ],
                      Expanded(child: Text(item.label)),
                      if (item.value == field.value?.value)
                        const Icon(Icons.check),
                    ],
                  ),
                ),
            ],
            value:
                widget.items.any(
                      (element) => element.value == widget.initialValue?.value,
                    )
                    ? field.value
                    : null,
            hint: widget.hintText != null ? Text(widget.hintText!) : null,
            selectedItemBuilder: (context) {
              return [for (final item in widget.items) Text(item.label)];
            },
            decoration: InputDecoration(
              helperText: widget.helperText,
              errorText: field.errorText,
            ),
            onChanged: (value) {
              if (value?.value == field.value?.value) return;
              field.didChange(value);
              widget.onChanged?.call(value);
            },
          ),
        ],
      ),
    );
  }

  void reset(BuildContext context) {
    field.reset();
    widget.onChanged?.call(null);
    FocusScope.of(context).unfocus();
  }
}
