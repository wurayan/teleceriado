import 'package:flutter/material.dart';

ThemeData theme = ThemeData(
  brightness: Brightness.dark,
  textTheme: const TextTheme(
    bodySmall: TextStyle(fontSize: 16),
    bodyMedium: TextStyle(fontSize: 16),
    bodyLarge: TextStyle(fontSize: 16),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 71, 82, 89),
          foregroundColor: const Color.fromARGB(255, 243, 243, 243),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          textStyle: const TextStyle(
            fontSize: 16,
          ))),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      textStyle: const TextStyle(fontSize: 16),
    ),
  ),
);
