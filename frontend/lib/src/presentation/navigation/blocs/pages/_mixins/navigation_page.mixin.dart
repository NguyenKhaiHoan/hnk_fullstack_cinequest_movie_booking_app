part of '../navigation_page.dart';

/// Mixin của NavigationPage để xử lý logic UI
mixin NavigationPageMixin on State<NavigationPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showBottomSheet();
    });
  }

  void _showBottomSheet() {
    if (RouterPages.path.contains(AppRoutes.accountSetup.path)) {
      BottomSheetUtil.showSucessSignUp(context);
    }
  }
}
