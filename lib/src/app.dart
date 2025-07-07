import 'dart:developer';
import 'package:bot_toast/bot_toast.dart' as toast;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'app_theme.dart';

class UIApp extends StatelessWidget {
  const UIApp({
    super.key,
    required this.routerConfig,
    this.theme,
    this.themeMode,
    this.builder,
    this.localizationsDelegates,
    this.supportedLocales,
    this.locale,
  });

  final GoRouter routerConfig;
  final AppTheme Function(BuildContext context)? theme;
  final ThemeMode Function(BuildContext context)? themeMode;
  final TransitionBuilder? builder;
  final Iterable<LocalizationsDelegate<dynamic>>? localizationsDelegates;
  final Iterable<Locale>? supportedLocales;
  final Locale? locale;

  @override
  Widget build(BuildContext context) {
    final toastBuilder = toast.BotToastInit();
    log('Build UIApp');
    final appTheme = theme?.call(context) ?? MySpaceTheme();
    final themeMode = this.themeMode?.call(context) ?? ThemeMode.system;
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: routerConfig,
      theme: appTheme.lightTheme,
      darkTheme: appTheme.darkTheme,
      themeMode: themeMode,
      localizationsDelegates: localizationsDelegates,
      supportedLocales: supportedLocales ?? const <Locale>[Locale('en', 'US')],
      locale: locale,
      builder: (context, child) {
        if (builder != null) {
          child = builder!(context, child);
        }
        child = toastBuilder(context, child);
        return child;
      },
    );
  }
}
