import 'package:cinequest/gen/assets.gen.dart';
import 'package:cinequest/gen/colors.gen.dart';
import 'package:cinequest/src/common/constants/app_sizes.dart';
import 'package:cinequest/src/common/widgets/auth_app_bar.dart';
import 'package:cinequest/src/common/widgets/custom_button.dart';
import 'package:cinequest/src/core/extensions/context_extension.dart';
import 'package:cinequest/src/core/extensions/string_extension.dart';
import 'package:cinequest/src/core/utils/ui_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RPVerificationLinkView extends StatelessWidget {
  const RPVerificationLinkView({
    required this.title,
    required this.subtitle,
    required this.email,
    required this.onBack,
    required this.onResend,
    required this.isLoading,
    super.key,
  });

  final String title;
  final String subtitle;
  final String email;
  final void Function() onBack;
  final void Function() onResend;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final parts = subtitle.split(email);
    final part1 = parts[0];
    final part2 = parts[1];
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: _buildAppBar(),
      body: _buildBody(context, part1, part2),
    );
  }

  Widget _buildBody(BuildContext context, String part1, String part2) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSizes.defaultSpace,
        AppSizes.defaultSpace * 2,
        AppSizes.defaultSpace,
        AppSizes.defaultSpace / 2,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTitleAndSubtitle(context, part1, part2),
          gapH48,
          _buildImage(),
          const Spacer(),
          _buildResendOrPopBackButton(),
        ],
      ),
    );
  }

  Widget _buildResendOrPopBackButton() {
    return CustomButton(
      width: double.infinity,
      text: 'Resend email'.hardcoded,
      textColor: AppColors.black,
      buttonType: ButtonType.elevated,
      onPressed: onResend,
      isLoading: isLoading,
    );
  }

  Widget _buildImage() {
    return Center(
      child: SvgPicture.asset(
        AppAssets.images.sendEmail.path,
        width: UiUtil.deviceWidth * 0.7,
        fit: BoxFit.cover,
      ),
    );
  }

  AuthAppBar _buildAppBar() {
    return AuthAppBar(
      title: 'Reset Password'.hardcoded,
      onBackTap: onBack,
    );
  }

  Widget _buildTitleAndSubtitle(
    BuildContext context,
    String part1,
    String part2,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: context.textTheme.headlineMedium,
        ),
        gapH16,
        Text.rich(
          TextSpan(
            text: '$part1 ',
            style: context.textTheme.bodyMedium!
                .copyWith(color: AppColors.dimGray),
            children: [
              TextSpan(
                text: '$email ',
                style: context.textTheme.bodyMedium,
              ),
              TextSpan(
                text: part2,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
