import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

extension BuildContextHelpers on BuildContext {
  bool isMobilePlatform() {
    return Theme.of(this).platform == TargetPlatform.android ||
        Theme.of(this).platform == TargetPlatform.iOS;
  }

  RelativeRect getTapPosition(TapDownDetails details) {
    final RenderBox overlay =
        Overlay.of(this).context.findRenderObject() as RenderBox;

    final RelativeRect position = RelativeRect.fromRect(
      Rect.fromPoints(
        details.globalPosition,
        details.globalPosition + const Offset(0, -20),
      ),
      Offset.zero & overlay.size,
    );
    return position;
  }

  String? get fullRoutePath => GoRouterState.of(this).fullPath;

  bool get isDarkMode =>
      MediaQuery.platformBrightnessOf(this) == Brightness.dark;
  bool get isLightMode =>
      MediaQuery.platformBrightnessOf(this) == Brightness.light;

  void unfocus() {
    FocusScope.of(this).unfocus();
  }

  //show a snackbar with a message
  void showSnackbar(String message) {
    ScaffoldMessenger.of(this).showSnackBar(SnackBar(content: Text(message)));
  }

  void popOr([String? path]) {
    if (canPop()) {
      pop();
    } else if (path != null) {
      go(path);
    }
  }
}
