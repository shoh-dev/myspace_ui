import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:myspace_ui/myspace_ui.dart';

class PromptDialog extends StatelessWidget {
  const PromptDialog({
    super.key,
    this.title,
    required this.content,
    this.leftButtonText,
    this.rightButtonText,
    required this.onLeftClick,
    required this.onRightClick,
    this.isDestructive = false,
  });

  final String? title;
  final String content;
  final String? leftButtonText;
  final String? rightButtonText;
  final void Function() onLeftClick;
  final void Function() onRightClick;
  final bool isDestructive;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: TextComponent.any(title ?? "Attention"),
      content: TextComponent.any(content),
      actions: [
        ButtonComponent.text(
          onPressed: onLeftClick,
          text: leftButtonText ?? "No",
        ),
        if (!isDestructive)
          ButtonComponent.text(
            onPressed: onRightClick,
            text: rightButtonText ?? "Yes",
          )
        else
          ButtonComponent.destructive(
            onPressed: onRightClick,
            text: rightButtonText ?? "Yes",
          ),
      ],
    );
  }

  static CancelFunc show(
    String content, {
    String? title,
    String? leftButtonText,
    String? rightButtonText,
    void Function(CancelFunc close)? onLeftClick,
    required void Function(CancelFunc close) onRightClick,
    bool dismissable = false,
    bool isDestructive = false,
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
            isDestructive: isDestructive,
            onLeftClick:
                onLeftClick != null
                    ? () => onLeftClick(cancelFunc)
                    : () => cancelFunc(),
            onRightClick: () => onRightClick(cancelFunc),
            rightButtonText: rightButtonText,
            leftButtonText: leftButtonText,
          ),
    );
  }
}
