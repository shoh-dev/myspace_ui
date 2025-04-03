import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:myspace_core/myspace_core.dart';
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

class _Layout extends StatefulWidget {
  const _Layout({required this.child, this.vm});

  final Vm? vm;
  final Widget child;

  @override
  State<_Layout> createState() => _LayoutState();
}

class _LayoutState extends State<_Layout> {
  @override
  void dispose() {
    if (widget.vm != null && widget.vm!.isDisposed == false) {
      widget.vm!.dispose();
      log('Disposed VM from _Layout');
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
