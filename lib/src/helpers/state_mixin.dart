import 'package:flutter/material.dart';

mixin StateHelpers<T extends StatefulWidget> on State<T> {
  void safeSetState(VoidCallback fn) {
    if (mounted) {
      setState(fn);
    }
  }

  //initState with WidgetsBinding.instance.addPostFrameCallback
  void safeInitialize(VoidCallback fn) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fn();
    });
  }

  //dispose with safe check
  void safeDispose(VoidCallback fn) {
    if (mounted) {
      fn();
    }
  }

  void safeDidUpdateWidget(VoidCallback fn) {
    if (mounted) {
      fn();
    }
  }
}
