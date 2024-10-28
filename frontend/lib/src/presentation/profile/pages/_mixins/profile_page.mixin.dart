part of '../profile_page.dart';

mixin _PageMixin on State<_Page> {
  void _moveToSettingPage() {
    context.push(AppRoutes.setting.path);
  }
}
