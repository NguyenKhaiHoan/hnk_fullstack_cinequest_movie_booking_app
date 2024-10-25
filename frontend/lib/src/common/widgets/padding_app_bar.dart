import 'package:cinequest/src/common/constants/app_sizes.dart';
import 'package:flutter/material.dart';

class PaddingAppBar extends StatelessWidget {
  const PaddingAppBar({
    required this.isLeft,
    required this.child,
    super.key,
    this.alignment,
  });

  final bool isLeft;
  final Widget child;
  final Alignment? alignment;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: alignment ?? Alignment.center,
      padding: EdgeInsets.only(
        left: isLeft ? AppSizes.defaultSpace : 0,
        right: isLeft ? 0 : AppSizes.defaultSpace,
      ),
      child: child,
    );
  }
}
