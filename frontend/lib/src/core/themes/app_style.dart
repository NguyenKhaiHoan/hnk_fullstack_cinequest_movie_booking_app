import 'package:cinequest/gen/colors.gen.dart';
import 'package:cinequest/gen/fonts.gen.dart';
import 'package:flutter/material.dart';

class AppStyles {
  const AppStyles._();

  /// h1 style
  static TextStyle h1() => const TextStyle(
        fontStyle: FontStyle.normal,
        fontFamily: AppFonts.si,
        color: AppColors.white,
        fontSize: 42,
        fontWeight: FontWeight.w500,
        height: 48 / 42,
        letterSpacing: 0,
      );

  /// h2 style
  static TextStyle h2() => const TextStyle(
        fontStyle: FontStyle.normal,
        fontFamily: AppFonts.si,
        color: AppColors.white,
        fontSize: 28,
        fontWeight: FontWeight.w500,
        height: 32 / 28,
        letterSpacing: 0,
      );

  /// h3 style
  static TextStyle h3() => const TextStyle(
        fontStyle: FontStyle.normal,
        fontFamily: AppFonts.si,
        color: AppColors.white,
        fontSize: 22,
        fontWeight: FontWeight.w400,
        height: 26 / 22,
        letterSpacing: 0,
      );

  /// p1 style
  static TextStyle p1() => const TextStyle(
        fontStyle: FontStyle.normal,
        fontFamily: AppFonts.si,
        color: AppColors.white,
        fontSize: 20,
        fontWeight: FontWeight.w400,
        height: 24 / 20,
        letterSpacing: 0,
      );

  /// p2 style
  static TextStyle p2() => const TextStyle(
        fontStyle: FontStyle.normal,
        fontFamily: AppFonts.si,
        color: AppColors.white,
        fontSize: 14,
        fontWeight: FontWeight.w400,
        height: 20 / 14,
        letterSpacing: 0,
      );

  /// c1 style
  static TextStyle c1() => const TextStyle(
        fontStyle: FontStyle.normal,
        fontFamily: AppFonts.si,
        color: AppColors.white,
        fontSize: 12,
        fontWeight: FontWeight.w400,
        height: 16 / 12,
        letterSpacing: 0,
      );
}
