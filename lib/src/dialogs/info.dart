import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';

class InfoDialog extends StatelessWidget {
  const InfoDialog({
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
      title: Text(title ?? "Info"),
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
              InfoDialog(title: title, content: info, cancel: cancelFunc),
    );
  }
}
