import 'package:flutter/material.dart';

ThemeData theme() {
  return ThemeData(
    scaffoldBackgroundColor: Colors.white,
    fontFamily: 'Ariel',
    textTheme: textTheme(),
  );
}

TextTheme textTheme() {
  return const TextTheme(
      displayLarge: TextStyle(
        color: Colors.blue,
        fontSize: 32,
        fontWeight: FontWeight.bold,
      ),
      displayMedium: TextStyle(
        color: Colors.blue,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
      displaySmall: TextStyle(
        color: Colors.blue,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
      headlineMedium: TextStyle(
        color: Colors.blue,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
      headlineSmall: TextStyle(
        color: Colors.blue,
        fontSize: 14,
        fontWeight: FontWeight.bold,
      ),
      titleLarge: TextStyle(
        color: Colors.blue,
        fontSize: 14,
        fontWeight: FontWeight.normal,
      ),
      bodyLarge: TextStyle(
        color: Colors.blue,
        fontSize: 12,
        fontWeight: FontWeight.normal,
      ),
      bodyMedium: TextStyle(
        color: Colors.blue,
        fontSize: 10,
        fontWeight: FontWeight.normal,
      ));
}
