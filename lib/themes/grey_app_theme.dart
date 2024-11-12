import 'package:flutter/material.dart';
import 'package:zen/themes/app_theme.dart';

class GreyTheme extends AppTheme {
  const GreyTheme();

  @override
  ThemeData getTheme() {
    Color primary = const Color(0xff9D9BA2);
    Color secondary = const Color(0xff4C4C4C);
    Color tertiary = const Color(0xffE9E9E9);
    return super.createTheme(
        primary: primary, secondary: secondary, tertiary: tertiary);
  }
}
