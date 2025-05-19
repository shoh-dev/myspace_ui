import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';

class ErrorDialog extends StatelessWidget {
  const ErrorDialog({
    super.key,
    this.title,
    required this.content,
    this.actionText,
    this.actionCallback,
  });

  final String? title;
  final String content;
  final String? actionText;
  final VoidCallback? actionCallback;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title ?? "Error"),
      content: Text(content),
      actions: [
        if (actionCallback != null && actionText != null)
          TextButton(onPressed: actionCallback, child: Text(actionText!)),
      ],
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
            actionText: "Close",
            actionCallback:
                onClose != null ? () => onClose(cancelFunc) : cancelFunc,
          ),
    );
  }
}
