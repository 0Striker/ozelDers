import 'package:flutter/material.dart';

ThemeData buildLightTheme() {
  final ColorScheme colorScheme = ColorScheme.fromSeed(seedColor: const Color(0xFF005BBB));
  return ThemeData(
    colorScheme: colorScheme,
    useMaterial3: true,
    scaffoldBackgroundColor: colorScheme.surface,
    appBarTheme: AppBarTheme(
      backgroundColor: colorScheme.surface,
      foregroundColor: colorScheme.onSurface,
      elevation: 0,
      centerTitle: false,
    ),
  );
}

ThemeData buildDarkTheme() {
  final ThemeData base = ThemeData.dark(useMaterial3: true);
  return base.copyWith(
    colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF005BBB), brightness: Brightness.dark),
  );
}


