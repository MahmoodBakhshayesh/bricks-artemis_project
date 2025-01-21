import 'dart:developer';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:masonCheck/core/utils_and_services/app_config.dart';
import '../../initialize.dart';
import '../../screens/home/home_view_desktop.dart';
import '../../screens/home/home_view_phone.dart';
import '../../screens/home/home_view_tablet.dart';
import '../../screens/login/login_state.dart';
import '../../screens/login/login_view_desktop.dart';
import '../../screens/login/login_view_phone.dart';
import '../../screens/login/login_view_tablet.dart';
import '../classes/user_class.dart';
import '../interfaces/navigation_int.dart';
import '../interfaces/shared_preferences_int.dart';
import '../utils_and_services/app_data.dart';
import '../utils_and_services/cookie_manager.dart';
import 'my_navigation_observer.dart';
import 'routes.dart';

final navigationKey = GlobalKey<NavigatorState>(debugLabel: 'navigationKey');
final wrapperKey = GlobalKey<NavigatorState>(debugLabel: 'wrapperKey');
final wrapper2Key = GlobalKey<NavigatorState>(debugLabel: 'wrapper2Key');

Page<dynamic> loginPageBuilder(BuildContext context, GoRouterState state) {
  return CustomTransitionPage(
    key: state.pageKey,
    name: RouteName.login.name,
    child: AppData.isPhone
        ? const LoginViewPhone()
        : AppData.isDesktop
        ? const LoginViewDesktop()
        : const LoginViewTablet(),
    transitionsBuilder: (context, animation1, animation2, child) => FadeTransition(
      opacity: animation1,
      child: child,
    ),
  );
}

Page<dynamic> homePageBuilder(BuildContext context, GoRouterState state) {
  return CustomTransitionPage(
    key: state.pageKey,
    name: RouteName.home.name,
    child: AppData.isPhone
        ? const HomeViewPhone()
        : AppData.isDesktop
        ? const HomeViewDesktop()
        : const HomeViewTablet(),
    transitionsBuilder: (context, animation1, animation2, child) => FadeTransition(
      opacity: animation1,
      child: child,
    ),
  );
}

Future<String?> _getToken() async {
  if (AppData.isWeb) {
    return CookieManager.getCookie(key: 'token');
  } else {
    SharedPreferencesInterface sp = GetIt.instance<SharedPreferencesInterface>();
    return await sp.getVariable(key: 'token');
  }
}

final router = GoRouter(
  navigatorKey: navigationKey,
  redirect: (context, state) async {
    User? user = getIt<WidgetRef>().read(userProvider);
    if (user != null) {
      AppData.setToken(user.token);
    } else if (state.fullPath != '/') {
      return RouteName.login.path;
    }
    return null;
  },
  debugLogDiagnostics: true,
  routes: [
    GoRoute(
      name: RouteName.login.name,
      path: RouteName.login.path,
      pageBuilder: loginPageBuilder,
    ),
    GoRoute(
      name: RouteName.home.name,
      path: RouteName.home.path,
      pageBuilder: homePageBuilder,
    ),
  ],
  initialLocation: '/',
  observers: [MyNavigationObserver(), BotToastNavigatorObserver()],
);
