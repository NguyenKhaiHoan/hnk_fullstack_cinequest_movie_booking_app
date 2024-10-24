import 'package:cinequest/gen/colors.gen.dart';
import 'package:cinequest/src/common/constants/app_sizes.dart';
import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({super.key, this.text, this.height});

  final String? text;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return text != null
        ? Row(
            children: [
              Expanded(child: _buildDivider()),
              gapW16,
              Text(' $text '),
              gapW16,
              Expanded(child: _buildDivider()),
            ],
          )
        : const Divider();
  }

  Widget _buildDivider() => Divider(
        height: height ?? 0,
        color: AppColors.blackOlive,
      );
}
