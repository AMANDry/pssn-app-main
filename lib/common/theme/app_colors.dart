import 'package:flutter/material.dart';

//TODO(): Update with app colors
class AppColors {
  AppColors._();

  static const Color primaryColor = Color(0xFF23211E);
  static const Color primaryVariantColor = Color(0xFF040505);
  static const Color secondaryColor = Color(0xFFDAAA00);
  static const Color secondaryVariantColor = Color(0xFFBF9600);
  static const Color backgroundColor = Color(0xFFF6F5F2);
  static const Color surfaceColor = Color(0xFFFFFFFF);
  static const Color darkBlueColor = Color(0xFF003865);
  static const Color greenColor = Color(0xFF006845);
  static const Color orangeColor = Color(0xFFF68D2E);
  static const Color lightBlueColor = Color(0xFF0076A8);
  static const Color redColor = Color(0xFFE03C31);
  static const Color onPrimary900_500 = Color(0xFFFFFFFF);
  static const Color onPrimary400_050 = Color(0xFF040404);
  static const Color onSecondary = Color(0xFF040404);
  static const Color onBackground = Color(0xFF040404);
  static const Color onSurface = Color(0xFF040404);
  static const Color onSurfaceMedium = Color(0xFF565451);
  static const Color onSurfaceHigh = Color(0xFF090808);
  static const Color onErrorSuccessInfoCallToAction = Color(0xFFFFFFFF);
  static const Color linkColor = Color(0xFF937206);
  static const Color buttonOutlineBorderColor = Color(0xFFBAB8B2);
  static const Color supportInfoColor = Color(0xFF0072A2);
  static const Color black = Color(0xFF000000);

  static const Color primaryColor900 = Color(0xFF040404);
  static const Color primaryColor800 = Color(0xFF171513);
  static const Color primaryColor700 = Color(0xFF23211E);
  static const Color primaryColor600 = Color(0xFF2D2926);
  static const Color primaryColor500 = Color(0xFF413E3C);
  static const Color primaryColor400 = Color(0xFFB7B7B8);
  static const Color primaryColor300 = Color(0xFFD1CFC9);
  static const Color primaryColor200 = Color(0xFFE8E6DF);
  static const Color primaryColor100 = Color(0xFFEFEEE9);
  static const Color primaryColor050 = Color(0xFFF6F5F2);

  static final MaterialColor primaryColorPalette =
      MaterialColor(AppColors.primaryColor500.value, const <int, Color>{
    900: primaryColor900,
    800: primaryColor800,
    700: primaryColor700,
    600: primaryColor600,
    500: primaryColor500,
    400: primaryColor400,
    300: primaryColor300,
    200: primaryColor200,
    100: primaryColor100,
    050: primaryColor050,
  });

  static const Color secondaryColor900 = Color(0xFF937206);
  static const Color secondaryColor800 = Color(0xFFC49900);
  static const Color secondaryColor700 = Color(0xFFDAAA00);
  static const Color secondaryColor600 = Color(0xFFDEB31A);
  static const Color secondaryColor500 = Color(0xFFE1BB33);
  static const Color secondaryColor400 = Color(0xFFEDD580);
  static const Color secondaryColor300 = Color(0xFFF0DD99);
  static const Color secondaryColor200 = Color(0xFFF4E6B3);
  static const Color secondaryColor100 = Color(0xFFF8EECC);
  static const Color secondaryColor050 = Color(0xFFFBF7E6);

  static final MaterialColor secondaryColorPallete =
      MaterialColor(AppColors.secondaryColor500.value, const <int, Color>{
    900: secondaryColor900,
    800: secondaryColor800,
    700: secondaryColor700,
    600: secondaryColor600,
    500: secondaryColor500,
    400: secondaryColor400,
    300: secondaryColor300,
    200: secondaryColor200,
    100: secondaryColor100,
    050: secondaryColor050,
  });
}

class NeosXColorsOpacity {
  NeosXColorsOpacity._();

  static MaterialColor primaryColorOpacity =
      MaterialColor(AppColors.primaryColor700.value, <int, Color>{
    80: Color(AppColors.primaryColor700.value).withOpacity(.8),
    70: Color(AppColors.primaryColor700.value).withOpacity(.7),
    60: Color(AppColors.primaryColor700.value).withOpacity(.6),
    50: Color(AppColors.primaryColor700.value).withOpacity(.5),
    40: Color(AppColors.primaryColor700.value).withOpacity(.4),
    30: Color(AppColors.primaryColor700.value).withOpacity(.3),
    20: Color(AppColors.primaryColor700.value).withOpacity(.2),
    10: Color(AppColors.primaryColor700.value).withOpacity(.1),
  });

