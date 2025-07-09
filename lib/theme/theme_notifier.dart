import 'package:flutter/material.dart';
import 'package:vtu_topup/theme/app_theme.dart';

class ThemeNotifier extends ChangeNotifier {
  ThemeData _currentTheme = AppTheme.lightTheme;

  ThemeData get currentTheme => _currentTheme;

 bool get isDarkMode => _currentTheme == AppTheme.darkTheme;
 
  void toggleTheme() {
    if (_currentTheme == AppTheme.lightTheme) {
      _currentTheme = AppTheme.darkTheme;
    } else {
      _currentTheme = AppTheme.lightTheme;
    }
    notifyListeners();
  }
}


