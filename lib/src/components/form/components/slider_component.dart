import 'package:flutter/material.dart';
import 'package:myspace_ui/myspace_ui.dart';
import 'package:myspace_ui/src/components/shared/disabled_component.dart';

import 'helper_widgets/form_field_error_text.dart';

class SliderComponent extends FormField<double> {
  SliderComponent({
    super.key,
    this.onChanged,
    super.enabled,
    super.initialValue,
    super.onSaved,
    super.validator,
    this.label,
    this.max,
    this.min,
    this.divisions,
  }) : super(
         builder: (field) {
           field.didChange(initialValue);
           return _Slider(
             field: field,
             min: min,
             max: max,
             label: label,
             initialValue: initialValue,
             onChanged: onChanged,
             enabled: enabled,
             divisions: divisions,
           );
         },
       );

  final ValueChanged<double?>? onChanged;
  final double? min;
  final double? max;
  //_max.truncate()
  final int? divisions;
  final String? label;

  @override
  FormFieldState<double> createState() => _SliderComponentState();
}

class _SliderComponentState extends FormFieldState<double> {
  @override
  void initState() {
    super.initState();
    if (widget.initialValue != null) setValue(widget.initialValue);
  }
}

class _Slider extends StatefulWidget {
  const _Slider({
    required this.field,
    this.label,
    this.max,
    this.min,
    this.onChanged,
    this.initialValue,
    this.divisions,
    required this.enabled,
  });

  final FormFieldState<double> field;
  final ValueChanged<double?>? onChanged;
  final double? min;
  final double? max;
  final int? divisions;
  final String? label;
  final double? initialValue;
  final bool enabled;

  @override
  State<_Slider> createState() => __SliderState();
}

class __SliderState extends State<_Slider> {
  FormFieldState<double> get field => widget.field;

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
    final hasError = field.hasError;
    final errorText = field.errorText;
    final min = widget.min ?? 0.0;
    final max = widget.max ?? 1.0;
    return LayoutComponent.column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.label != null)
          FormFieldLabel(
            "${widget.label!} (${field.value?.toStringAsFixed(2) ?? 0})",
            hasError: hasError,
          )
        else
          FormFieldLabel(
            "${field.value?.toStringAsFixed(2) ?? 0}",
            hasError: hasError,
          ),
        LayoutComponent.row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: DisabledComponent(
                isDisabled: !widget.enabled,
                child: Slider(
                  value: field.value ?? 0.0,
                  label: field.value?.toStringAsFixed(2),
                  min: min,
                  max: max,
                  onChanged:
                      widget.enabled
                          ? (value) {
                            field.didChange(value);
                            widget.onChanged?.call(value);
                          }
                          : null,
                  thumbColor:
                      hasError ? Colors.red : field.context.colorScheme.primary,
                  activeColor: hasError ? Colors.red : null,
                ),
              ),
            ),
            // Text(
            //   (field.value ?? 0.0).toStringAsFixed(2),
            //   style: field.context.textTheme.titleSmall,
            // ),
          ],
        ),
        if (hasError) FormFieldErrorText(errorText!),
      ],
    );
  }
}
