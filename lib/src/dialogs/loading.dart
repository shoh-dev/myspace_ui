import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';

class LoadingDialog extends StatelessWidget {
  const LoadingDialog({super.key, this.title, this.platform});

  final String? title;
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
          title: title != null ? Text(title!) : null,
          content: SizedBox.fromSize(
            size: Size.fromHeight(64),
            child: Center(child: CircularProgressIndicator()),
          ),
        ),
      );
    }
    return PointerInterceptor(
      child: CupertinoAlertDialog(
        title: title != null ? Text(title!) : null,
        content: SizedBox.fromSize(
          size: Size.fromHeight(32),
          child: CupertinoActivityIndicator(),
        ),
      ),
    );
  }

  static CancelFunc show({
    String? title,
    bool dismissable = false,
    TargetPlatform? platform,
  }) {
    return BotToast.showCustomLoading(
      backgroundColor: Colors.black38,
      clickClose: dismissable,
      allowClick: false,
      backButtonBehavior: BackButtonBehavior.ignore,
      toastBuilder: (cancelFunc) =>
          LoadingDialog(platform: platform, title: title ?? "Loading..."),
    );
  }
}
