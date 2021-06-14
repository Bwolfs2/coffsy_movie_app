import 'package:coffsy_design_system/coffsy_design_system.dart';
import 'package:flutter/material.dart';

class Themes {
  static ThemeData lightTheme = ThemeData(
    fontFamily: 'IBMPlexSans',
    backgroundColor: ColorPalettes.lightBG,
    primaryColor: ColorPalettes.lightPrimary,
    accentColor: ColorPalettes.lightAccent,
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: ColorPalettes.lightAccent,
    ),
    dividerColor: ColorPalettes.darkBG,
    scaffoldBackgroundColor: ColorPalettes.lightBG,
    appBarTheme: AppBarTheme(
      textTheme: TextTheme(
        headline6: TextStyle(
          color: ColorPalettes.darkBG,
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    fontFamily: 'IBMPlexSans',
    brightness: Brightness.dark,
    backgroundColor: ColorPalettes.darkBG,
    primaryColor: ColorPalettes.darkPrimary,
    accentColor: ColorPalettes.darkAccent,
    dividerColor: ColorPalettes.lightPrimary,
    scaffoldBackgroundColor: ColorPalettes.darkBG,
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: ColorPalettes.darkAccent,
    ),
    appBarTheme: AppBarTheme(
      color: ColorPalettes.darkPrimary,
      textTheme: TextTheme(
        headline6: TextStyle(
          color: ColorPalettes.lightBG,
          fontSize: 18.0,
          fontWeight: FontWeight.w700,
        ),
      ),
    ),
  );
}
