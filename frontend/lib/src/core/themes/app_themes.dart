import 'package:cinequest/gen/colors.gen.dart';
import 'package:cinequest/src/common/constants/app_sizes.dart';
import 'package:cinequest/src/core/themes/app_style.dart';
import 'package:flutter/material.dart';

class AppThemes {
  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: AppColors.black,
      scaffoldBackgroundColor: AppColors.black,
      appBarTheme: const AppBarTheme(
        color: AppColors.black,
        elevation: 0,
      ),
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: const EdgeInsets.symmetric(vertical: 12),
        labelStyle: AppStyles.p2().copyWith(
          color: AppColors.dimGray,
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.blackOlive),
        ),
        border: const UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.blackOlive),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.white),
        ),
        errorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.red),
        ),
      ),
      textTheme: TextTheme(
        headlineLarge: AppStyles.h1(),
        headlineMedium: AppStyles.h2(),
        headlineSmall: AppStyles.h3(),
        bodyLarge: AppStyles.p1(),
        bodyMedium: AppStyles.p2(),
        bodySmall: AppStyles.c1(),
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: AppColors.eerieBlack,
        contentTextStyle: AppStyles.p2(),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.borderRadiusMd),
        ),
      ),
    );
  }
}
