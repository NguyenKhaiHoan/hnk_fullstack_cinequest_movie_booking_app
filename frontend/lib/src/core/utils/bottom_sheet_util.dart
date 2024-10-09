import 'dart:io';

import 'package:cinequest/gen/assets.gen.dart';
import 'package:cinequest/gen/colors.gen.dart';
import 'package:cinequest/src/common/constants/app_sizes.dart';
import 'package:cinequest/src/common/widgets/custom_circle_button.dart';
import 'package:cinequest/src/common/widgets/custom_divider.dart';
import 'package:cinequest/src/core/extensions/context_extension.dart';
import 'package:cinequest/src/core/extensions/string_extension.dart';
import 'package:cinequest/src/core/utils/app_util.dart';
import 'package:cinequest/src/core/utils/ui_util.dart';
import 'package:flutter/material.dart';

/// Các util dành cho BottomSheet
class BottomSheetUtil {
  BottomSheetUtil._();

  static Future<File?> showTakeImageBottomSheet(BuildContext context) async {
    return showModalBottomSheet<File?>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: AppSizes.defaultSpace / 3,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppSizes.borderRadiusLg),
                  color: AppColors.eerieBlack,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextButton(
                      onPressed: () async {
                        final photo = await AppUtil.pickImageFromCamera();
                        if (!context.mounted) return;
                        Navigator.pop(context, photo);
                      },
                      child: Text(
                        'Take a Photo'.hardcoded,
                        style: context.textTheme.bodyLarge,
                      ),
                    ),
                    const CustomDivider(),
                    TextButton(
                      onPressed: () async {
                        final photo = await AppUtil.pickImageFromGallery();
                        if (!context.mounted) return;
                        Navigator.pop(context, photo);
                      },
                      child: Text(
                        'Upload from Gallery'.hardcoded,
                        style: context.textTheme.bodyLarge,
                      ),
                    ),
                  ],
                ),
              ),
              gapH8,
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppSizes.borderRadiusMd),
                  color: AppColors.eerieBlack,
                ),
                child: TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    'Cancel'.hardcoded,
                    style: context.textTheme.bodyLarge!
                        .copyWith(fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  static Future<void> showSucessSignUp(BuildContext context) async {
    return showModalBottomSheet<void>(
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSizes.defaultSpace,
          ),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(AppSizes.borderRadiusLg),
              topRight: Radius.circular(AppSizes.borderRadiusLg),
            ),
            color: AppColors.eerieBlack,
          ),
          child: Column(
            children: [
              gapH8,
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppSizes.borderRadiusLg),
                ),
                child: SizedBox(
                  width: UiUtil.deviceWidth / 4,
                  child: ClipRRect(
                    borderRadius:
                        BorderRadius.circular(AppSizes.borderRadiusLg),
                    child: Container(
                      height: 5,
                      color: AppColors.blackOlive,
                    ),
                  ),
                ),
              ),
              gapH48,
              CustomCircleButton(
                iconPath: AppAssets.images.check.path,
                buttonSize: 150,
                colorFilter: const ColorFilter.mode(
                  AppColors.white,
                  BlendMode.srcIn,
                ),
              ),
              gapH32,
              Text(
                "You're all set".toUpperCase().hardcoded,
                style: context.textTheme.bodyMedium,
              ),
              gapH24,
              Text(
                'Discover the lastest movies, book your seats hassle-free, and enjoy exclusive deals and promotions'
                    .hardcoded,
                textAlign: TextAlign.center,
                style: context.textTheme.bodySmall!
                    .copyWith(color: AppColors.dimGray),
              ),
              const Spacer(),
            ],
          ),
        );
      },
    );
  }
}
