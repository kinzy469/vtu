import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.pink,
    colorScheme: ColorScheme.fromSwatch().copyWith(
      secondary: Color.fromARGB(255, 33, 79, 243),
      primary: Colors.pink,
      brightness: Brightness.light,
    ),
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
    ),
    textTheme: TextTheme(bodyMedium: TextStyle(color: Colors.black)),
  );
  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.pink,
    scaffoldBackgroundColor: const Color(0xFF121212),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.black,
      foregroundColor: Colors.white,
    ),
    textTheme: TextTheme(bodyMedium: TextStyle(color: Colors.white)),
  );
}
