import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myspace_ui/myspace_ui.dart';
import 'package:myspace_ui/src/components/shared/disabled_component.dart';

class TextFieldComponent extends FormField<String> {
  TextFieldComponent({
    super.key,
    String? initialValue,
    super.enabled,
    super.validator,
    super.onSaved,
    super.autovalidateMode,
    ValueChanged<String>? onChanged,
    String? hintText,
    String? label,
    bool canClear = false,
    int? maxLines,
    TextEditingController? controller,
    List<Widget> Function(String query)? suffixWidgets,
    bool autoFocus = false,
    TapRegionCallback? onTapOutside,
    TextInputType? keyboardType,
    TextInputAction? textInputAction,
    bool? readOnly,
    VoidCallback? onTap,
    bool obscureText = false,
    int? maxLength,
  }) : super(
         initialValue: initialValue ?? controller?.text,
         builder: (field) {
           return _Field(
             controller: controller,
             onTapOutside: onTapOutside,
             field: field,
             onChanged: onChanged,
             hintText: hintText,
             label: label,
             canClear: canClear,
             enabled: enabled,
             validator: validator,
             onSaved: onSaved,
             maxLines: maxLines,
             suffixWidgets: suffixWidgets,
             autofocus: autoFocus,
             keyboardType: keyboardType,
             textInputAction: textInputAction,
             onTap: onTap,
             readOnly: readOnly ?? false,
             obscureText: obscureText,
             maxLength: maxLength,
           );
         },
       );

  @override
  FormFieldState<String> createState() => _FieldComponentState();
}

class _FieldComponentState extends FormFieldState<String> {
  @override
  void initState() {
    super.initState();
    if (widget.initialValue != null) {
      setValue(widget.initialValue);
    }
  }
}

class _Field extends StatefulWidget {
  const _Field({
    required this.field,
    this.canClear = false,
    required this.enabled,
    this.hintText,
    this.label,
    this.onChanged,
    this.initialValue,
    this.validator,
    this.onSaved,
    this.maxLines,
    this.controller,
    this.suffixWidgets,
    this.onTapOutside,
    required this.autofocus,
    this.keyboardType,
    this.textInputAction,
    this.readOnly = false,
    this.onTap,
    this.obscureText = false,
    this.maxLength,
  });

  final FormFieldState<String> field;
  final ValueChanged<String>? onChanged;
  final TapRegionCallback? onTapOutside;
  final String? hintText;
  final String? label;
  final bool canClear;
  final bool enabled;
  final String? initialValue;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onSaved;
  final int? maxLines;
  final TextEditingController? controller;
  final List<Widget> Function(String query)? suffixWidgets;
  final bool autofocus;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final bool readOnly;
  final VoidCallback? onTap;
  final bool obscureText;
  final int? maxLength;

  @override
  State<_Field> createState() => __FieldState();
}

class __FieldState extends State<_Field> {
  FormFieldState<String> get field => widget.field;
  late final TextEditingController _controller;

  @override
  void dispose() {
    if (widget.controller == null) _controller.dispose();
    super.dispose();
  }

  bool get canShowResetButton {
    return widget.canClear && _controller.text.isNotEmpty && widget.enabled;
  }

  @override
  void initState() {
    _controller = widget.controller ?? TextEditingController();
    _controller.text = widget.initialValue ?? widget.controller?.text ?? "";
    _controller.addListener(() {
      if (mounted) {
        field.didChange(_controller.text);
        if (widget.canClear) {
          setState(() {});
        }
      }
    });
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {});
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
          TextField(
            obscureText: widget.obscureText,
            readOnly: widget.readOnly,
            onTap: widget.onTap,
            autofocus: widget.autofocus,
            controller: _controller,
            maxLines: widget.maxLines,
            maxLength: widget.maxLength,
            onChanged: (value) {
              field.didChange(value);
              widget.onChanged?.call(value);
            },
            onTapOutside: widget.onTapOutside,
            keyboardType: widget.keyboardType,
            textInputAction: widget.textInputAction,
            decoration: InputDecoration(
              errorText: field.errorText,
              hintText: widget.hintText,
              counterText: widget.maxLength != null ? "" : null,
              suffixIcon: !widget.enabled
                  ? null
                  : widget.suffixWidgets != null
                  ? Transform.scale(
                      scale: .8,
                      alignment: Alignment.centerRight,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          for (var icon in widget.suffixWidgets!(
                            _controller.text,
                          ))
                            icon,
                          if (canShowResetButton)
                            ButtonComponent.iconOutlined(
                              icon: Icon(Icons.clear_rounded),
                              onPressed: _controller.text.isEmpty
                                  ? null
                                  : () => reset(field.context),
                            ),
                          const SizedBox(width: 6),
                        ],
                      ),
                    )
                  : null,
            ),
            enabled: widget.enabled,
          ),
        ],
      ),
    );
  }

  void reset(BuildContext context) {
    field.reset();
    widget.onChanged?.call("");
    _controller.clear();
    FocusScope.of(context).unfocus();
  }
}
