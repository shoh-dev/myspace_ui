import 'package:myspace_ui/myspace_ui.dart';
import 'package:flutter/material.dart';

class RowComponent extends LayoutComponent {
  const RowComponent({
    super.key,
    required super.children,
    super.spacing,
    super.mainAxisAlignment,
    super.crossAxisAlignment,
    super.mainAxisSize,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      key: key,
      mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.start,
      crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.start,
      mainAxisSize: mainAxisSize ?? MainAxisSize.max,
      spacing: spacing ?? 0.0,
      children: children,
    );
  }
}
