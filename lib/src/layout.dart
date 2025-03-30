import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:myspace_ui/src/page.dart';

export 'page.dart';

typedef UILayoutBuilder =
    Widget Function(
      BuildContext context,
      GoRouterState state,
      StatefulNavigationShell shell,
    );

class UILayout {
  final UILayoutBuilder layoutBuilder;
  final GoRouterRedirect? redirect;
  final List<List<UIPage>> pages;

  const UILayout({
    required this.layoutBuilder,
    required this.pages,
    this.redirect,
  });

  StatefulShellRoute toShellRoute() {
    return StatefulShellRoute.indexedStack(
      builder: layoutBuilder,
      redirect: redirect,
      branches: [
        for (final pages in this.pages)
          StatefulShellBranch(
            routes: [for (final page in pages) page.toRoute()],
          ),
      ],
    );
  }
}
