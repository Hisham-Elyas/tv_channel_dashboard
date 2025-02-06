import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'colors.dart';

class AppThemes {
  static final lightTheme = ThemeData(
    extensions: const [
      SkeletonizerConfigData(), // default constructor has light theme config
    ],
    useMaterial3: true,
    fontFamily: 'Cairo',
    colorScheme: const ColorScheme.light(
      primary: ColorsManager.lightPrimary,
      secondary: ColorsManager.lightSecondary,
      surface: ColorsManager.lightSurface,
      onSurface: ColorsManager.lightOnSurface,
      error: ColorsManager.lightError,
    ),
  );

  static final darkTheme = ThemeData(
    extensions: const [
      SkeletonizerConfigData.dark(), // dark theme config
    ],
    useMaterial3: true,
    fontFamily: 'Cairo',
    colorScheme: const ColorScheme.dark(
      primary: ColorsManager.darkPrimary,
      secondary: ColorsManager.darkSecondary,
      surface: ColorsManager.darkSurface,
      onSurface: ColorsManager.darkOnSurface,
      error: ColorsManager.darkError,
    ),
  );
}
