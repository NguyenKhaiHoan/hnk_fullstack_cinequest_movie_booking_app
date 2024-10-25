import 'package:flutter/widgets.dart';

class RotationUtil {
  RotationUtil._();

  static Widget rotate({
    required Widget child,
    required double angle,
    Alignment alignment = Alignment.center,
  }) {
    return Transform.rotate(
      angle: angle,
      alignment: alignment,
      child: child,
    );
  }
}
