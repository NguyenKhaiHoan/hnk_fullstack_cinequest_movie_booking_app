import 'package:cinequest/gen/assets.gen.dart';
import 'package:cinequest/gen/colors.gen.dart';
import 'package:cinequest/src/common/constants/app_sizes.dart';
import 'package:cinequest/src/common/widgets/auth_app_bar.dart';
import 'package:cinequest/src/common/widgets/custom_button.dart';
import 'package:cinequest/src/core/extensions/string_extension.dart';
import 'package:cinequest/src/presentation/auth/blocs/reset_password/reset_password_bloc.dart';
import 'package:cinequest/src/presentation/auth/widgets/forms/reset_password_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RPResetPasswordView extends StatelessWidget {
  const RPResetPasswordView({
    required this.resetPasswordFormKey,
    required this.emailTextEditingController,
    required this.onSend,
    required this.isLoading,
    super.key,
    this.onEmailChanged,
  });

  final GlobalKey<FormState> resetPasswordFormKey;
  final TextEditingController emailTextEditingController;
  final void Function(String)? onEmailChanged;
  final void Function() onSend;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ResetPasswordBloc, ResetPasswordState>(
      builder: (context, state) {
        return Scaffold(
          appBar: _buildAppBar(),
          body: _buildBody(state),
        );
      },
    );
  }

  Widget _buildBody(ResetPasswordState state) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSizes.defaultSpace,
        AppSizes.defaultSpace * 2,
        AppSizes.defaultSpace,
        AppSizes.defaultSpace / 2,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          _buildForm(),
          const Spacer(),
          _buildResetPasswordButton(state),
        ],
      ),
    );
  }

  AuthAppBar _buildAppBar() => AuthAppBar(title: 'Reset Password'.hardcoded);

  Widget _buildForm() {
    return ResetPasswordForm(
      title: 'Reset password'.hardcoded,
      subtitle:
          'Enter your email to receive a confirmation link and reset your password'
              .hardcoded,
      formKey: resetPasswordFormKey,
      emailTextEditingController: emailTextEditingController,
      onEmailChanged: onEmailChanged,
    );
  }

  Widget _buildResetPasswordButton(ResetPasswordState state) {
    return state.isFormValided
        ? CustomButton(
            width: 170,
            iconPath: AppAssets.images.arrowRight.path,
            colorFilter: const ColorFilter.mode(
              AppColors.black,
              BlendMode.srcIn,
            ),
            buttonType: ButtonType.elevated,
            onPressed: onSend,
            isLoading: isLoading,
          )
        : CustomButton(
            width: 170,
            iconPath: AppAssets.images.arrowRight.path,
            buttonType: ButtonType.outlined,
            onPressed: onSend,
          );
  }
}
