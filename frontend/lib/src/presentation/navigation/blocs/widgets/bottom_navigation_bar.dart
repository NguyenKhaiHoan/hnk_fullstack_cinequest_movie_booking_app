import 'package:cinequest/gen/assets.gen.dart';
import 'package:cinequest/gen/colors.gen.dart';
import 'package:cinequest/src/common/constants/app_sizes.dart';
import 'package:cinequest/src/common/widgets/custom_button.dart';
import 'package:cinequest/src/common/widgets/custom_circle_button.dart';
import 'package:cinequest/src/core/extensions/string_extension.dart';
import 'package:flutter/material.dart';

/// Thanh bottom navigation
class BottomNavBar extends StatelessWidget {
  /// Constructor
  const BottomNavBar({
    required this.currentIndex,
    required this.onTap,
    super.key,
  });

  final int currentIndex;

  final void Function(int index) onTap;

  @override
  Widget build(BuildContext context) {
    final bottomNavLabelList = [
      'Tickets'.hardcoded,
      'Home'.hardcoded,
      'Profile'.hardcoded,
    ];
    final bottomNavIconList = [
      AppAssets.images.ticket.path,
      AppAssets.images.house.path,
      AppAssets.images.user.path,
    ];

    return Container(
      height: 60,
      color: AppColors.black,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSizes.defaultSpace / 2,
          vertical: AppSizes.defaultSpace / 3,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(3, (index) {
            return AnimatedSwitcher(
              duration: const Duration(milliseconds: 100),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return FadeTransition(
                  opacity: animation,
                  child: child,
                );
              },
              child: currentIndex == index
                  ? Padding(
                      key: ValueKey('button_$index'),
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: CustomButton(
                        buttonType: ButtonType.elevated,
                        backgroundColor: AppColors.eerieBlack,
                        text: bottomNavLabelList[index],
                        iconPath: bottomNavIconList[index],
                        onPressed: () => onTap(index),
                      ),
                    )
                  : Padding(
                      key: ValueKey('circle_$index'),
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: CustomCircleButton(
                        iconPath: bottomNavIconList[index],
                        onPressed: () => onTap(index),
                      ),
                    ),
            );
          }),
        ),
      ),
    );
  }
}
