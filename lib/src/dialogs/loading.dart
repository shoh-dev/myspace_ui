import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';

class LoadingDialog extends StatelessWidget {
  const LoadingDialog({super.key, this.title});

  final String? title;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title ?? "Loading..."),
      content: SizedBox.fromSize(
        size: Size.fromHeight(64),
        child: Center(child: CircularProgressIndicator.adaptive()),
      ),
    );
  }

  static CancelFunc show({String? title, bool dismissable = false}) {
    return BotToast.showCustomLoading(
      backgroundColor: Colors.black38,
      clickClose: dismissable,
      allowClick: false,
      backButtonBehavior: BackButtonBehavior.ignore,
      toastBuilder: (cancelFunc) => LoadingDialog(title: title),
    );
  }
}
