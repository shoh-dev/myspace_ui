import 'package:flutter/material.dart';

extension WidgetHelpers on Widget {
  Widget sized({double? width, double? height}) {
    return SizedBox(width: width, height: height, child: this);
  }
}
