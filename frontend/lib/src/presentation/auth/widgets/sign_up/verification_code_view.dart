import 'package:cinequest/gen/colors.gen.dart';
import 'package:cinequest/src/common/blocs/buttton/button_bloc.dart';
import 'package:cinequest/src/common/constants/app_sizes.dart';
import 'package:cinequest/src/common/widgets/auth_app_bar.dart';
import 'package:cinequest/src/common/widgets/custom_button.dart';
import 'package:cinequest/src/core/extensions/string_extension.dart';
import 'package:cinequest/src/presentation/auth/blocs/sign_up/sign_up_bloc.dart';
import 'package:cinequest/src/presentation/auth/widgets/forms/verification_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// View xác thực code: Nhập verification code
class VerificationCodeView extends StatelessWidget {
  const VerificationCodeView({
    required this.listener,
    required this.formKey,
    required this.verificationCodeTextEditingController,
    required this.onBack,
    required this.onCodeVerificated,
    super.key,
    this.onVerificationCodeChanged,
  });
  final void Function(BuildContext, ButtonState) listener;
  final GlobalKey<FormState> formKey;
  final TextEditingController verificationCodeTextEditingController;
  final void Function(String)? onVerificationCodeChanged;
  final void Function() onBack;
  final void Function() onCodeVerificated;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ButtonBloc, ButtonState>(
      listener: listener,
      builder: (context, state) {
        return Scaffold(
          appBar: _buildAppBar(),
          body: _buildBody(state),
        );
      },
    );
  }

  Widget _buildBody(ButtonState state) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSizes.defaultSpace,
        AppSizes.defaultSpace * 2,
        AppSizes.defaultSpace,
        AppSizes.defaultSpace / 2,
      ),
      child: _Body(
        verificationCodeFormKey: formKey,
        verificationCodeTextEditingController:
            verificationCodeTextEditingController,
        onBack: onBack,
        onSignUp: onCodeVerificated,
        isLoading: state == const ButtonState.loading(),
        onVerificationCodeChanged: onVerificationCodeChanged,
      ),
    );
  }

  AuthAppBar _buildAppBar() {
    return AuthAppBar(
      title: 'Verification'.hardcoded,
      onBackTap: onBack,
    );
  }
}

/// Body
class _Body extends StatelessWidget {
  const _Body({
    required this.verificationCodeFormKey,
    required this.verificationCodeTextEditingController,
    required this.onBack,
    required this.onSignUp,
    required this.isLoading,
    this.onVerificationCodeChanged,
  });

  final GlobalKey<FormState> verificationCodeFormKey;
  final TextEditingController verificationCodeTextEditingController;
  final void Function(String)? onVerificationCodeChanged;
  final void Function() onBack;
  final void Function() onSignUp;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            _buildForm(state),
            const Spacer(),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildCountdownTime(),
                gapW8,
                _buildContinueButton(state),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget _buildContinueButton(SignUpState state) {
    return Expanded(
      child: state.isVerificationCodeFormValid
          ? CustomButton(
              text: 'Continue'.hardcoded,
              textColor: AppColors.black,
              buttonType: ButtonType.elevated,
              onPressed: onSignUp,
              isLoading: isLoading,
            )
          : CustomButton(
              text: 'Continue'.hardcoded,
              buttonType: ButtonType.outlined,
              onPressed: onSignUp,
            ),
    );
  }

  Widget _buildCountdownTime() {
    return const CustomButton(
      width: 100,
      text: '0:59',
      buttonType: ButtonType.outlined,
    );
  }

  Widget _buildForm(SignUpState state) {
    return VerificationForm(
      title: 'Verify your email address'.hardcoded,
      subtitle: 'We have sent the verification code to '.hardcoded,
      email: state.email,
      formKey: verificationCodeFormKey,
      verificationCodeTextEditingController:
          verificationCodeTextEditingController,
      onVerificationCodeChanged: onVerificationCodeChanged,
    );
  }
}
