part of '../home_page.dart';

mixin _PageMixin on State<_Page> {
  void _selectLocation() {
    context.push(AppRoutes.selectLocation.path);
  }
}
