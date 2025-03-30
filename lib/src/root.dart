import 'package:go_router/go_router.dart';
import 'package:myspace_ui/src/layout.dart';

export 'layout.dart';

class UIRoot {
  final List<UILayout> layouts;

  const UIRoot({required this.layouts});

  GoRouter toRouter() {
    return GoRouter(
      debugLogDiagnostics: true,
      routes: [for (final layout in layouts) layout.toShellRoute()],
    );
  }
}
