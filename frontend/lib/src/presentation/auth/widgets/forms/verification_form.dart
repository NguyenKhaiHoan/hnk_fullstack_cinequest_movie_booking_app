import 'package:cinequest/gen/colors.gen.dart';
import 'package:cinequest/src/common/constants/app_sizes.dart';
import 'package:cinequest/src/common/widgets/custom_text_field.dart';
import 'package:cinequest/src/core/extensions/context_extension.dart';
import 'package:cinequest/src/core/extensions/string_extension.dart';
import 'package:cinequest/src/core/utils/validation_util.dart';
import 'package:flutter/material.dart';

class VerificationForm extends StatelessWidget {
  const VerificationForm({
    required this.title,
    required this.subtitle,
    required this.email,
    required this.formKey,
    required this.verificationCodeTextEditingController,
    super.key,
    this.onVerificationCodeChanged,
  });

  final String title;
  final String subtitle;
  final String email;
  final GlobalKey<FormState> formKey;
  final TextEditingController verificationCodeTextEditingController;
  final void Function(String)? onVerificationCodeChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildTitleAndSubtitle(context),
        gapH24,
        _buildForm(),
      ],
    );
  }

  Widget _buildForm() {
    return Form(
      key: formKey,
      child: CustomTextField(
        label: 'Verification Code'.hardcoded,
        controller: verificationCodeTextEditingController,
        onChanged: onVerificationCodeChanged,
        validator: (value) => ValidationUtil.validateEmptyField(
          'Verification Code'.hardcoded,
          value,
        ),
      ),
    );
  }

  Widget _buildTitleAndSubtitle(BuildContext context) {
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
            text: subtitle,
            style: context.textTheme.bodyMedium!
                .copyWith(color: AppColors.dimGray),
            children: [
              TextSpan(
                text: email,
                style: context.textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
