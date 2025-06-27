import 'dart:async';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SuccessDialog extends StatelessWidget {
  const SuccessDialog({
    super.key,
    this.title,
    required this.content,
    required this.onClose,
  });

  final String? title;
  final String content;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    final isAndroid = Theme.of(context).platform == TargetPlatform.android;
    if (isAndroid) {
      return AlertDialog(
        title: Text(title ?? "Success"),
        content: Text(content),
        actions: [TextButton(onPressed: onClose, child: Text('Close'))],
      );
    }
    return CupertinoAlertDialog(
      title: Text(title ?? "Success"),
      content: Text(content),
      actions: [
        CupertinoDialogAction(onPressed: onClose, child: Text('Close')),
      ],
    );
  }

  static Future<void> show(
    String content, {
    String? title,
    bool dismissable = true,
    void Function(CancelFunc close)? onClose,
  }) {
    final completer = Completer<Null>();

    BotToast.showEnhancedWidget(
      backgroundColor: Colors.black38,
      clickClose: dismissable,
      allowClick: false,
      onlyOne: true,
      backButtonBehavior: BackButtonBehavior.ignore,
      onClose: () {
        if (!completer.isCompleted) {
          completer.complete();
        }
      },
      toastBuilder:
          (cancelFunc) => SuccessDialog(
            title: title,
            content: content,
            onClose:
                onClose != null
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
