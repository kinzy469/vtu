import 'package:flutter/material.dart';

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primarySwatch: Colors.deepPurple,
  scaffoldBackgroundColor: Colors.white,
  cardColor: Colors.white,
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.deepPurple,
    foregroundColor: Colors.white,
  ),
);

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primarySwatch: Colors.deepPurple,
  scaffoldBackgroundColor: Color(0xFF121212),
  cardColor: Color(0xFF1E1E1E),
  appBarTheme: AppBarTheme(
    backgroundColor: Color(0xFF1E1E1E),
    foregroundColor: Colors.white,
  ),
);
