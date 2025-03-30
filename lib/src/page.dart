import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:myspace_core/myspace_core.dart';

typedef UIPageBuilder =
    Widget Function(BuildContext context, GoRouterState state, Vm vm);

typedef UIVmProvider = Vm Function(BuildContext context);

class UIPage {
  final String name;
  final String path;
  final bool forceRebuild;
  final UIPageBuilder builder;
  final UIVmProvider vm;
  final GoRouterRedirect? redirect;

  const UIPage({
    required this.name,
    required this.path,
    required this.builder,
    required this.vm,
    this.redirect,

    ///enforces rebuild on each navigation
    this.forceRebuild = false,
  });

  GoRoute toRoute() {
    if (!path.startsWith("/")) {
      throw Exception('Name: ($name), Path: ($path) must start with slash(/)');
    }
    return GoRoute(
      path: path,
      name: name,
      redirect: redirect,
      // onExit: (context, state) {}, //todo: can show do you want to exit dialog
      builder: (context, state) {
        return _Page(
          key: forceRebuild ? UniqueKey() : null,
          child: builder(context, state, vm(context)),
        );
      },
    );
  }
}

class _Page extends StatelessWidget {
  const _Page({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) => child;
}
