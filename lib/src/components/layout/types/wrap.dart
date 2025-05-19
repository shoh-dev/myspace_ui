import 'package:myspace_ui/myspace_ui.dart';
import 'package:flutter/material.dart';

class WrapComponent extends LayoutComponent {
  const WrapComponent({super.key, required super.children, super.spacing});

  @override
  Widget build(BuildContext context) {
    return Wrap(key: key, spacing: spacing ?? 0.0, children: children);
  }
}
