import 'dart:async';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myspace_ui/myspace_ui.dart';
import 'package:myspace_ui/src/helpers/string.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';

class InfoDialog extends StatelessWidget {
  const InfoDialog({
    super.key,
    this.title,
    this.content,
    required this.onClose,
    this.platform,
  });

  final String? title;
  final String? content;
  final VoidCallback onClose;
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
          title: Text(title ?? "Info"),
          content: content.isEmptyOrNull ? null : Text(content!),
          actions: [ButtonComponent.text(onPressed: onClose, text: 'Close')],
        ),
      );
    }
    return PointerInterceptor(
      child: CupertinoAlertDialog(
        title: Text(title ?? "Info"),
        content: content.isEmptyOrNull ? null : Text(content!),
        actions: [
          CupertinoDialogAction(onPressed: onClose, child: Text('Close')),
        ],
      ),
    );
  }

  static Future<void> show({
    String? info,
    String? title,
    bool dismissable = true,
    void Function(CancelFunc close)? onClose,
    TargetPlatform? platform,
  }) {
    final completer = Completer<Null>();
    BotToast.showEnhancedWidget(
      backgroundColor: Colors.black38,
      clickClose: dismissable,
      allowClick: false,
      onlyOne: true,
      backButtonBehavior: BackButtonBehavior.ignore,
      onClose: () {
        if (!completer.isCompleted) {
          completer.complete();
        }
      },
      toastBuilder: (cancelFunc) => InfoDialog(
        platform: platform,
        title: title,
        content: info,
        onClose: onClose != null
            ? () {
                completer.complete();
                onClose(cancelFunc);
              }
            : () {
                completer.complete();
                cancelFunc();
              },
      ),
    );

    return completer.future;
  }
}
