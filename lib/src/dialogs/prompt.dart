import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';

class PromptDialog extends StatelessWidget {
  const PromptDialog({
    super.key,
    this.title,
    required this.content,
    this.leftButtonText,
    this.rightButtonText,
    required this.onLeftClick,
    required this.onRightClick,
  });

  final String? title;
  final String content;
  final String? leftButtonText;
  final String? rightButtonText;
  final void Function() onLeftClick;
  final void Function() onRightClick;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title ?? "Prompt"),
      content: Text(content),
      actions: [
        TextButton(onPressed: onLeftClick, child: Text(leftButtonText ?? "No")),
        TextButton(
          onPressed: onRightClick,
          child: Text(rightButtonText ?? "Yes"),
        ),
      ],
    );
  }

  static CancelFunc show(
    String content, {
    String? title,
    String? leftButtonText,
    String? rightButtonText,
    required void Function(CancelFunc close) onLeftClick,
    required void Function(CancelFunc close) onRightClick,
    bool dismissable = false,
  }) {
    return BotToast.showEnhancedWidget(
      backgroundColor: Colors.black54,
      clickClose: dismissable,
      allowClick: false,
      onlyOne: true,
      backButtonBehavior: BackButtonBehavior.ignore,
      toastBuilder:
          (cancelFunc) => PromptDialog(
            title: title,
            content: content,
            onLeftClick: () => onLeftClick(cancelFunc),
            onRightClick: () => onRightClick(cancelFunc),
            rightButtonText: rightButtonText,
            leftButtonText: leftButtonText,
          ),
    );
  }
}
