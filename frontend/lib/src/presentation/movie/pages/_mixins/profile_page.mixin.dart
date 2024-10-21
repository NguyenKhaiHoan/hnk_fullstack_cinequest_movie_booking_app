part of '../profile_page.dart';

/// Mixin của ProfilePage xử lý logic UI
mixin ProfilePageMixin on State<ProfilePage> {
  void _moveToSettingPage() {
    context.push(AppRoutes.setting.path);
  }
}
