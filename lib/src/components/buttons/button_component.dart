import 'package:flutter/material.dart';

import 'types/outlined.dart';
import 'types/icon.dart';
import 'types/primary.dart';
import 'types/text.dart';
import 'types/destructive.dart';

extension ButtonComponentHelper on ButtonComponent {
  Widget expanded([double? height]) =>
      SizedBox(width: double.infinity, height: height, child: this);
}

abstract class ButtonComponent extends StatelessWidget {
  const ButtonComponent({
    super.key,
    this.onPressed,
    this.text,
    this.icon,
    this.backgroundColor,
    this.fontSize,
    this.foregroundColor,
    this.iconSize,
    this.padding,
    this.elevation,
    this.shadowColor,
    this.isLoading = false,
    this.style,
  });

  final VoidCallback? onPressed;
  final String? text;
  final Widget? icon;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? shadowColor;
  final double? iconSize;
  final double? fontSize;
  final EdgeInsets? padding;
  final double? elevation;
  final bool isLoading;
  final TextStyle? style;

  const factory ButtonComponent.outlined({
    VoidCallback? onPressed,
    required String text,
    Widget? icon,
    Color? foregroundColor,
  }) = OutlinedButtonComponent;

  const factory ButtonComponent.primary({
    VoidCallback? onPressed,
    required String text,
    Widget? icon,
    bool isLoading,
  }) = PrimaryButtonComponent;

  const factory ButtonComponent.text({
    VoidCallback? onPressed,
    required String text,
    Widget? icon,
    TextStyle? style,
    EdgeInsets? padding,
    Color? foregroundColor,
  }) = TextButtonComponent;

  const factory ButtonComponent.icon({
    VoidCallback? onPressed,
    required Widget icon,
    String? tooltip,
    Color? backgroundColor,
    Color? foregroundColor,
    Color? shadowColor,
    double? iconSize,
    EdgeInsets? padding,
    double? elevation,
  }) = IconButtonComponent;

  const factory ButtonComponent.destructive({
    VoidCallback? onPressed,
    required String text,
    Widget? icon,
  }) = DestructiveButtonComponent;

  const factory ButtonComponent.iconOutlined({
    VoidCallback? onPressed,
    required Widget icon,
    String? tooltip,
  }) = IconButtonComponentOutlined;

  const factory ButtonComponent.iconDesctructive({
    VoidCallback? onPressed,
    required Widget icon,
    String? tooltip,
  }) = IconButtonComponentDesctructive;

  const factory ButtonComponent.iconPrimary({
    VoidCallback? onPressed,
    required Widget icon,
    String? tooltip,
  }) = IconButtonComponentPrimary;
}
