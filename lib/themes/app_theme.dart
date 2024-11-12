import 'package:flutter/material.dart';

abstract class AppTheme {
  const AppTheme();
  ThemeData getTheme();

  @protected
  ThemeData createTheme(
      {required final Color primary,
      required final Color secondary,
      required final Color tertiary}) {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: primary,
        primary: primary,
        secondary: secondary,
        background: secondary,
        tertiary: tertiary,
      ),
      appBarTheme: AppBarTheme(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(5),
                bottomRight: Radius.circular(5)),
          ),
          elevation: 10,
          shadowColor: Colors.black,
          backgroundColor: primary,
          titleTextStyle: TextStyle(color: tertiary)),
      cardColor: primary,
      navigationBarTheme: NavigationBarThemeData(
          elevation: 2,
          shadowColor: Colors.black,
          indicatorColor: tertiary,
          backgroundColor: primary,
          labelTextStyle: MaterialStatePropertyAll(TextStyle(color: tertiary)),
          iconTheme: MaterialStatePropertyAll(IconThemeData(
            color: secondary,
          ))),
      listTileTheme: ListTileThemeData(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          iconColor: secondary,
          tileColor: primary,
          textColor: tertiary),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
          shape: CircleBorder(eccentricity: 0),
          backgroundColor: primary,
          foregroundColor: tertiary),
      radioTheme: RadioThemeData(
        fillColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
          if (states.contains(MaterialState.selected)) {
            return tertiary;
          }
          return primary;
        }),
      ),
      bottomAppBarTheme: BottomAppBarTheme(
        color: primary,
        elevation: 0,
        shadowColor: Colors.black,
      ),
      iconButtonTheme: IconButtonThemeData(
          style:
              ButtonStyle(foregroundColor: MaterialStatePropertyAll(tertiary))),
      useMaterial3: true,
    );
  }
}
