import 'package:go_router/go_router.dart';

extension GoRouterStateHelpers on GoRouterState {
  Map<String, String> get queryParameters {
    return uri.queryParameters;
  }
}
