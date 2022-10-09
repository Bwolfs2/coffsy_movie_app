import 'package:flutter/material.dart';

import '../../../coffsy_design_system.dart';

class Themes {
  static ThemeData lightTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.deepOrange,
    ),
    fontFamily: 'IBMPlexSans',
    backgroundColor: ColorPalettes.lightBG,
    primaryColor: ColorPalettes.lightPrimary,
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: ColorPalettes.lightAccent,
    ),
    dividerColor: ColorPalettes.darkBG,
    scaffoldBackgroundColor: ColorPalettes.lightBG,
    appBarTheme: AppBarTheme(
      toolbarTextStyle: TextStyle(
        color: ColorPalettes.darkBG,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    fontFamily: 'IBMPlexSans',
    brightness: Brightness.dark,
    backgroundColor: ColorPalettes.darkBG,
    primaryColor: ColorPalettes.darkPrimary,
    dividerColor: ColorPalettes.lightPrimary,
    scaffoldBackgroundColor: ColorPalettes.darkBG,
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: ColorPalettes.darkAccent,
    ),
    appBarTheme: AppBarTheme(
      color: ColorPalettes.darkPrimary,
      toolbarTextStyle: TextStyle(
        color: ColorPalettes.lightBG,
        fontSize: 18,
        fontWeight: FontWeight.w700,
      ),
    ),
  );
}
