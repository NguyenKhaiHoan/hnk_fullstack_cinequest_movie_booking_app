import 'package:cinequest/src/core/routes/route_enums.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

/// Quản lý tuyến đường trong App
final class RouterPages {
  /// Trả về instance duy nhất
  factory RouterPages() => _instance;
  RouterPages._();

  static final RouterPages _instance = RouterPages._();

  /// Khởi tạo router
  static GoRouter router = GoRouter(
    debugLogDiagnostics: true,
    navigatorKey: _rootNavigatorKey,
    initialLocation: AppRoutes.splash.path,
    redirect: _guard,
    routes: [],
  );

  static String _path = '';

  static String get path => _path;

  static void refreshPath() {
    _path = '';
  }

  static String? _guard(BuildContext context, GoRouterState state) {
    // Cập nhật lại path sau mỗi lần điều hướng
    if (_path == '') {
      _path = state.uri.path;
    } else {
      _path += state.uri.path;
    }

    return null;
  }
}
