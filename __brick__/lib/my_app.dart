import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '/screens/home/home_view.dart';
import '/screens/login/login_view.dart';
import 'package:tree_navigation/tree_navigation.dart';
import 'core/constants/ui.dart';
import 'core/navigation/routes.dart';
import 'initialize.dart';

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  void initState() {
    getIt.registerSingleton(ref);
    initNavigation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final router = ref.watch(routerProvider);
    return TreeNavigation.makeMaterialApp(
        theme: MyTheme.lightAbomis(context),
        debugLogDiagnostics: true,
        routeInfoList: Routes.allRoutes,
        routes: [
          TreeRoute(routeInfo: Routes.login, pageWidget: LoginView()),
          TreeRoute(routeInfo: Routes.home, pageWidget: HomeView()),
        ],
        navigatorKey: topKey,
        observers: [BotToastNavigatorObserver()],
        globalKeyList: [topKey, shellKey]
    );
  }
}
