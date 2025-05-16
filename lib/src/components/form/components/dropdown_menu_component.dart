import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:myspace_ui/myspace_ui.dart';
import 'package:myspace_ui/src/components/shared/disabled_component.dart';

class DropdownMenuComponent<T> extends FormField<DropdownItem<T>> {
  DropdownMenuComponent({
    super.key,
    super.initialValue,
    super.validator,
    super.onSaved,
    super.enabled,
    super.autovalidateMode,
    required Iterable<DropdownItem<T>> items,
    void Function(DropdownItem<T>? value, TextEditingController controller)?
    onChanged,
    String? hintText,
    String? label,
    bool canUnselect = false,
    String? helperText,
    double? menuWidth,
  }) : super(
         builder: (field) {
           return _Menu<T>(
             field: field,
             onChanged: onChanged,
             hintText: hintText,
             label: label,
             canUnselect: canUnselect,
             enabled: enabled,
             items: items,
             initialValue: initialValue,
             helperText: helperText,
             menuWidth: menuWidth,
           );
         },
       ) {
    assert(items.isNotEmpty);
    //check if labels are not duplicated
    final labels = items.map((e) => e.label);
    assert(labels.length == labels.toSet().length, 'Labels must be unique');
  }
  @override
  FormFieldState<DropdownItem<T>> createState() =>
      _DropdownMenuComponentState<T>();
}

class _DropdownMenuComponentState<T> extends FormFieldState<DropdownItem<T>> {
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
    this.canUnselect = false,
    required this.enabled,
    required this.items,
    this.initialValue,
    this.helperText,
    this.menuWidth,
  });

  final FormFieldState<DropdownItem<T>> field;
  final void Function(DropdownItem<T>? value, TextEditingController controller)?
  onChanged;
  final String? hintText;
  final String? label;
  final bool canUnselect;
  final bool enabled;
  final Iterable<DropdownItem<T>> items;
  final DropdownItem<T>? initialValue;
  final String? helperText;
  final double? menuWidth;

  @override
  State<_Menu> createState() => __MenuState<T>();
}

class __MenuState<T> extends State<_Menu<T>> {
  FormFieldState<DropdownItem<T>> get field => widget.field;
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    log('_Menu dispose');
    super.dispose();
  }

  bool get canShowResetButton {
    // if (widget.initialValue == field.value) return false;
    return widget.canUnselect && field.value != null && widget.enabled;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.initialValue != null) {
        field.didChange(widget.initialValue);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return DisabledComponent(
      isDisabled: !widget.enabled,
      child: LayoutComponent.column(
        mainAxisSize: MainAxisSize.min,
        spacing: 4,
        children: [
          if (widget.label != null)
            FormFieldLabel(widget.label!, hasError: field.hasError),
          DropdownMenu<DropdownItem<T>>(
            controller: _controller,
            width: widget.menuWidth,
            dropdownMenuEntries: [
              for (final item in widget.items)
                DropdownMenuEntry(
                  value: item,
                  label: item.label,
                  leadingIcon:
                      item.icon != null ? Icon(item.icon, size: 18) : null,
                  enabled: item.enabled,
                  trailingIcon:
                      item.value == field.value?.value
                          ? const Icon(Icons.check)
                          : null,
                ),
            ],
            searchCallback: (entries, query) {
              if (query.isEmpty) return null;
              final index = entries.indexWhere((element) {
                return element.label.toLowerCase().contains(
                  query.toLowerCase(),
                );
              });
              return index == -1 ? null : index;
            },
            leadingIcon:
                canShowResetButton
                    ? Transform.scale(
                      scale: .6,
                      child: ButtonComponent.iconOutlined(
                        icon: Icons.clear_rounded,
                        onPressed: () => reset(context),
                      ),
                    )
                    : null,
            initialSelection: widget.initialValue,
            hintText: widget.hintText,
            enabled: widget.enabled,
            enableSearch: false,
            enableFilter: false,
            helperText: widget.helperText,
            errorText: field.errorText,
            expandedInsets: EdgeInsets.zero,
            onSelected: (value) {
              field.didChange(value);
              widget.onChanged?.call(value, _controller);
            },
          ),
        ],
      ),
    );
  }

  void reset(BuildContext context) {
    field.reset();
    widget.onChanged?.call(null, _controller);
    _controller.clear();
    FocusScope.of(context).unfocus();
  }
}
