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
    await _pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _back() {
    _pageController.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _resend() {}

  void _changeEmail(String value) {
    context
        .read<ResetPasswordBloc>()
        .add(ResetPasswordEvent.emailChanged(email: value));
  }
}
