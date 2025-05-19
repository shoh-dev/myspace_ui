import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:myspace_ui/src/transitions.dart';

abstract class UIRoute {
  final String? name;
  final String path;
  final GoRouterRedirect? redirect;
  final List<UIRoute> pages;
  final GoRouterWidgetBuilder? builder;
  final TransitionType? transitionType;
  final Duration? transitionDuration;

  const UIRoute({
    this.name,
    this.transitionType,
    required this.path,
    this.builder,
    this.redirect,
    this.pages = const [],
    this.transitionDuration,
  });

  GoRoute toRoute();
}

class UIPage extends UIRoute {
  const UIPage({
    super.name,
    super.transitionType,
    required super.path,
    super.builder,
    super.redirect,
    super.pages,
    super.transitionDuration,
  });

  @override
  GoRoute toRoute() {
    return GoRoute(
      path: path,
      name: name,
      redirect: redirect,
      routes: [for (final subPage in pages) subPage.toRoute()],
      builder: builder,
      pageBuilder:
          builder != null && transitionType != null
              ? (context, state) {
                return CustomTransitionPage(
                  transitionDuration:
                      transitionDuration ?? const Duration(milliseconds: 300),
                  key: state.pageKey,
                  child: builder!(context, state),
                  transitionsBuilder: transitionType!.builder,
                );
              }
              : null,
      // builder: builder,
    );
  }
}

class UIDialog extends UIRoute {
  final bool barrierDismissible;

  const UIDialog({
    super.name,
    required super.path,
    required super.builder,
    super.redirect,
    super.pages,
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
                  builder: (context) => builder!(context, state),
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
