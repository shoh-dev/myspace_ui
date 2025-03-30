import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';

class SuccessDialog extends StatelessWidget {
  const SuccessDialog({
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
      title: Text(title ?? "Success"),
      content: Text(content),
      actions: [TextButton(onPressed: cancel, child: Text('Close'))],
    );
  }

  static CancelFunc show(
    String info, {
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
              SuccessDialog(title: title, content: info, cancel: cancelFunc),
    );
  }
}
