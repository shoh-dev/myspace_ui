import 'package:go_router/go_router.dart';
import 'package:myspace_ui/src/branch.dart';

export 'page.dart';
export 'branch.dart';

class UILayout {
  final StatefulShellRouteBuilder layoutBuilder;
  final GoRouterRedirect? redirect;
  final List<UIBranch> branches;

  const UILayout({
    required this.layoutBuilder,
    required this.branches,
    this.redirect,
  });

  StatefulShellRoute toShellRoute() {
    return StatefulShellRoute.indexedStack(
      builder: layoutBuilder,
      redirect: redirect,
      branches: [for (final branch in branches) branch.toStatefulShellBranch()],
    );
  }
}
