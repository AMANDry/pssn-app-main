import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pssn/common/theme/app_colors.dart';
import 'package:pssn/common/theme/app_fonts.dart';

// Custom font styles
TextStyle custom1 = TextStyle(
  color: AppColors.primaryColor,
  fontFamily: AppFonts.brown,
  fontSize: 40.sp,
  fontWeight: FontWeight.w400,
  height: 22 / 40,
);

// Material font styles
class AppTypography {
  AppTypography._();

  static final TextStyle heading1 = TextStyle(
    color: AppColors.primaryColor,
    fontFamily: AppFonts.brown,
    fontSize: 72.sp,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.12,
    height: 104.sp / 72.sp,
  );
  static final TextStyle heading2 = TextStyle(
    color: AppColors.primaryColor,
    fontFamily: AppFonts.brown,
    fontSize: 56.sp,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.10,
    height: 76.sp / 56.sp,
  );
  static final TextStyle heading3 = TextStyle(
    color: AppColors.primaryColor,
    fontFamily: AppFonts.brown,
    fontSize: 48.sp,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.08,
    height: 68.sp / 48.sp,
  );
  static final TextStyle heading4 = TextStyle(
    color: AppColors.primaryColor,
    fontFamily: AppFonts.brown,
    fontSize: 36.sp,
    fontWeight: FontWeight.w400,
    letterSpacing: 0,
    height: 52.sp / 36.sp,
  );
  static final TextStyle heading5 = TextStyle(
    color: AppColors.primaryColor,
    fontFamily: AppFonts.brown,
    fontSize: 28.sp,
    fontWeight: FontWeight.w400,
    letterSpacing: 0,
    height: 40.sp / 28.sp,
  );
  static final enSubtitle2 = TextStyle(
    color: AppColors.primaryColor,
    fontFamily: AppFonts.brown,
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
    letterSpacing: 0,
    height: 24 / 16,
  );
  static final TextStyle h4 = TextStyle(
    color: AppColors.primaryColor,
    fontFamily: AppFonts.brown,
    fontSize: 30.sp,
    fontWeight: FontWeight.w700,
    letterSpacing: 0,
    height: 36.sp / 30.sp,
  );
  static final TextStyle paragraph = TextStyle(
    color: AppColors.primaryColor,
    fontFamily: AppFonts.brown,
    fontSize: 18.sp,
    fontWeight: FontWeight.w700,
    letterSpacing: 0,
    height: 26.sp / 18.sp,
  );
  static final TextStyle heading6 = TextStyle(
    color: AppColors.primaryColor,
    fontFamily: AppFonts.brown,
    fontSize: 24.sp,
    fontWeight: FontWeight.w400,
    letterSpacing: 0,
    height: 36.sp / 24.sp,
  );
  static final TextStyle subtitle1 = TextStyle(
    color: AppColors.primaryColor,
    fontFamily: AppFonts.brown,
    fontSize: 20.sp,
    fontWeight: FontWeight.w400,
    letterSpacing: 0,
    height: 32.sp / 20.sp,
  );
  static final TextStyle subtitle2 = TextStyle(
    color: AppColors.primaryColor,
    fontFamily: AppFonts.brown,
    fontSize: 16.sp,
    fontWeight: FontWeight.w400,
    letterSpacing: 0,
    height: 24.sp / 16.sp,
  );
  static final TextStyle body1 = TextStyle(
    color: AppColors.primaryColor,
    fontFamily: AppFonts.brown,
    fontSize: 20.sp,
    fontWeight: FontWeight.w300,
    letterSpacing: 0,
    height: 32.sp / 20.sp,
  );
  static final TextStyle body2 = TextStyle(
    color: AppColors.onSurfaceMedium,
    fontFamily: AppFonts.brown,
    fontSize: 16.sp,
    fontWeight: FontWeight.w300,
    letterSpacing: 0,
    height: 24.sp / 16.sp,
  );
  static final TextStyle button = TextStyle(
    color: AppColors.primaryColor,
    fontFamily: AppFonts.brown,
    fontSize: 16.sp,
    fontWeight: FontWeight.w400,
    letterSpacing: 0,
    height: 24.sp / 16.sp,
  );
  static final TextStyle caption = TextStyle(
    color: AppColors.onSurfaceMedium,
    fontFamily: AppFonts.brown,
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
    letterSpacing: 0,
    height: 20.sp / 14.sp,
  );
  static final TextStyle caption1 = TextStyle(
    color: AppColors.onSurfaceMedium,
    fontFamily: AppFonts.brown,
    fontSize: 14.sp,
    fontWeight: FontWeight.w300,
    letterSpacing: 0,
    height: 20.sp / 14.sp,
  );
  static final TextStyle overline = TextStyle(
    color: AppColors.primaryColor,
    fontFamily: AppFonts.brown,
    fontSize: 16.sp,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.02,
    height: 24.sp / 16.sp,
  );

