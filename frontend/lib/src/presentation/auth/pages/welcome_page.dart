import 'package:cinequest/gen/assets.gen.dart';
import 'package:cinequest/src/common/constants/app_sizes.dart';
import 'package:cinequest/src/core/extensions/context_extension.dart';
import 'package:cinequest/src/core/extensions/string_extension.dart';
import 'package:cinequest/src/core/utils/ui_util.dart';
import 'package:cinequest/src/presentation/auth/widgets/bottom_welcome.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          _buildBackground(),
          const Spacer(),
          _buildDescription(context),
          gapH24,
          const BottomWelcome(),
        ],
      ),
    );
  }

  Widget _buildDescription(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.defaultSpace),
      child: Text(
        'Unpleash the Power of Cinma: Your ticket\nto the Big Screen!'
            .hardcoded,
        style: context.textTheme.bodyMedium,
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildBackground() {
    return SvgPicture.asset(
      AppAssets.images.backgroundWelcome.path,
      width: UiUtil.deviceWidth,
      fit: BoxFit.cover,
    );
  }
}
