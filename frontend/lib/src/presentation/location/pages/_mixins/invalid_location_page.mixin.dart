part of '../invalid_location_page.dart';

mixin _PageMixin on State<_Page> {
  late final Future<LottieComposition> _composition;

  @override
  void initState() {
    super.initState();
    _composition = AssetLottie(AppConstant.invalidLocationAnimationPath).load();
  }

  Future<void> _resetLocation() async {
    // context.read<ButtonBloc>().add(ButtonEvent.execute(useCase: useCase));
  }

  void _listenerResetLocationButton(
    BuildContext context,
    LocationState state,
  ) {
    state.whenOrNull(
      success: (location) async =>
          context.read<AppBloc>().add(const AppEvent.started()),
    );
  }
}
