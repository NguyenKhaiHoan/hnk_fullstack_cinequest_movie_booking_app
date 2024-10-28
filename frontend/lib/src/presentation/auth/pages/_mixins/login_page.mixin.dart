part of '../login_page.dart';

mixin _PageMixin on State<_Page> {
  late TextEditingController _emailTextEditingController;
  late TextEditingController _setPasswordTextEditingController;
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _emailTextEditingController = TextEditingController();
    _setPasswordTextEditingController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _emailTextEditingController.dispose();
    _setPasswordTextEditingController.dispose();
  }

  Future<void> _login() async {
    if (!_loginFormKey.currentState!.validate()) {
      return;
    }
    context.read<ButtonBloc>().add(
          ButtonEvent.execute(
            useCase: sl<LoginUseCase>(),
            params: LoginParams(
              email: _emailTextEditingController.text.trim(),
              password: _setPasswordTextEditingController.text.trim(),
            ),
          ),
        );
  }

  void _listener(BuildContext context, ButtonState state) {
    state.whenOrNull(
      failure: (failure) => ToastUtil.showToastError(context, failure.message),
      success: () {
        // Nếu đăng nhập thành công thì chạy event này để cập nhật lại
        // trạng thái xác thực của app và sử dụng điều hướng của go router
        context.read<AppBloc>().add(const AppEvent.started());
      },
    );
  }

  void _changeEmail(String value) {
    context.read<LoginBloc>().add(LoginEvent.emailChanged(email: value));
  }

  void _changeSetPassword(String value) {
    context.read<LoginBloc>().add(
          LoginEvent.setPasswordChanged(password: value),
        );
  }
}
