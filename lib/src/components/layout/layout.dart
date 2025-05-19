import 'package:flutter/material.dart';

import 'types/column.dart';
import 'types/row.dart';
import 'types/stack.dart';
import 'types/wrap.dart';

abstract class LayoutComponent extends StatelessWidget {
  const LayoutComponent({
    super.key,
    required this.children,
    this.spacing,
    this.mainAxisAlignment,
    this.crossAxisAlignment,
    this.mainAxisSize,
  });

  final List<Widget> children;
  final double? spacing;
  final MainAxisAlignment? mainAxisAlignment;
  final CrossAxisAlignment? crossAxisAlignment;
  final MainAxisSize? mainAxisSize;

  const factory LayoutComponent.row({
    required final List<Widget> children,
    double? spacing,
    MainAxisAlignment? mainAxisAlignment,
    CrossAxisAlignment? crossAxisAlignment,
    MainAxisSize? mainAxisSize,
  }) = RowComponent;

  const factory LayoutComponent.column({
    required final List<Widget> children,
    double? spacing,
    MainAxisAlignment? mainAxisAlignment,
    CrossAxisAlignment? crossAxisAlignment,
    MainAxisSize? mainAxisSize,
  }) = ColumnComponent;

  /// Not finished yet
  const factory LayoutComponent.stack({required final List<Widget> children}) =
      StackComponent;

  const factory LayoutComponent.wrap({
    required final List<Widget> children,
    double? spacing,
  }) = WrapComponent;
}
