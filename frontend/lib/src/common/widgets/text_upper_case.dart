import 'package:cinequest/src/core/extensions/context_extension.dart';
import 'package:flutter/material.dart';

class TextUpperCase extends StatelessWidget {
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
