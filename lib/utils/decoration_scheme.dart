import 'package:flutter/material.dart';

class DecorationScheme {
  static ThemeData theme = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
    useMaterial3: true,
    scaffoldBackgroundColor: Colors.indigo[100],
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.indigo[100],
    ),
    inputDecorationTheme: const InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: Colors.deepPurple,
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: Colors.deepPurple,
      ),
    ),
  );
}
