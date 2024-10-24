part of '../reset_password_page.dart';

mixin _PageMixin on State<_Page> {
  late TextEditingController _emailTextEditingController;
  final GlobalKey<FormState> _resetPasswordFormKey = GlobalKey<FormState>();

  final _pageController = PageController();

  @override
  void initState() {
    super.initState();
    _emailTextEditingController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _emailTextEditingController.dispose();
  }

  Future<void> _send() async {
    if (!_resetPasswordFormKey.currentState!.validate()) {
      return;
    }
    FocusScope.of(context).unfocus();
    context.read<ButtonBloc>().add(
          ButtonEvent.execute(
            useCase: sl<ForgotPasswordUseCase>(),
            params: EmailParams(
              email: _emailTextEditingController.text.trim(),
            ),
          ),
        );
  }

  void _listenerSendEmail(BuildContext context, ButtonState state) {
    state.whenOrNull(
      failure: (failure) => ToastUtil.showToastError(context, failure.message),
      success: () async => _next(),
    );
  }

  void _listenerResendEmail(BuildContext context, ButtonState state) {
    state.whenOrNull(
      failure: (failure) => ToastUtil.showToastError(context, failure.message),
      success: () async => _back(),
    );
  }

  void _back() {
    _pageController.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _next() {
    _pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _resend() {
    context.read<ButtonBloc>().add(
          ButtonEvent.execute(
            useCase: sl<ForgotPasswordUseCase>(),
            params: EmailParams(
              email: _emailTextEditingController.text.trim(),
            ),
          ),
        );
  }

  void _changeEmail(String value) {
    context
        .read<ResetPasswordBloc>()
        .add(ResetPasswordEvent.emailChanged(email: value));
  }
}
