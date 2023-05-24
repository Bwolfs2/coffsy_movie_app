import 'package:flutter/material.dart';

import '../../../coffsy_design_system.dart';

class Themes {
  static ThemeData lightTheme = ThemeData(
    fontFamily: 'IBMPlexSans',
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
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.indigo,
    ).copyWith(background: ColorPalettes.lightBG),
  );

  static ThemeData darkTheme = ThemeData(
    fontFamily: 'IBMPlexSans',
    brightness: Brightness.dark,
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
    colorScheme: ColorScheme.dark(background: ColorPalettes.darkBG),
  );
}
