import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'route_names.dart';
import 'router_notifier.dart';

final rootRouterKey = GlobalKey<NavigatorState>(debugLabel: 'routerKey');

/// This simple provider caches our GoRouter.
final routerProvider = Provider.autoDispose<GoRouter>((ref) {
  final notifier = ref.watch(routerNotifierProvider.notifier);

  return GoRouter(
    navigatorKey: rootRouterKey,
    refreshListenable: notifier,
    observers:  [BotToastNavigatorObserver()],
    debugLogDiagnostics: false,
    initialLocation: RouteNames.login.path,
    routes: notifier.routes,
    redirect: notifier.redirect,
  );
});