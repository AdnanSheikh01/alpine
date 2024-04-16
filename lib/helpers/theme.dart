import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    colorScheme: const ColorScheme.light(
        background: Colors.white,
        primary: Colors.black,
        secondary: Colors.black54),
    textTheme: const TextTheme(bodyLarge: TextStyle(color: Colors.white)));

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  colorScheme: const ColorScheme.dark(
      background: Colors.black,
      primary: Colors.white,
      secondary: Colors.white54),
);
