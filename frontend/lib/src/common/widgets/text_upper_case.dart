import 'package:cinequest/src/core/extensions/context_extension.dart';
import 'package:flutter/material.dart';

/// Text được viết hoa được sử dụng trong toàn bộ App
class TextUpperCase extends StatelessWidget {
  /// Constructor
  const TextUpperCase({
    required this.text,
    super.key,
    this.textStyle,
    this.textColor,
  });

  final String text;
  final TextStyle? textStyle;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Text(
      text.toUpperCase(),
      style: textStyle ??
          (textColor != null
              ? context.textTheme.bodyMedium!.copyWith(color: textColor)
              : context.textTheme.bodyMedium!),
    );
  }
}
