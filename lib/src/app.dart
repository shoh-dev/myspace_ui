import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:myspace_design_system/myspace_design_system.dart';

class UIApp extends StatelessWidget {
  const UIApp({
    super.key,
    required this.routerConfig,
    this.theme,
    this.themeMode,
  });

  final GoRouter routerConfig;
  final AppTheme Function(BuildContext context)? theme;
  final ThemeMode Function(BuildContext context)? themeMode;

  @override
  Widget build(BuildContext context) {
    log('Build UIApp');
    final appTheme = theme?.call(context) ?? AppTheme();
    final themeMode = this.themeMode?.call(context) ?? ThemeMode.system;
    return MaterialApp.router(
      routerConfig: routerConfig,
      theme: appTheme.lightTheme,
      darkTheme: appTheme.darkTheme,
      themeMode: themeMode,
      builder: BotToastInit(),
    );
  }
}