  static final TextStyle overlineOld = TextStyle(
    color: AppColors.primaryColor,
    fontFamily: AppFonts.brown,
    fontSize: 12.sp,
    fontWeight: FontWeight.w400,
    letterSpacing: 0,
    height: 1,
  );

  static final TextStyle allCaps3XLRegular = TextStyle(
    color: AppColors.primaryColor,
    fontFamily: AppFonts.brown,
    fontSize: 89.sp,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.08,
    height: 96.sp / 89.sp,
  );
  static final TextStyle allCaps3XLLight = TextStyle(
    color: AppColors.primaryColor,
    fontFamily: AppFonts.brown,
    fontSize: 89.sp,
    fontWeight: FontWeight.w300,
    letterSpacing: 0.08,
    height: 96.sp / 89.sp,
  );
  static final TextStyle allCaps2XLRegular = TextStyle(
    color: AppColors.primaryColor,
    fontFamily: AppFonts.brown,
    fontSize: 67.sp,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.08,
    height: 76.sp / 67.sp,
  );
  static final TextStyle allCaps2XLLight = TextStyle(
    color: AppColors.primaryColor,
    fontFamily: AppFonts.brown,
    fontSize: 67.sp,
    fontWeight: FontWeight.w300,
    letterSpacing: 0.08,
    height: 76.sp / 67.sp,
  );
  static final TextStyle allCapsXLRegular = TextStyle(
    color: AppColors.primaryColor,
    fontFamily: AppFonts.brown,
    fontSize: 50.sp,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.08,
    height: 60.sp / 50.sp,
  );
  static final TextStyle allCapsXLLight = TextStyle(
    color: AppColors.primaryColor,
    fontFamily: AppFonts.brown,
    fontSize: 50.sp,
    fontWeight: FontWeight.w300,
    letterSpacing: 0.08,
    height: 60.sp / 50.sp,
  );
  static final TextStyle allCapsLRegular = TextStyle(
    color: AppColors.primaryColor,
    fontFamily: AppFonts.brown,
    fontSize: 37.sp,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.08,
    height: 44.sp / 37.sp,
  );
  static final TextStyle allCapsLLight = TextStyle(
    color: AppColors.primaryColor,
    fontFamily: AppFonts.brown,
    fontSize: 37.sp,
    fontWeight: FontWeight.w300,
    letterSpacing: 0.08,
    height: 44.sp / 37.sp,
  );
  static final TextStyle allCapsMRegular = TextStyle(
    color: AppColors.primaryColor,
    fontFamily: AppFonts.brown,
    fontSize: 28.sp,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.08,
    height: 36.sp / 28.sp,
  );
  static final TextStyle allCapsMLight = TextStyle(
    color: AppColors.primaryColor,
    fontFamily: AppFonts.brown,
    fontSize: 28.sp,
    fontWeight: FontWeight.w300,
    letterSpacing: 0.08,
    height: 36.sp / 28.sp,
  );
  static final TextStyle allCapsSRegular = TextStyle(
    color: AppColors.primaryColor,
    fontFamily: AppFonts.brown,
    fontSize: 21.sp,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.08,
    height: 32.sp / 21.sp,
  );
  static final TextStyle allCapsXSRegular = TextStyle(
    color: AppColors.primaryColor,
    fontFamily: AppFonts.brown,
    fontSize: 16.sp,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.08,
    height: 20.sp / 16.sp,
  );
  static final TextStyle allCaps2XSRegular = TextStyle(
    color: AppColors.primaryColor,
    fontFamily: AppFonts.brown,
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.08,
    height: 20.sp / 14.sp,
  );
  static final TextStyle allCaps3XSRegular = TextStyle(
    color: AppColors.primaryColor,
    fontFamily: AppFonts.brown,
    fontSize: 12.sp,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.08,
    height: 16.sp / 12.sp,
  );
  static final TextStyle allCaps3XSLight = TextStyle(
    color: AppColors.primaryColor,
    fontFamily: AppFonts.brown,
    fontSize: 12.sp,
    fontWeight: FontWeight.w300,
    letterSpacing: 0.08,
    height: 16.sp / 12.sp,
  );
  static final TextStyle allCaps4XSRegular = TextStyle(
    color: AppColors.primaryColor,
    fontFamily: AppFonts.brown,
    fontSize: 10.sp,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.08,
    height: 16.sp / 10.sp,
  );
  static final TextStyle sentenceCase2XLRegular = TextStyle(
    color: AppColors.primaryColor,
    fontFamily: AppFonts.brown,
    fontSize: 38.sp,
    fontWeight: FontWeight.w400,
    letterSpacing: -0.02,
    height: 48.sp / 38.sp,
  );
  static final TextStyle sentenceCase2XLLight = TextStyle(
    color: AppColors.primaryColor,
    fontFamily: AppFonts.brown,
    fontSize: 38.sp,
    fontWeight: FontWeight.w300,
    letterSpacing: -0.02,
    height: 48.sp / 38.sp,
  );
  static final TextStyle sentenceCaseXLRegular = TextStyle(
    color: AppColors.primaryColor,
    fontFamily: AppFonts.brown,
    fontSize: 28.sp,
    fontWeight: FontWeight.w400,
    letterSpacing: -0.02,
    height: 40.sp / 28.sp,
  );
  static final TextStyle sentenceCaseXLLight = TextStyle(
    color: AppColors.primaryColor,
    fontFamily: AppFonts.brown,
    fontSize: 28.sp,
    fontWeight: FontWeight.w300,
    letterSpacing: -0.02,
    height: 40.sp / 28.sp,
  );
  static final TextStyle sentenceCaseLRegular = TextStyle(
    color: AppColors.primaryColor,
    fontFamily: AppFonts.brown,
    fontSize: 24.sp,
    fontWeight: FontWeight.w400,
    letterSpacing: -0.02,
    height: 36.sp / 24.sp,
  );
  static final TextStyle sentenceCaseLLight = TextStyle(
    color: AppColors.primaryColor,
    fontFamily: AppFonts.brown,
    fontSize: 24.sp,
    fontWeight: FontWeight.w300,
    letterSpacing: -0.02,
    height: 36.sp / 24.sp,
  );
  static final TextStyle sentenceCaseMRegular = TextStyle(
    color: AppColors.primaryColor,
    fontFamily: AppFonts.brown,
    fontSize: 21.sp,
    fontWeight: FontWeight.w400,
    letterSpacing: -0.02,
    height: 32.sp / 21.sp,
  );
  static final TextStyle sentenceCaseMLight = TextStyle(
    color: AppColors.primaryColor,
    fontFamily: AppFonts.brown,
    fontSize: 21.sp,
    fontWeight: FontWeight.w300,
    letterSpacing: -0.02,
    height: 32.sp / 21.sp,
  );
  static final TextStyle sentenceCaseSRegular = TextStyle(
    color: AppColors.primaryColor,
    fontFamily: AppFonts.brown,
    fontSize: 16.sp,
    fontWeight: FontWeight.w400,
    letterSpacing: 0,
    height: 24.sp / 16.sp,
  );
  static final TextStyle sentenceCaseSLight = TextStyle(
    color: AppColors.primaryColor,
    fontFamily: AppFonts.brown,
    fontSize: 16.sp,
    fontWeight: FontWeight.w300,
    letterSpacing: 0,
    height: 24.sp / 16.sp,
  );
  static final TextStyle sentenceCaseXSRegular = TextStyle(
    color: AppColors.onSurfaceMedium,
    fontFamily: AppFonts.brown,
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
    letterSpacing: 0,
    height: 20.sp / 14.sp,
  );
  static final TextStyle sentenceCaseXSLight = TextStyle(
    color: AppColors.onSurfaceMedium,
    fontFamily: AppFonts.brown,
    fontSize: 14.sp,
    fontWeight: FontWeight.w300,
    letterSpacing: 0,
    height: 20.sp / 14.sp,
  );
}
