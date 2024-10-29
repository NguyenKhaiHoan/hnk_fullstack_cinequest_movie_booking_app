import 'package:cinequest/src/common/constants/app_sizes.dart';
import 'package:cinequest/src/common/widgets/custom_divider.dart';
import 'package:flutter/material.dart';

class AppBarBottomDivider extends StatelessWidget
    implements PreferredSizeWidget {
  const AppBarBottomDivider({
    super.key,
    this.leadingWidth,
    this.appBarHeight,
    this.leading,
    this.actions,
    this.onBackTap,
    this.hasBottom,
  });

  final Widget? leading;
  final double? leadingWidth;
  final List<Widget>? actions;
  final void Function()? onBackTap;
  final double? appBarHeight;
  final bool? hasBottom;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leadingWidth: leadingWidth,
      leading: leading,
      actions: actions,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: hasBottom ?? true ? const CustomDivider() : const SizedBox(),
      ),
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(appBarHeight ?? AppSizes.defaultAppBarHeight);
}
