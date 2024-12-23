import 'package:cinequest/gen/colors.gen.dart';
import 'package:cinequest/src/common/constants/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SvgIcon extends StatelessWidget {
  const SvgIcon({
    required this.iconPath,
    super.key,
    this.notNeedColorFilter = false,
    this.colorFilter,
    this.iconSize = AppSizes.iconMd,
    this.onPressed,
  });

  final double iconSize;
  final String iconPath;
  final bool notNeedColorFilter;
  final ColorFilter? colorFilter;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(100),
      onTap: onPressed,
      child: SvgPicture.asset(
        iconPath,
        width: iconSize,
        height: iconSize,
        colorFilter: notNeedColorFilter
            ? null
            : colorFilter ??
                const ColorFilter.mode(AppColors.white, BlendMode.srcIn),
      ),
    );
  }
}
