part of '../finding_location_page.dart';

mixin _PageMixin on State<_Page> {
  late final Future<LottieComposition> _composition;

  @override
  void initState() {
    super.initState();
    _composition = AssetLottie(AppConstant.findingLocationAnimationPath).load();
  }
}
