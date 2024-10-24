import 'package:cinequest/gen/colors.gen.dart';
import 'package:cinequest/src/common/constants/app_sizes.dart';
import 'package:cinequest/src/common/widgets/custom_button.dart';
import 'package:cinequest/src/core/extensions/string_extension.dart';
import 'package:cinequest/src/core/routes/route_enums.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BottomWelcome extends StatelessWidget {
  const BottomWelcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: AppSizes.defaultSpace,
        horizontal: AppSizes.defaultSpace,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          _buildSignUpButton(context),
          gapH8,
          _buildLoginButton(context),
        ],
      ),
    );
  }

  Widget _buildLoginButton(BuildContext context) {
    return CustomButton(
      width: double.infinity,
      text: 'Login'.hardcoded,
      buttonType: ButtonType.outlined,
      onPressed: () => context.push(AppRoutes.login.path),
    );
  }

  Widget _buildSignUpButton(BuildContext context) {
    return CustomButton(
      width: double.infinity,
      text: 'Get started'.hardcoded,
      textColor: AppColors.black,
      buttonType: ButtonType.elevated,
      onPressed: () => context.push(AppRoutes.signUp.path),
    );
  }
}
