import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:myspace_core/myspace_core.dart';

typedef UIPageBuilder =
    Widget Function(BuildContext context, GoRouterState state, Vm? vm);

typedef UIVmProvider = Vm Function(BuildContext context);

abstract class UIRoute {
  final String name;
  final String path;
  final bool forceRebuild;
  final UIPageBuilder builder;
  final UIVmProvider? vm;
  final GoRouterRedirect? redirect;
  final List<UIRoute> pages;

  const UIRoute({
    required this.name,
    required this.path,
    required this.builder,
    this.vm,
    this.redirect,
    this.pages = const [],

    ///enforces rebuild on each navigation
    this.forceRebuild = false,
  });

  GoRoute toRoute();
}

class UIPage extends UIRoute {
  const UIPage({
    required super.name,
    required super.path,
    required super.builder,
    super.vm,
    super.redirect,
    super.pages,

    ///enforces rebuild on each navigation
    super.forceRebuild = false,
  });

  @override
  GoRoute toRoute() {
    // if (!path.startsWith("/")) {
    //   throw Exception('Name: ($name), Path: ($path) must start with slash(/)');
    // }
    return GoRoute(
      path: path,
      name: name,
      redirect: redirect,
      routes: [for (final subPage in pages) subPage.toRoute()],
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

class UIDialog extends UIRoute {
  final bool barrierDismissible;

  const UIDialog({
    required super.name,
    required super.path,
    required super.builder,
    super.vm,
    super.redirect,
    super.pages,

    ///enforces rebuild on each navigation
    super.forceRebuild = false,
    this.barrierDismissible = true,
  });

  @override
  GoRoute toRoute() {
    // if (!path.startsWith("/")) {
    //   throw Exception('Name: ($name), Path: ($path) must start with slash(/)');
    // }
    return GoRoute(
      path: path,
      name: name,
      redirect: redirect,
      routes: [for (final subPage in pages) subPage.toRoute()],
      pageBuilder: (context, state) {
        return _DialogPage(
          name: name,
          key: state.pageKey,
          builder:
              (context) => _Page(
                key: forceRebuild ? UniqueKey() : null,
                vm: vm,
                child: (vm) => builder(context, state, vm),
              ),
        );
      },
    );
  }
}

//https://croxx5f.hashnode.dev/adding-modal-routes-to-your-gorouter
class _DialogPage<T> extends Page<T> {
  final Offset? anchorPoint;
  final Color? barrierColor;
  final bool barrierDismissible;
  final String? barrierLabel;
  final bool useSafeArea;
  final CapturedThemes? themes;
  final WidgetBuilder builder;

  const _DialogPage({
    required this.builder,
    this.anchorPoint,
    this.barrierColor = Colors.black54,
    this.barrierDismissible = true,
    this.barrierLabel,
    this.useSafeArea = true,
    this.themes,
    super.key,
    super.name,
    super.arguments,
    super.restorationId,
  });

  @override
  Route<T> createRoute(BuildContext context) => DialogRoute<T>(
    context: context,
    settings: this,
    builder: builder,
    anchorPoint: anchorPoint,
    barrierColor: barrierColor,
    barrierDismissible: barrierDismissible,
    barrierLabel: barrierLabel,
    useSafeArea: useSafeArea,
    themes: themes,
  );
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