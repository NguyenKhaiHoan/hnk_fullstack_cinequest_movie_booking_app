import 'package:cinequest/gen/assets.gen.dart';
import 'package:cinequest/gen/colors.gen.dart';
import 'package:cinequest/src/common/blocs/buttton/button_bloc.dart';
import 'package:cinequest/src/common/constants/app_sizes.dart';
import 'package:cinequest/src/common/widgets/auth_app_bar.dart';
import 'package:cinequest/src/common/widgets/custom_button.dart';
import 'package:cinequest/src/common/widgets/custom_divider.dart';
import 'package:cinequest/src/core/extensions/context_extension.dart';
import 'package:cinequest/src/core/extensions/string_extension.dart';
import 'package:cinequest/src/core/routes/route_enums.dart';
import 'package:cinequest/src/presentation/auth/blocs/login/login_bloc.dart';
import 'package:cinequest/src/presentation/auth/widgets/forms/auth_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LoginView extends StatelessWidget {
  const LoginView({
    required this.formKey,
    required this.emailTextEditingController,
    required this.setPasswordTextEditingController,
    required this.onLogin,
    super.key,
    this.onEmailChanged,
    this.onSetPasswordChanged,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController emailTextEditingController;
  final void Function(String)? onEmailChanged;
  final TextEditingController setPasswordTextEditingController;
  final void Function(String)? onSetPasswordChanged;
  final void Function() onLogin;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(
        AppSizes.defaultSpace,
        AppSizes.defaultSpace * 2,
        AppSizes.defaultSpace,
        AppSizes.defaultSpace / 2,
      ),
      child: BlocBuilder<ButtonBloc, ButtonState>(
        builder: (context, state) {
          return _Body(
            loginKey: formKey,
            emailTextEditingController: emailTextEditingController,
            setPasswordTextEditingController: setPasswordTextEditingController,
            onLogin: onLogin,
            isLoading: state == const ButtonState.loading(),
            onEmailChanged: onEmailChanged,
            onSetPasswordChanged: onSetPasswordChanged,
          );
        },
      ),
    );
  }

  AuthAppBar _buildAppBar() => AuthAppBar(title: 'Login'.hardcoded);
}

/// Body
class _Body extends StatelessWidget {
  /// Constructor
  const _Body({
    required this.loginKey,
    required this.emailTextEditingController,
    required this.setPasswordTextEditingController,
    required this.onLogin,
    required this.isLoading,
    this.onEmailChanged,
    this.onSetPasswordChanged,
  });

  final GlobalKey<FormState> loginKey;
  final TextEditingController emailTextEditingController;
  final void Function(String)? onEmailChanged;
  final TextEditingController setPasswordTextEditingController;
  final void Function(String)? onSetPasswordChanged;
  final void Function() onLogin;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) =>
          previous.isFormValided != current.isFormValided,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildForm(),
            gapH16,
            _buildTextButtonForgot(context),
            gapH48,
            _buildLoginButton(state),
            gapH24,
            const CustomDivider(),
            gapH16,
            _buildOtherAuthButtons(),
            gapH62,
            _buildNavigationButtonToSignUp(context),
          ],
        );
      },
    );
  }

  Widget _buildNavigationButtonToSignUp(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Center(
        child: TextButton(
          onPressed: () => context.push(AppRoutes.signUp.path),
          child: Text.rich(
            TextSpan(
              text: "Don't have an account? ".hardcoded,
              style: context.textTheme.bodyMedium!
                  .copyWith(color: AppColors.dimGray),
              children: [
                TextSpan(
                  text: 'Sign up'.toUpperCase().hardcoded,
                  style: context.textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextButtonForgot(BuildContext context) {
    return TextButton(
      onPressed: () => context.push(AppRoutes.resetPassword.path),
      child: Text(
        'Forgot the password?'.hardcoded,
        style: context.textTheme.bodyMedium!.copyWith(color: AppColors.dimGray),
      ),
    );
  }

  Widget _buildForm() {
    return AuthForm(
      title: 'Welcome back'.hardcoded,
      formKey: loginKey,
      emailTextEditingController: emailTextEditingController,
      onEmailChanged: onEmailChanged,
      setPasswordTextEditingController: setPasswordTextEditingController,
      onSetPasswordChanged: onSetPasswordChanged,
    );
  }

  Widget _buildLoginButton(LoginState state) {
    return state.isFormValided
        ? CustomButton(
            width: double.infinity,
            text: 'Login'.hardcoded,
            textColor: AppColors.black,
            buttonType: ButtonType.elevated,
            onPressed: onLogin,
            isLoading: isLoading,
          )
        : CustomButton(
            width: double.infinity,
            text: 'Login'.hardcoded,
            buttonType: ButtonType.outlined,
            onPressed: onLogin,
          );
  }

  Widget _buildOtherAuthButtons() {
    return Column(
      children: [
        CustomButton(
          isUpperCase: false,
          width: double.infinity,
          iconSize: 20,
          text: 'Sign in with Apple'.hardcoded,
          iconPath: AppAssets.images.apple.path,
          buttonType: ButtonType.outlined,
        ),
        gapH8,
        CustomButton(
          isUpperCase: false,
          width: double.infinity,
          text: 'Sign in with Google'.hardcoded,
          iconPath: AppAssets.images.google.path,
          notNeedColorFilter: true,
          buttonType: ButtonType.outlined,
        ),
      ],
    );
  }
}
