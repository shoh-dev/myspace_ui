import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:myspace_ui/src/layout.dart';

export 'layout.dart';

class UIRoot {
  final List<UILayout> layouts;
  final GoRouterRedirect? redirect;

  const UIRoot({required this.layouts, this.redirect});

  GoRouter toRouter() {
    return GoRouter(
      debugLogDiagnostics: kDebugMode,
      redirect: redirect,
      observers: [BotToastNavigatorObserver()],
      routes: [for (final layout in layouts) layout.toShellRoute()],
    );
  }
}
