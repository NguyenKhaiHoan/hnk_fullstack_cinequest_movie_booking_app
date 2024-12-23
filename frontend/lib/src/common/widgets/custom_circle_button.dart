import 'package:cinequest/gen/colors.gen.dart';
import 'package:cinequest/src/common/constants/app_sizes.dart';
import 'package:cinequest/src/common/widgets/svg_icon.dart';
import 'package:flutter/material.dart';

class CustomCircleButton extends StatelessWidget {
  const CustomCircleButton({
    required this.iconPath,
    super.key,
    this.iconSize = AppSizes.iconMd,
    this.borderColor,
    this.buttonSize = AppSizes.buttonHeight,
    this.onPressed,
    this.colorFilter,
    this.notNeedColorFilter = false,
    this.backgroundColor,
  });

  final String iconPath;
  final double iconSize;
  final Color? borderColor;
  final double buttonSize;
  final void Function()? onPressed;
  final ColorFilter? colorFilter;
  final bool notNeedColorFilter;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(100),
      onTap: onPressed,
      child: Container(
        height: buttonSize,
        width: buttonSize,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.blackOlive),
            color: backgroundColor ?? Colors.transparent),
        child: Padding(
          padding: EdgeInsets.all(buttonSize * 12.0 / AppSizes.buttonHeight),
          child: SvgIcon(
            iconPath: iconPath,
            colorFilter: colorFilter,
            iconSize: iconSize,
            notNeedColorFilter: notNeedColorFilter,
          ),
        ),
      ),
    );
  }
}
