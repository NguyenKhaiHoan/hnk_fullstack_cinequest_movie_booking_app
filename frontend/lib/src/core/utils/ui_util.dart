import 'package:cinequest/src/core/extensions/context_extension.dart';
import 'package:flutter/material.dart';

/// Các util dành cho UI
class UiUtil {
  UiUtil._();

  static double _deviceWidth = 0;
  static double _deviceHeight = 0;

  /// Khởi tạo
  static void initialize(BuildContext context) {
    _deviceWidth = context.screenWidth;
    _deviceHeight = context.screenHeight;
  }

  static double get deviceWidth => _deviceWidth;

  static double get deviceHeight => _deviceHeight;
}
