import 'package:go_router/go_router.dart';
import 'package:myspace_ui/myspace_ui.dart';

class UIBranch {
  final List<UIRoute> pages;

  const UIBranch({required this.pages});

  StatefulShellBranch toStatefulShellBranch() {
    return StatefulShellBranch(
      routes: [for (final page in pages) page.toRoute()],
    );
  }
}
