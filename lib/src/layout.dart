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
  final List<List<UIPage>> pages;

  const UILayout({required this.layoutBuilder, required this.pages});

  StatefulShellRoute toShellRoute() {
    return StatefulShellRoute.indexedStack(
      builder: layoutBuilder,
      branches: [
        for (final page in pages)
          StatefulShellBranch(routes: page.map((e) => e.toRoute()).toList()),
      ],
    );
  }
}
