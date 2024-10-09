import 'package:cinequest/gen/assets.gen.dart';
import 'package:cinequest/gen/colors.gen.dart';
import 'package:cinequest/src/common/constants/app_sizes.dart';
import 'package:cinequest/src/common/widgets/app_bar_bottom_divider.dart';
import 'package:cinequest/src/common/widgets/padding_app_bar.dart';
import 'package:cinequest/src/common/widgets/svg_icon.dart';
import 'package:cinequest/src/common/widgets/text_upper_case.dart';
import 'package:cinequest/src/core/extensions/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Appbar dùng chung cho các màn hình xác thực
class AuthAppBar extends StatelessWidget implements PreferredSizeWidget {
  /// Constructor
  ///
  /// - [title] : Title nằm bên phải AppBar
  const AuthAppBar({
    required this.title,
    super.key,
    this.onBackTap,
    this.hasLeading = true,
    this.appBarHeight,
  });

  final String title;
  final bool hasLeading;
  final void Function()? onBackTap;
  final double? appBarHeight;

  @override
  Widget build(BuildContext context) {
    return AppBarBottomDivider(
      leadingWidth: 90,
      leading: hasLeading
          ? PaddingAppBar(
              isLeft: true,
              child: GestureDetector(
                onTap: onBackTap ?? () => context.pop(),
                child: Row(
                  children: [
                    SvgIcon(iconPath: AppAssets.images.arrowLeft.path),
                    gapW4,
                    TextUpperCase(
                      text: 'Back'.hardcoded,
                    ),
                  ],
                ),
              ),
            )
          : null,
      actions: [
        PaddingAppBar(
          isLeft: false,
          child: TextUpperCase(
            text: title,
            textColor: AppColors.dimGray,
          ),
        ),
      ],
      appBarHeight: appBarHeight,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