  static MaterialColor secondaryColorOpacity =
      MaterialColor(AppColors.secondaryColor700.value, <int, Color>{
    80: Color(AppColors.secondaryColor700.value).withOpacity(.8),
    70: Color(AppColors.secondaryColor700.value).withOpacity(.7),
    60: Color(AppColors.secondaryColor700.value).withOpacity(.6),
    50: Color(AppColors.secondaryColor700.value).withOpacity(.5),
    40: Color(AppColors.secondaryColor700.value).withOpacity(.4),
    30: Color(AppColors.secondaryColor700.value).withOpacity(.3),
    20: Color(AppColors.secondaryColor700.value).withOpacity(.2),
    10: Color(AppColors.secondaryColor700.value).withOpacity(.1),
  });

  static MaterialColor surfaceColorOpacity =
      MaterialColor(AppColors.surfaceColor.value, <int, Color>{
    80: Color(AppColors.surfaceColor.value).withOpacity(.8),
    70: Color(AppColors.surfaceColor.value).withOpacity(.7),
    60: Color(AppColors.surfaceColor.value).withOpacity(.6),
    50: Color(AppColors.surfaceColor.value).withOpacity(.5),
    40: Color(AppColors.surfaceColor.value).withOpacity(.4),
    30: Color(AppColors.surfaceColor.value).withOpacity(.3),
    20: Color(AppColors.surfaceColor.value).withOpacity(.2),
    10: Color(AppColors.surfaceColor.value).withOpacity(.1),
  });

  static MaterialColor lightBlueColorOpacity =
      MaterialColor(AppColors.lightBlueColor.value, <int, Color>{
    80: Color(AppColors.lightBlueColor.value).withOpacity(.8),
    70: Color(AppColors.lightBlueColor.value).withOpacity(.7),
    60: Color(AppColors.lightBlueColor.value).withOpacity(.6),
    50: Color(AppColors.lightBlueColor.value).withOpacity(.5),
    40: Color(AppColors.lightBlueColor.value).withOpacity(.4),
    30: Color(AppColors.lightBlueColor.value).withOpacity(.3),
    20: Color(AppColors.lightBlueColor.value).withOpacity(.2),
    10: Color(AppColors.lightBlueColor.value).withOpacity(.1),
  });

  static MaterialColor redColorOpacity =
      MaterialColor(AppColors.redColor.value, <int, Color>{
    80: Color(AppColors.redColor.value).withOpacity(.8),
    70: Color(AppColors.redColor.value).withOpacity(.7),
    60: Color(AppColors.redColor.value).withOpacity(.6),
    50: Color(AppColors.redColor.value).withOpacity(.5),
    40: Color(AppColors.redColor.value).withOpacity(.4),
    30: Color(AppColors.redColor.value).withOpacity(.3),
    20: Color(AppColors.redColor.value).withOpacity(.2),
    10: Color(AppColors.redColor.value).withOpacity(.1),
  });

  static MaterialColor orangeColorOpacity =
      MaterialColor(AppColors.orangeColor.value, <int, Color>{
    80: Color(AppColors.orangeColor.value).withOpacity(.8),
    70: Color(AppColors.orangeColor.value).withOpacity(.7),
    60: Color(AppColors.orangeColor.value).withOpacity(.6),
    50: Color(AppColors.orangeColor.value).withOpacity(.5),
    40: Color(AppColors.orangeColor.value).withOpacity(.4),
    30: Color(AppColors.orangeColor.value).withOpacity(.3),
    20: Color(AppColors.orangeColor.value).withOpacity(.2),
    10: Color(AppColors.orangeColor.value).withOpacity(.1),
  });

  static MaterialColor greenColorOpacity =
      MaterialColor(AppColors.greenColor.value, <int, Color>{
    80: Color(AppColors.greenColor.value).withOpacity(.8),
    70: Color(AppColors.greenColor.value).withOpacity(.7),
    60: Color(AppColors.greenColor.value).withOpacity(.6),
    50: Color(AppColors.greenColor.value).withOpacity(.5),
    40: Color(AppColors.greenColor.value).withOpacity(.4),
    30: Color(AppColors.greenColor.value).withOpacity(.3),
    20: Color(AppColors.greenColor.value).withOpacity(.2),
    10: Color(AppColors.greenColor.value).withOpacity(.1),
  });

  static MaterialColor darkBlueColorOpacity =
      MaterialColor(AppColors.darkBlueColor.value, <int, Color>{
    80: Color(AppColors.darkBlueColor.value).withOpacity(.8),
    70: Color(AppColors.darkBlueColor.value).withOpacity(.7),
    60: Color(AppColors.darkBlueColor.value).withOpacity(.6),
    50: Color(AppColors.darkBlueColor.value).withOpacity(.5),
    40: Color(AppColors.darkBlueColor.value).withOpacity(.4),
    30: Color(AppColors.darkBlueColor.value).withOpacity(.3),
    20: Color(AppColors.darkBlueColor.value).withOpacity(.2),
    10: Color(AppColors.darkBlueColor.value).withOpacity(.1),
  });
}
