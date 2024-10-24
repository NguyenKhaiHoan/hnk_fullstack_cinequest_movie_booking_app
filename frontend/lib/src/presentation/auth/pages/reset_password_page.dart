import 'package:cinequest/src/common/blocs/buttton/button_bloc.dart';
import 'package:cinequest/src/core/di/injection_container.dart';
import 'package:cinequest/src/core/extensions/string_extension.dart';
import 'package:cinequest/src/core/utils/toast_util.dart';
import 'package:cinequest/src/domain/auth/usecases/forgot_password_usecase.dart';
import 'package:cinequest/src/domain/auth/usecases/params/email_params.dart';
import 'package:cinequest/src/presentation/auth/blocs/reset_password/reset_password_bloc.dart';
import 'package:cinequest/src/presentation/auth/widgets/reset_password/rp_reset_password_view.dart';
import 'package:cinequest/src/presentation/auth/widgets/reset_password/rp_verification_link.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part '_mixins/reset_password_page.mixin.dart';

class ResetPasswordPage extends StatelessWidget {
  const ResetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ResetPasswordBloc(),
        ),
        BlocProvider(
          create: (context) => ButtonBloc(),
        ),
      ],
      child: const _Page(),
    );
  }
}

class _Page extends StatefulWidget {
  const _Page();

  @override
  State<_Page> createState() => _PageState();
}

class _PageState extends State<_Page> with _PageMixin {
  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        BlocConsumer<ButtonBloc, ButtonState>(
          listener: _listenerSendEmail,
          builder: (context, state) {
            return RPResetPasswordView(
              resetPasswordFormKey: _resetPasswordFormKey,
              emailTextEditingController: _emailTextEditingController,
              onSend: _send,
              onEmailChanged: _changeEmail,
              isLoading: state == const ButtonState.loading(),
            );
          },
        ),
        BlocBuilder<ResetPasswordBloc, ResetPasswordState>(
          builder: (context, state) {
            final email = state.email;
            return BlocConsumer<ButtonBloc, ButtonState>(
              listener: _listenerResendEmail,
              builder: (context, state) {
                return RPVerificationLinkView(
                  title: 'Check your Inbox'.hardcoded,
                  subtitle:
                      'We have sent a link to $email with instructions to reset your password',
                  email: email,
                  onBack: _back,
                  onResend: _resend,
                  isLoading: state == const ButtonState.loading(),
                );
              },
            );
          },
        ),
      ],
    );
  }
}
