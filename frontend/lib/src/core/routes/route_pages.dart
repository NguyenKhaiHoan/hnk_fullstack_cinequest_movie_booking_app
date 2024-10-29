import 'package:cinequest/src/common/blocs/app/app_bloc.dart';
import 'package:cinequest/src/core/routes/route_enums.dart';
import 'package:cinequest/src/core/utils/page_transition_util.dart';
import 'package:cinequest/src/presentation/auth/pages/account_setup_page.dart';
import 'package:cinequest/src/presentation/auth/pages/login_page.dart';
import 'package:cinequest/src/presentation/auth/pages/reset_password_page.dart';
import 'package:cinequest/src/presentation/auth/pages/sign_up_page.dart';
import 'package:cinequest/src/presentation/auth/pages/splash_page.dart';
import 'package:cinequest/src/presentation/auth/pages/welcome_page.dart';
import 'package:cinequest/src/presentation/home/pages/home_page.dart';
import 'package:cinequest/src/presentation/location/pages/finding_location_page.dart';
import 'package:cinequest/src/presentation/location/pages/invalid_location_page.dart';
import 'package:cinequest/src/presentation/location/pages/select_location_page.dart';
import 'package:cinequest/src/presentation/navigation/pages/navigation_page.dart';
import 'package:cinequest/src/presentation/profile/pages/profile_page.dart';
import 'package:cinequest/src/presentation/setting/pages/setting_page.dart';
import 'package:cinequest/src/presentation/ticket/pages/ticket_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

final class RouterPages {
  factory RouterPages() => _instance;
  RouterPages._();

  static final RouterPages _instance = RouterPages._();

  static GoRouter router = GoRouter(
    debugLogDiagnostics: true,
    navigatorKey: _rootNavigatorKey,
    initialLocation: AppRoutes.splash.path,
    redirect: _guard,
    routes: [
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: AppRoutes.splash.path,
        builder: (context, state) => const SplashPage(),
        pageBuilder: PageTransitionUtil.customPageBuilder(
          child: const SplashPage(),
          fadeTransition: true,
        ),
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: AppRoutes.welcome.path,
        builder: (context, state) => const WelcomePage(),
        pageBuilder: PageTransitionUtil.customPageBuilder(
          child: const WelcomePage(),
          fadeTransition: true,
        ),
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: AppRoutes.login.path,
        builder: (context, state) => const LoginPage(),
        pageBuilder: PageTransitionUtil.customPageBuilder(
          child: const LoginPage(),
        ),
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: AppRoutes.signUp.path,
        builder: (context, state) => const SignUpPage(),
        pageBuilder: PageTransitionUtil.customPageBuilder(
          child: const SignUpPage(),
        ),
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: AppRoutes.welcome.path,
        builder: (context, state) => const FindingLocationPage(),
        pageBuilder: PageTransitionUtil.customPageBuilder(
          child: const FindingLocationPage(),
          fadeTransition: true,
        ),
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: AppRoutes.welcome.path,
        builder: (context, state) => const InvalidLocationPage(),
        pageBuilder: PageTransitionUtil.customPageBuilder(
          child: const InvalidLocationPage(),
          fadeTransition: true,
        ),
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: AppRoutes.selectLocation.path,
        builder: (context, state) => const SelectLocationPage(),
        pageBuilder: PageTransitionUtil.customPageBuilder(
          child: const SelectLocationPage(),
          direction: PageTransitionDirection.down,
        ),
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: AppRoutes.accountSetup.path,
        builder: (context, state) => const AccountSetupPage(),
        pageBuilder: PageTransitionUtil.customPageBuilder(
          child: const AccountSetupPage(),
        ),
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: AppRoutes.resetPassword.path,
        builder: (context, state) => const ResetPasswordPage(),
        pageBuilder: PageTransitionUtil.customPageBuilder(
          child: const ResetPasswordPage(),
        ),
      ),
      StatefulShellRoute.indexedStack(
        parentNavigatorKey: _rootNavigatorKey,
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.ticket.path,
                pageBuilder: PageTransitionUtil.customPageBuilder(
                  child: const TicketsPage(),
                  fadeTransition: true,
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.home.path,
                pageBuilder: PageTransitionUtil.customPageBuilder(
                  child: const HomePage(),
                  fadeTransition: true,
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.profile.path,
                pageBuilder: PageTransitionUtil.customPageBuilder(
                  child: const ProfilePage(),
                  fadeTransition: true,
                ),
              ),
            ],
          ),
        ],
        pageBuilder: (
          BuildContext context,
          GoRouterState state,
          StatefulNavigationShell navigationShell,
        ) =>
            PageTransitionUtil.buildPageWithFadeTransition(
          context: context,
          state: state,
          child: NavigationPage(
            child: navigationShell,
          ),
        ),
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: AppRoutes.setting.path,
        builder: (context, state) => const SettingPage(),
        pageBuilder: PageTransitionUtil.customPageBuilder(
          child: const SettingPage(),
          direction: PageTransitionDirection.right,
        ),
      ),
    ],
  );

  static String _path = '';

  static String get path => _path;

  static void refreshPath() {
    _path = '';
  }

  static String? _guard(BuildContext context, GoRouterState state) {
    // Đọc trạng thái xác thực của app
    final appAuthState = context.read<AppBloc>().state;

    // Cập nhật lại path sau mỗi lần điều hướng
    if (_path == '') {
      _path = state.uri.path;
    } else {
      _path += state.uri.path;
    }

    // Nếu chưa setup account thì trả về AccountSetupPage trong trường hợp
    // mở lại ứng dụng khi mới đăng ký xong chưa kịp setup
    if (appAuthState == const AppState.accountNotSetup() &&
        !_path.contains(AppRoutes.signUp.path)) {
      return AppRoutes.accountSetup.path;
    }
    // Nếu đã đăng nhập mà path hiện tại chưa chứa path của HomePage
    // thì trả về path của home page
    else if (appAuthState == const AppState.authenticated() &&
        !_path.contains(AppRoutes.home.path)) {
      return AppRoutes.home.path;
    }
    // Nếu chưa đăng nhập mà path hiện tại chưa chứa path của WelcomePage
    // thì trả về path của welcome page
    else if (appAuthState == const AppState.unauthenticated() &&
        !_path.contains(AppRoutes.welcome.path)) {
      return AppRoutes.welcome.path;
    }

    return null;
  }
}
