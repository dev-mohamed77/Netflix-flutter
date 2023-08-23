import 'package:flutter/material.dart';
import 'package:netflix/core/manager/color/colors_manager.dart';

class AppThemeManager {
  AppThemeManager._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: "Preahvihear",
    primaryColor: AppColorsManager.accentColor,
    colorScheme: const ColorScheme.light(
      primary: AppColorsManager.accentColor,
      secondary: AppColorsManager.black,
      background: AppColorsManager.white,
      scrim: AppColorsManager.grey,
      brightness: Brightness.dark,
    ),
  );
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: "Preahvihear",
    colorScheme: const ColorScheme.dark(
      primary: AppColorsManager.accentColor,
      secondary: AppColorsManager.white,
      background: AppColorsManager.dark,
      scrim: AppColorsManager.grey,
      brightness: Brightness.light,
    ),
  );
}
