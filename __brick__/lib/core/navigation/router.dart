import 'package:bot_toast/bot_toast.dart';
import '../../core/interfaces/device_info_service_int.dart';
import '../../core/utils_and_services/app_data.dart';
import '../../screens/home/home_view_desktop.dart';
import '../../screens/login/login_view_desktop.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../screens/home/home_view_phone.dart';
import '../../screens/home/home_view_tablet.dart';
import '../../screens/login/login_view_phone.dart';
import '../../screens/login/login_view_tablet.dart';
import 'route_names.dart';
import 'router_notifier.dart';

final rootRouterKey = GlobalKey<NavigatorState>(debugLabel: 'routerKey');

/// This simple provider caches our GoRouter.
// final routerProvider = Provider.autoDispose<GoRouter>((ref) {
//   final notifier = ref.watch(routerNotifierProvider.notifier);
//
//   return GoRouter(
//     navigatorKey: rootRouterKey,
//     refreshListenable: notifier,
//     observers:  [BotToastNavigatorObserver()],
//     debugLogDiagnostics: false,
//     initialLocation: RouteNames.login.path,
//     routes: notifier.routes,
//     redirect: notifier.redirect,
//   );
// });
final router =  GoRouter(
    navigatorKey: rootRouterKey,
    observers:  [BotToastNavigatorObserver()],
    debugLogDiagnostics: false,
    initialLocation: RouteNames.login.path,
    routes:routes,
  );

List<GoRoute> get routes => [
    GoRoute(
        name: RouteNames.login.name,
        path: RouteNames.login.path,
        pageBuilder: (context, state) {
            if(AppData.deviceType.isPhone)  return NoTransitionPage<void>(key: state.pageKey, child: const LoginViewPhone());
            if(AppData.deviceType.isTablet)  return NoTransitionPage<void>(key: state.pageKey, child: const LoginViewTablet());
            return NoTransitionPage<void>(key: state.pageKey, child: const LoginViewDesktop());
        },
    ),
    GoRoute(
        name: RouteNames.home.name,
        path: RouteNames.home.path,
        pageBuilder: (context, state) {
            if(AppData.deviceType.isPhone)  return NoTransitionPage<void>(key: state.pageKey, child: const HomeViewPhone());
            if(AppData.deviceType.isTablet)  return NoTransitionPage<void>(key: state.pageKey, child: const HomeViewTablet());
            return NoTransitionPage<void>(key: state.pageKey, child: const HomeViewDesktop());
        },
    ),
];