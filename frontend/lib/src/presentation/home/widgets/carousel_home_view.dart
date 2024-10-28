import 'package:cinequest/gen/colors.gen.dart';
import 'package:cinequest/src/common/constants/app_sizes.dart';
import 'package:cinequest/src/core/extensions/context_extension.dart';
import 'package:flutter/material.dart';

class CarouselHomeView extends StatelessWidget {
  const CarouselHomeView({
    required this.title,
    required this.child,
    super.key,
    this.titleStyle,
    this.subtitle,
  });

  final String title;
  final TextStyle? titleStyle;
  final String? subtitle;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTitle(context),
        gapH16,
        child,
      ],
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.defaultSpace),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (subtitle != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Text(
                subtitle!.toUpperCase(),
                style: context.textTheme.bodySmall!
                    .copyWith(color: AppColors.dimGray),
              ),
            ),
          Text(title, style: titleStyle),
        ],
      ),
    );
  }
}
