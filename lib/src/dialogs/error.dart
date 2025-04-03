import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';

class ErrorDialog extends StatelessWidget {
  const ErrorDialog({
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
    return AlertDialog(
      title: Text(title ?? "Error"),
      content: Text(content),
      actions: [TextButton(onPressed: onClose, child: Text('Close'))],
    );
  }

  static CancelFunc show(
    String error, {
    String? title,
    bool dismissable = true,
    void Function(CancelFunc close)? onClose,
  }) {
    return BotToast.showEnhancedWidget(
      backgroundColor: Colors.black54,
      clickClose: dismissable,
      allowClick: false,
      onlyOne: true,
      backButtonBehavior: BackButtonBehavior.ignore,
      toastBuilder:
          (cancelFunc) => ErrorDialog(
            title: title,
            content: error,
            onClose: onClose != null ? () => onClose(cancelFunc) : cancelFunc,
          ),
    );
  }
}
