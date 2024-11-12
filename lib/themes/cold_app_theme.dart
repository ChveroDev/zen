import 'package:flutter/src/material/theme_data.dart';
import 'package:zen/themes/app_theme.dart';
import 'package:flutter/material.dart';

class ColdTheme extends AppTheme {
  const ColdTheme();

  @override
  ThemeData getTheme() {
    Color secondary = Color(0xff483247);
    Color primary = Color(0xff7777A6);
    Color tertiary = Color(0xffD7D6D6);
    return super.createTheme(
        primary: primary, secondary: secondary, tertiary: tertiary);
  }
}
