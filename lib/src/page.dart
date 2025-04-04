import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:myspace_core/myspace_core.dart';

typedef UIPageBuilder =
    Widget Function(BuildContext context, GoRouterState state, Vm? vm);

typedef UIVmProvider = Vm Function(BuildContext context);

class UIPage {
  final String name;
  final String path;
  final bool forceRebuild;
  final UIPageBuilder builder;
  final UIVmProvider? vm;
  final GoRouterRedirect? redirect;

  const UIPage({
    required this.name,
    required this.path,
    required this.builder,
    this.vm,
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
      builder: (context, state) {
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
  const _Page({super.key, required this.child, this.vm});

  final UIVmProvider? vm;
  final Widget Function(Vm? vm) child;

  @override
  State<_Page> createState() => _PageState();
}

class _PageState extends State<_Page> {
  Vm? vm;
  bool isVmLoaded = false;

  @override
  void dispose() {
    if (vm != null && vm!.isDisposed == false) {
      vm!.dispose();
      log('Disposed VM from _Page');
    }
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.vm != null) {
        vm = widget.vm!(context);
      }
      setState(() {
        isVmLoaded = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) =>
      isVmLoaded ? widget.child(vm) : const SizedBox.shrink();
}


 // pageBuilder: (context, state) {
      //   return MaterialPage(
      //     key: state.pageKey,
      //     child: _Page(
      //       key: forceRebuild ? UniqueKey() : null,
      //       vm: vm,
      //       child: (vm) => builder(context, state, vm),
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
      //             onLeftClick: () {
      //               Navigator.pop(context, false);
      //             },
      //             onRightClick: () {
      //               Navigator.pop(context, true);
      //             },
      //           );
      //         },
      //       )) ??
      //       false;
      // }, //todo: can show do you want to exit dialog