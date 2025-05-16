import 'package:flutter/material.dart';

extension ThemeHelpers on BuildContext {
  //theme
  ThemeData get theme => Theme.of(this);

  Color get dividerColor => theme.dividerColor;

  //text theme
  TextTheme get textTheme => theme.textTheme;

  //color scheme
  ColorScheme get colorScheme => theme.colorScheme;

  //primary color
  Color get primary => theme.colorScheme.primary;

  //secondary color
  Color get secondary => theme.colorScheme.secondary;

  //sruface color
  Color get surface => theme.colorScheme.surface;

  //error color
  Color get error => theme.colorScheme.error;

  //size
  Size get size => MediaQuery.sizeOf(this);

  //height
  double get height => size.height;

  //width
  double get width => size.width;

  //border radius
  BorderRadius get borderRadius =>
      (theme.cardTheme.shape as RoundedRectangleBorder?)?.borderRadius
          as BorderRadius? ??
      const BorderRadius.all(Radius.zero);
}
