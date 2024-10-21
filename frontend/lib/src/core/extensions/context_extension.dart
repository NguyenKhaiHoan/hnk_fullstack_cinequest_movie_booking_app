import 'package:cinequest/gen/colors.gen.dart';
import 'package:flutter/material.dart';

// Theme extension
extension ThemeExtension on BuildContext {
  ThemeData get theme => Theme.of(this);

  TextTheme get textTheme => theme.textTheme;
}

// MediaQuery extension
extension MediaQueryExtension on BuildContext {
  Size get screenSize => MediaQuery.of(this).size;

  double get screenWidth => screenSize.width;

  double get screenHeight => screenSize.height;
}

// SnackBar extension
extension SnackbarExtension on BuildContext {
  void showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: context.textTheme.bodyMedium,
        ),
        // margin: const EdgeInsets.all(8),
        duration: const Duration(seconds: 3),
        backgroundColor: AppColors.eerieBlack,
      ),
    );
  }
}
