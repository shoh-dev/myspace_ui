import 'dart:async';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';

class ErrorDialog extends StatelessWidget {
  const ErrorDialog({
    super.key,
    this.title,
    required this.content,
    this.actionText,
    this.actionCallback,
    this.platform,
  });

  final String? title;
  final String content;
  final String? actionText;
  final VoidCallback? actionCallback;
  final TargetPlatform? platform;

  @override
  Widget build(BuildContext context) {
    final isAndroid = true;
    // platform != null
    // ? platform == TargetPlatform.android
    // : Theme.of(context).platform == TargetPlatform.android;
    if (isAndroid) {
      return PointerInterceptor(
        child: AlertDialog(
          title: Text(title ?? "Error"),
          content: Text(content),
          actions: [
            if (actionCallback != null && actionText != null)
              TextButton(onPressed: actionCallback, child: Text(actionText!)),
          ],
        ),
      );
    }
    return PointerInterceptor(
      child: CupertinoAlertDialog(
        title: Text(title ?? "Error"),
        content: Text(content),
        actions: [
          if (actionCallback != null && actionText != null)
            CupertinoDialogAction(
              onPressed: actionCallback,
              child: Text(actionText!),
            ),
        ],
      ),
    );
  }

  static Future<void> show(
    String error, {
    String? title,
    bool dismissable = true,
    void Function(CancelFunc close)? onClose,
    String? actionText,
    TargetPlatform? platform,
  }) {
    final completer = Completer<Null>();

    BotToast.showEnhancedWidget(
      backgroundColor: Colors.black54,
      clickClose: dismissable,
      allowClick: false,
      onlyOne: true,
      backButtonBehavior: BackButtonBehavior.ignore,
      onClose: () {
        if (!completer.isCompleted) {
          completer.complete();
        }
      },
      toastBuilder: (cancelFunc) => ErrorDialog(
        platform: platform,
        title: title,
        content: error,
        actionText: actionText ?? "Close",
        actionCallback: onClose != null
            ? () {
                completer.complete();
                onClose(cancelFunc);
              }
            : () {
                completer.complete();
                cancelFunc();
              },
      ),
    );

    return completer.future;
  }
}
