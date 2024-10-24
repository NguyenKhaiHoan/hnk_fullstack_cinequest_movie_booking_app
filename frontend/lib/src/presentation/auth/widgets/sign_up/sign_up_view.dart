import 'package:cinequest/gen/assets.gen.dart';
import 'package:cinequest/gen/colors.gen.dart';
import 'package:cinequest/src/common/blocs/buttton/button_bloc.dart';
import 'package:cinequest/src/common/constants/app_sizes.dart';
import 'package:cinequest/src/common/widgets/auth_app_bar.dart';
import 'package:cinequest/src/common/widgets/custom_button.dart';
import 'package:cinequest/src/core/extensions/string_extension.dart';
import 'package:cinequest/src/presentation/auth/blocs/sign_up/sign_up_bloc.dart';
import 'package:cinequest/src/presentation/auth/widgets/forms/auth_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({
    required this.listener,
    required this.formKey,
    required this.emailTextEditingController,
    required this.setPasswordTextEditingController,
    required this.confirmPasswordTextEditingController,
    required this.onSignUp,
    super.key,
    this.onEmailChanged,
    this.onSetPasswordChanged,
    this.onConfirmPasswordChanged,
  });
  final void Function(BuildContext, ButtonState) listener;
  final GlobalKey<FormState> formKey;
  final TextEditingController emailTextEditingController;
  final void Function(String)? onEmailChanged;
  final TextEditingController setPasswordTextEditingController;
  final void Function(String)? onSetPasswordChanged;
  final TextEditingController confirmPasswordTextEditingController;
  final void Function(String)? onConfirmPasswordChanged;
  final void Function() onSignUp;

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

  Padding _buildBody(ButtonState state) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSizes.defaultSpace,
        AppSizes.defaultSpace * 2,
        AppSizes.defaultSpace,
        AppSizes.defaultSpace / 2,
      ),
      child: _Body(
        signUpFormKey: formKey,
        emailTextEditingController: emailTextEditingController,
        setPasswordTextEditingController: setPasswordTextEditingController,
        confirmPasswordTextEditingController:
            confirmPasswordTextEditingController,
        onSignUp: onSignUp,
        onEmailChanged: onEmailChanged,
        onSetPasswordChanged: onSetPasswordChanged,
        onConfirmPasswordChanged: onConfirmPasswordChanged,
        isLoading: state == const ButtonState.loading(),
      ),
    );
  }

  AuthAppBar _buildAppBar() => AuthAppBar(title: 'Sign Up'.hardcoded);
}

/// Body
class _Body extends StatelessWidget {
  const _Body({
    required this.signUpFormKey,
    required this.emailTextEditingController,
    required this.setPasswordTextEditingController,
    required this.confirmPasswordTextEditingController,
    required this.onSignUp,
    required this.isLoading,
    this.onEmailChanged,
    this.onSetPasswordChanged,
    this.onConfirmPasswordChanged,
  });

  final GlobalKey<FormState> signUpFormKey;
  final TextEditingController emailTextEditingController;
  final void Function(String)? onEmailChanged;
  final TextEditingController setPasswordTextEditingController;
  final void Function(String)? onSetPasswordChanged;
  final TextEditingController? confirmPasswordTextEditingController;
  final void Function(String)? onConfirmPasswordChanged;
  final void Function() onSignUp;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(
      buildWhen: (previous, current) =>
          previous.isSignUpFormValid != current.isSignUpFormValid,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            _buildForm(),
            const Spacer(),
            _buildNextButton(state),
          ],
        );
      },
    );
  }

  AuthForm _buildForm() {
    return AuthForm(
      title: "Let's Get Started!".hardcoded,
      formKey: signUpFormKey,
      emailTextEditingController: emailTextEditingController,
      onEmailChanged: onEmailChanged,
      setPasswordTextEditingController: setPasswordTextEditingController,
      onSetPasswordChanged: onSetPasswordChanged,
      confirmPasswordTextEditingController:
          confirmPasswordTextEditingController,
      onConfirmPasswordChanged: onConfirmPasswordChanged,
    );
  }

  Widget _buildNextButton(SignUpState state) {
    return state.isSignUpFormValid
        ? CustomButton(
            width: 170,
            iconPath: AppAssets.images.arrowRight.path,
            colorFilter: const ColorFilter.mode(
              AppColors.black,
              BlendMode.srcIn,
            ),
            buttonType: ButtonType.elevated,
            onPressed: onSignUp,
            isLoading: isLoading,
          )
        : CustomButton(
            width: 170,
            iconPath: AppAssets.images.arrowRight.path,
            buttonType: ButtonType.outlined,
            onPressed: onSignUp,
          );
  }
}
