part of '../sign_up_page.dart';

mixin _PageMixin on State<_Page> {
  late TextEditingController _emailTextEditingController;
  late TextEditingController _setPasswordTextEditingController;
  late TextEditingController _confirmPasswordTextEditingController;
  late TextEditingController _verificationCodeTextEditingController;
  final GlobalKey<FormState> _signUpFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _verificationCodeFormKey = GlobalKey<FormState>();

  final _pageController = PageController();

  @override
  void initState() {
    super.initState();
    _emailTextEditingController = TextEditingController();
    _setPasswordTextEditingController = TextEditingController();
    _confirmPasswordTextEditingController = TextEditingController();
    _verificationCodeTextEditingController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _emailTextEditingController.dispose();
    _setPasswordTextEditingController.dispose();
    _confirmPasswordTextEditingController.dispose();
    _verificationCodeTextEditingController.dispose();
  }

  void _signUp() {
    if (!_signUpFormKey.currentState!.validate()) {
      return;
    }
    context.read<ButtonBloc>().add(
          ButtonEvent.execute(
            useCase: sl<SignUpUseCase>(),
            params: SignUpParams(
              email: _emailTextEditingController.text.trim(),
              password: _setPasswordTextEditingController.text.trim(),
              confirmPassword:
                  _confirmPasswordTextEditingController.text.trim(),
            ),
          ),
        );
  }

  void _listenerSignUp(BuildContext context, ButtonState state) {
    state.whenOrNull(
      success: () {
        _pageController.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
        context.read<TimerBloc>().add(const TimerEvent.started(duration: 60));
      },
      failure: (failure) => ToastUtil.showToastError(context, failure.message),
    );
  }

  void _back() {
    _pageController.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _resend() {
    context.read<ButtonBloc>().add(
          ButtonEvent.execute(
            useCase: sl<ResendCodeUseCase>(),
            params: EmailParams(
              email: _emailTextEditingController.text.trim(),
            ),
          ),
        );
    context.read<TimerBloc>().add(const TimerEvent.reset());
  }

  Future<void> _verificateCode() async {
    if (!_verificationCodeFormKey.currentState!.validate()) {
      return;
    }
    context.read<ButtonBloc>().add(
          ButtonEvent.execute(
            useCase: sl<VerifyUserUseCase>(),
            params: VerifyUserParams(
              email: _emailTextEditingController.text.trim(),
              verificationCode:
                  _verificationCodeTextEditingController.text.trim(),
            ),
          ),
        );
  }

  void _listenerVerificateCode(BuildContext context, ButtonState state) {
    state.whenOrNull(
      success: () => context.go(AppRoutes.accountSetup.path),
      failure: (failure) => ToastUtil.showToastError(context, failure.message),
    );
  }

  void _changeEmail(String value) {
    context.read<SignUpBloc>().add(SignUpEvent.emailChanged(email: value));
  }

  void _changeSetPassword(String value) {
    context
        .read<SignUpBloc>()
        .add(SignUpEvent.setPasswordChanged(password: value));
  }

  void _changeConfirmPassword(String value) {
    context
        .read<SignUpBloc>()
        .add(SignUpEvent.confirmPasswordChanged(confirmPassword: value));
  }

  void _changeVerificationCode(String value) {
    context
        .read<SignUpBloc>()
        .add(SignUpEvent.verificationCodeChanged(verificationCode: value));
  }
}
