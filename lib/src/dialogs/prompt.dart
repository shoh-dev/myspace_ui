import 'dart:async';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myspace_ui/myspace_ui.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';

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
    this.platform,
  });

  final String? title;
  final String content;
  final String? leftButtonText;
  final String? rightButtonText;
  final void Function() onLeftClick;
  final void Function() onRightClick;
  final bool isDestructive;
  final TargetPlatform? platform;

  @override
  Widget build(BuildContext context) {
    final isAndroid = true;
    // platform != null
    // ? platform == TargetPlatform.android
    // : Theme.of(context).platform == TargetPlatform.android;
    if (isAndroid) {
      return PointerInterceptor(
        child: AlertDialog(
          title: TextComponent.any(title ?? "Attention"),
          content: TextComponent.any(content),
          actions: [
            ButtonComponent.text(
              onPressed: onLeftClick,
              text: leftButtonText ?? "No",
            ),
            ButtonComponent.text(
              onPressed: onRightClick,
              text: rightButtonText ?? "Yes",
              foregroundColor: isDestructive ? context.error : null,
            ),
          ],
        ),
      );
    }
    return PointerInterceptor(
      child: CupertinoAlertDialog(
        title: Text(title ?? "Attention"),
        content: Text(content),
        actions: [
          CupertinoDialogAction(
            onPressed: onLeftClick,
            child: Text(leftButtonText ?? "No"),
          ),
          CupertinoDialogAction(
            onPressed: onRightClick,
            isDestructiveAction: isDestructive,
            child: Text(rightButtonText ?? "Yes"),
          ),
        ],
      ),
    );
  }

  static Future<bool?> show(
    String content, {
    String? title,
    String? leftButtonText,
    String? rightButtonText,
    FutureOr Function(CancelFunc close)? onLeftClick,
    required FutureOr<void> Function(CancelFunc close) onRightClick,
    bool dismissable = false,
    bool isDestructive = false,
    TargetPlatform? platform,
  }) {
    final completer = Completer<bool?>();
    BotToast.showEnhancedWidget(
      backgroundColor: Colors.black54,
      clickClose: dismissable,
      allowClick: false,
      onlyOne: true,
      backButtonBehavior: BackButtonBehavior.ignore,
      onClose: () {
        if (!completer.isCompleted) {
          completer.complete(null);
        }
      },
      toastBuilder: (cancelFunc) => PromptDialog(
        platform: platform,
        title: title,
        content: content,
        isDestructive: isDestructive,
        onLeftClick: () async {
          if (onLeftClick != null) {
            await onLeftClick(cancelFunc);
          } else {
            cancelFunc();
          }
          completer.complete(false);
        },
        onRightClick: () async {
          await onRightClick(cancelFunc);
          completer.complete(true);
        },
        rightButtonText: rightButtonText,
        leftButtonText: leftButtonText,
      ),
    );
    return completer.future;
  }
}
