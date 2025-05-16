import 'package:flutter/material.dart';
import 'package:myspace_ui/myspace_ui.dart';

class ColumnComponent extends LayoutComponent {
  const ColumnComponent({
    super.key,
    required super.children,
    super.spacing,
    super.mainAxisAlignment,
    super.crossAxisAlignment,
    super.mainAxisSize,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      key: key,
      mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.start,
      crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.start,
      mainAxisSize: mainAxisSize ?? MainAxisSize.max,
      spacing: spacing ?? 0.0,
      children: children,
    );
  }
}
