part of '../setting_page.dart';

mixin SettingPageMixin on State<SettingPage> {
  void _signOut(BuildContext context) {
    // context.read<ButtonBloc>().add(
    //       ButtonEvent.execute(
    //         useCase: sl<SignOutUseCase>(),
    //         params: NoParams(),
    //       ),
    //     );
  }

  void _listener(BuildContext context, ButtonState state) {
    state.whenOrNull(
      failure: (failure) => ToastUtil.showToastError(context, failure.message),
      success: () => context.read<AppBloc>().add(const AppEvent.started()),
    );
  }
}
