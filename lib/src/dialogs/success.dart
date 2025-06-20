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

  static CancelFunc show(
    String info, {
    String? title,
    bool dismissable = true,
    void Function(CancelFunc close)? onClose,
  }) {
    return BotToast.showEnhancedWidget(
      backgroundColor: Colors.black38,
      clickClose: dismissable,
      allowClick: false,
      onlyOne: true,
      backButtonBehavior: BackButtonBehavior.ignore,
      toastBuilder:
          (cancelFunc) => SuccessDialog(
            title: title,
            content: info,
            onClose: onClose != null ? () => onClose(cancelFunc) : cancelFunc,
          ),
    );
  }
}
