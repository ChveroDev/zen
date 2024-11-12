import 'package:flutter/material.dart';
import 'package:zen/themes/app_theme.dart';
import 'package:zen/themes/cold_app_theme.dart';
import 'package:zen/themes/grey_app_theme.dart';
import 'package:zen/themes/soft_warm_app_theme.dart';

enum AppThemes {
  cold(theme: ColdTheme()),
  grey(theme: GreyTheme()),
  warm(theme: SoftWarmTheme());

  final AppTheme _theme;

  const AppThemes({required AppTheme theme}) : _theme = theme;

  static AppTheme findByName(String name) {
    return AppThemes.values
        .where((element) => element.name == name)
        .first
        ._theme;
  }
}
