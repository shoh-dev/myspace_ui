import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:myspace_core/myspace_core.dart';
import 'package:myspace_ui/myspace_ui.dart';

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
      // pageBuilder: (context, state) {
      //   return MaterialPage(
      //     key: state.pageKey,
      //     child: _Page(
      //       key: forceRebuild ? UniqueKey() : null,
      //       vm: vm,
      //                child: (vm) => builder(context, state, vm),
      //     ),
      //   );
      // },
      // onExit: (context, state) async {
      //   return (await showDialog<bool>(
      //         context: context,
      //         builder: (context) {
      //           return PromptDialog(
      //             cancel: () {},
      //             content: "Close",
      //             onLeftClick: (_) {
      //               Navigator.pop(context, false);
      //             },
      //             onRightClick: (_) {
      //               Navigator.pop(context, true);
      //             },
      //           );
      //         },
      //       )) ??
      //       false;
      // }, //todo: can show do you want to exit dialog
      builder: (context, state) {
        // final vm = this.vm(context);
        return _Page(
          key: forceRebuild ? UniqueKey() : null,
          vm: vm,
          child: (vm) => builder(context, state, vm),
        );
      },
    );
  }
}

class _Page extends StatefulWidget {
  const _Page({super.key, required this.child, required this.vm});

  final Widget Function(Vm vm) child;
  final UIVmProvider vm;

  @override
  State<_Page> createState() => _PageState();
}

class _PageState extends State<_Page> {
  late final Vm vm;
  bool isVmLoaded = false;

  @override
  void dispose() {
    if (isVmLoaded) {
      if (!vm.isDisposed) {
        vm.dispose();
        log('Disposed VM from _Page');
      }
    }
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      vm = widget.vm(context);
      setState(() {
        isVmLoaded = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) =>
      isVmLoaded ? widget.child(vm) : const SizedBox.shrink();
}
