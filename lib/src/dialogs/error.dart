import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';

class ErrorDialog extends StatelessWidget {
  const ErrorDialog({
    super.key,
    this.title,
    required this.content,
    required this.cancel,
  });

  final String? title;
  final String content;
  final CancelFunc cancel;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title ?? "Error"),
      content: Text(content),
      actions: [TextButton(onPressed: cancel, child: Text('Close'))],
    );
  }

  static CancelFunc show(
    String error, {
    String? title,
    bool dismissable = true,
  }) {
    return BotToast.showEnhancedWidget(
      backgroundColor: Colors.black38,
      clickClose: dismissable,
      allowClick: false,
      onlyOne: true,
      backButtonBehavior: BackButtonBehavior.ignore,
      toastBuilder:
          (cancelFunc) =>
              ErrorDialog(title: title, content: error, cancel: cancelFunc),
    );
  }
}
