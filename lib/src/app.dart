import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:bot_toast/bot_toast.dart';

class UIApp extends StatelessWidget {
  const UIApp({
    super.key,
    required this.routerConfig,
    this.lightTheme,
    this.darkTheme,
    this.themeMode,
  });

  final GoRouter routerConfig;
  final ThemeData Function(BuildContext context)? lightTheme;
  final ThemeData Function(BuildContext context)? darkTheme;
  final ThemeMode Function(BuildContext context)? themeMode;

  @override
  Widget build(BuildContext context) {
    print('Build UIApp');
    return MaterialApp.router(
      routerConfig: routerConfig,
      theme: lightTheme?.call(context),
      darkTheme: darkTheme?.call(context),
      themeMode: themeMode?.call(context),
      builder: BotToastInit(),
    );
  }
}
