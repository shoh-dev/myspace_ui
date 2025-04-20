import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:myspace_core/myspace_core.dart';
import 'package:myspace_ui/src/branch.dart';

export 'page.dart';
export 'branch.dart';

class UILayout<VM extends Vm> {
  final ChangeNotifierProvider<VM> Function(
    BuildContext context,
    StatefulNavigationShell shell,
  )?
  builder;
  final StatefulShellRouteBuilder layoutBuilder;
  final GoRouterRedirect? redirect;
  final List<UIBranch> branches;

  const UILayout({
    required this.layoutBuilder,
    required this.branches,
    this.redirect,
    this.builder,
  });

  StatefulShellRoute toShellRoute() {
    return StatefulShellRoute.indexedStack(
      builder:
          builder != null
              ? (ctx, state, shell) => builder!(ctx, shell)
              : layoutBuilder,
      redirect: redirect,
      branches: [for (final branch in branches) branch.toStatefulShellBranch()],
    );
  }
}
