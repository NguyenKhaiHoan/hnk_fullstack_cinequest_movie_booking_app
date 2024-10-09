import 'package:cinequest/src/common/constants/app_sizes.dart';
import 'package:flutter/material.dart';

/// Padding chung trái hoặc phải cho các thành phần leading, action trong AppBar
class PaddingAppBar extends StatelessWidget {
  /// Contructor
  ///
  /// - [isLeft] : Kiểm tra cần padding trái hoặc phải
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
