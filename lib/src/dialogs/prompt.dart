import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';

class PromptDialog extends StatelessWidget {
  const PromptDialog({
    super.key,
    this.title,
    required this.content,
    this.leftButtonText,
    this.rightButtonText,
    required this.cancel,
    required this.onLeftClick,
    required this.onRightClick,
  });

  final String? title;
  final String content;
  final CancelFunc cancel;
  final String? leftButtonText;
  final String? rightButtonText;
  final void Function(CancelFunc cancel) onLeftClick;
  final void Function(CancelFunc cancel) onRightClick;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title ?? "Prompt"),
      content: Text(content),
      actions: [
        TextButton(
          onPressed: () => onLeftClick(cancel),
          child: Text(leftButtonText ?? "No"),
        ),
        TextButton(
          onPressed: () => onRightClick(cancel),
          child: Text(rightButtonText ?? "Yes"),
        ),
      ],
    );
  }

  static CancelFunc show(
    String content, {
    String? title,
    final String? leftButtonText,
    final String? rightButtonText,
    required final void Function(CancelFunc cancel) onLeftClick,
    required final void Function(CancelFunc cancel) onRightClick,
    bool dismissable = false,
  }) {
    return BotToast.showEnhancedWidget(
      backgroundColor: Colors.black38,
      clickClose: dismissable,
      allowClick: false,
      onlyOne: true,
      backButtonBehavior: BackButtonBehavior.ignore,
      toastBuilder:
          (cancelFunc) => PromptDialog(
            title: title,
            content: content,
            onLeftClick: onLeftClick,
            onRightClick: onRightClick,
            rightButtonText: rightButtonText,
            leftButtonText: leftButtonText,
            cancel: cancelFunc,
          ),
    );
  }
}
