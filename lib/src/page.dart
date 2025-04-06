import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:myspace_core/myspace_core.dart';

typedef UIPageBuilder =
    Widget Function(BuildContext context, GoRouterState state, Vm? vm);

typedef UIVmProvider = Vm Function(BuildContext context, GoRouterState state);

abstract class UIRoute {
  final String? name;
  final String path;
  final bool forceRebuild;
  final UIPageBuilder? builder;
  final UIVmProvider? vm;
  final GoRouterRedirect? redirect;
  final List<UIRoute> pages;

  const UIRoute({
    this.name,
    required this.path,
    this.builder,
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
    super.name,
    required super.path,
    super.builder,
    super.vm,
    super.redirect,
    super.pages,

    ///enforces rebuild on each navigation
    super.forceRebuild = false,
  });

  @override
  GoRoute toRoute() {
    return GoRoute(
      path: path,
      name: name,
      redirect: redirect,
      routes: [for (final subPage in pages) subPage.toRoute()],
      builder:
          builder != null
              ? (context, state) {
                return _Page(
                  key: forceRebuild ? UniqueKey() : null,
                  vm: vm,
                  state: state,
                  child: (vm) => builder!(context, state, vm),
                );
              }
              : null,
    );
  }
}

class UIDialog extends UIRoute {
  final bool barrierDismissible;

  const UIDialog({
    super.name,
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
    return GoRoute(
      path: path,
      name: name,
      redirect: redirect,
      routes: [for (final subPage in pages) subPage.toRoute()],
      pageBuilder:
          builder != null
              ? (context, state) {
                return _DialogPage(
                  name: name,
                  key: state.pageKey,
                  builder:
                      (context) => _Page(
                        key: forceRebuild ? UniqueKey() : null,
                        state: state,
                        vm: vm,
                        child: (vm) => builder!(context, state, vm),
                      ),
                );
              }
              : null,
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
  const _Page({super.key, required this.child, this.vm, required this.state});

  final UIVmProvider? vm;
  final Widget Function(Vm? vm) child;
  final GoRouterState state;

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
      log('Disposed ${vm.runtimeType} from _Page');
    }
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.vm != null) {
        vm = widget.vm!(context, widget.state);
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