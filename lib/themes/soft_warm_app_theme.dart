import 'package:flutter/material.dart';
import 'package:flutter/src/material/theme_data.dart';
import 'package:zen/themes/app_theme.dart';

class SoftWarmTheme extends AppTheme {
  const SoftWarmTheme();
  @override
  ThemeData getTheme() {
    Color primary = const Color(0xffDAA89B);
    Color secondary = const Color(0xffA93F55);
    Color tertiary = const Color(0xff0C0F0A);
    return super.createTheme(
        primary: primary, secondary: secondary, tertiary: tertiary);
  }
}
