import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

//switch dark and light theme
  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }
}