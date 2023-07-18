import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pssn/common/theme/app_colors.dart';
import 'package:pssn/common/theme/app_styles.dart';

// Light theme
ThemeData getLightThemeData() {
  return ThemeData.light().copyWith(
    appBarTheme: _appBarTheme,
    textTheme: _lightTextTheme,
    colorScheme: _lightColorScheme,
  );
}

ColorScheme _lightColorScheme = const ColorScheme.dark().copyWith(
  primary: AppColors.primaryColor,
  primaryContainer: AppColors.primaryVariantColor,
  secondary: AppColors.secondaryColor,
  secondaryContainer: AppColors.secondaryVariantColor,
  surface: AppColors.surfaceColor,
  background: AppColors.backgroundColor,
  error: AppColors.redColor,
  onPrimary: AppColors.onPrimary900_500,
  onSecondary: AppColors.onSecondary,
  onSurface: AppColors.onSurface,
  onBackground: AppColors.onBackground,
  onError: AppColors.onErrorSuccessInfoCallToAction,
  brightness: Brightness.dark,
);

TextTheme _lightTextTheme = const TextTheme().copyWith(
  displayLarge: AppTypography.heading1,
  displayMedium: AppTypography.heading2,
  displaySmall: AppTypography.heading3,
  headlineMedium: AppTypography.heading4,
  headlineSmall: AppTypography.heading5,
  titleLarge: AppTypography.heading6,
  titleMedium: AppTypography.subtitle1,
  titleSmall: AppTypography.subtitle2,
  bodyLarge: AppTypography.body1,
  bodyMedium: AppTypography.body2,
  labelLarge: AppTypography.button,
  bodySmall: AppTypography.caption,
  labelSmall: AppTypography.overline,
);

// Dark theme
ThemeData getDarkThemeData() {
  return ThemeData.dark().copyWith(
    appBarTheme: _appBarTheme,
    textTheme: _darkTextTheme,
    colorScheme: _darkColorScheme,
  );
}

ColorScheme _darkColorScheme = const ColorScheme.dark().copyWith(
  primary: AppColors.primaryColor,
  primaryContainer: AppColors.primaryVariantColor,
  secondary: AppColors.secondaryColor,
  secondaryContainer: AppColors.secondaryVariantColor,
  surface: AppColors.surfaceColor,
  background: AppColors.backgroundColor,
  error: AppColors.redColor,
  onPrimary: AppColors.onPrimary900_500,
  onSecondary: AppColors.onSecondary,
  onSurface: AppColors.onSurface,
  onBackground: AppColors.onBackground,
  onError: AppColors.onErrorSuccessInfoCallToAction,
  brightness: Brightness.dark,
);

TextTheme _darkTextTheme = const TextTheme().copyWith(
  displayLarge: AppTypography.heading1,
  displayMedium: AppTypography.heading2,
  displaySmall: AppTypography.heading3,
  headlineMedium: AppTypography.heading4,
  headlineSmall: AppTypography.heading5,
  titleLarge: AppTypography.heading6,
  titleMedium: AppTypography.subtitle1,
  titleSmall: AppTypography.subtitle2,
  bodyLarge: AppTypography.body1,
  bodyMedium: AppTypography.body2,
  labelLarge: AppTypography.button,
  bodySmall: AppTypography.caption,
  labelSmall: AppTypography.overline,
);

// Common theme
const AppBarTheme _appBarTheme = AppBarTheme(
  elevation: 0,
  centerTitle: false,
  systemOverlayStyle: SystemUiOverlayStyle.dark,
);
