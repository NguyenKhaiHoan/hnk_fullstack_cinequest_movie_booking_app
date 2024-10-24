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
  });

  final Widget? leading;
  final double? leadingWidth;
  final List<Widget>? actions;
  final void Function()? onBackTap;
  final double? appBarHeight;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leadingWidth: leadingWidth,
      leading: leading,
      actions: actions,
      bottom: const PreferredSize(
        preferredSize: Size.fromHeight(0),
        child: CustomDivider(),
      ),
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(appBarHeight ?? AppSizes.defaultAppBarHeight);
}
