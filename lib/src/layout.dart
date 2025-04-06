import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:myspace_ui/src/page.dart';

export 'page.dart';

abstract class LayoutStatelessWidget extends StatelessWidget {
  final StatefulNavigationShell shell;

  const LayoutStatelessWidget({super.key, required this.shell});
}

typedef UILayoutBuilder =
    Widget Function(
      BuildContext context,
      GoRouterState state,
      StatefulNavigationShell shell,
    );

class UILayout {
  final UILayoutBuilder layoutBuilder;
  final GoRouterRedirect? redirect;
  final List<List<UIRoute>> pages;

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
