import 'package:cinequest/src/core/routes/route_enums.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PageTransitionUtil {
  PageTransitionUtil._();

  static Page<dynamic> Function(BuildContext, GoRouterState) customPageBuilder({
    required Widget child,
    PageTransitionDirection direction = PageTransitionDirection.left,
    bool fadeTransition = false,
  }) =>
      (BuildContext context, GoRouterState state) {
        return fadeTransition
            ? buildPageWithFadeTransition(
                context: context,
                state: state,
                child: child,
              )
            : buildPageWithDirectionTransition(
                context: context,
                state: state,
                child: child,
                direction: direction,
              );
      };

  static CustomTransitionPage<Widget> buildPageWithFadeTransition({
    required BuildContext context,
    required GoRouterState state,
    required Widget child,
  }) {
    return CustomTransitionPage(
      key: state.pageKey,
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) =>
          FadeTransition(opacity: animation, child: child),
    );
  }

  static CustomTransitionPage<Widget> buildPageWithDirectionTransition({
    required BuildContext context,
    required GoRouterState state,
    required Widget child,
    required PageTransitionDirection direction,
  }) {
    return CustomTransitionPage(
      key: state.pageKey,
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) =>
          SlideTransition(
        position:
            Tween<Offset>(begin: _getBeginOffset(direction), end: Offset.zero)
                .animate(animation),
        child: child,
      ),
    );
  }

  static Offset _getBeginOffset(PageTransitionDirection direction) {
    switch (direction) {
      case PageTransitionDirection.up:
        return const Offset(0, 1);
      case PageTransitionDirection.left:
        return const Offset(1, 0);
      case PageTransitionDirection.right:
        return const Offset(-1, 0);
      case PageTransitionDirection.down:
        return const Offset(0, -1);
    }
  }
}
