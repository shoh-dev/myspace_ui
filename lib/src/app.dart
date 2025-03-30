import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class UIApp extends StatelessWidget {
  const UIApp({super.key, required this.routerConfig});

  final GoRouter routerConfig;

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(routerConfig: routerConfig);
  }
}
