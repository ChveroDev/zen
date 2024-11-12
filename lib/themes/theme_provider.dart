import 'package:flutter/material.dart';
import 'package:zen/themes/app_theme.dart';

class ThemeProvider extends ChangeNotifier {
  AppTheme _currentTheme;

  ThemeProvider(this._currentTheme);

  AppTheme get currentTheme => _currentTheme;

  void setTheme(AppTheme newTheme) {
    _currentTheme = newTheme;
    notifyListeners();
  }
}
