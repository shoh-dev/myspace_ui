import 'dart:async';
import 'dart:developer';

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
      pageBuilder: (context, state) {
        final vm = this.vm(context);
        return MaterialPage(
          key: state.pageKey,
          child: _Page(
            key: forceRebuild ? UniqueKey() : null,
            vm: vm,
            child: builder(context, state, vm),
          ),
        );
      },
      // onExit: (context, state) {}, //todo: can show do you want to exit dialog
      // builder: (context, state) {
      // final vm = this.vm(context);
      // return _Page(
      // key: forceRebuild ? UniqueKey() : null,
      // vm: vm,
      // child: builder(context, state, vm),
      // );
      // },
    );
  }
}

class _Page extends StatefulWidget {
  const _Page({super.key, required this.child, required this.vm});

  final Widget child;
  final Vm vm;

  @override
  State<_Page> createState() => _PageState();
}

class _PageState extends State<_Page> {
  @override
  void dispose() {
    if (!widget.vm.isDisposed) {
      widget.vm.dispose();
      log('Disposed VM from _Page for ${widget.child}');
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
