import 'dart:async';
import 'package:flutter/material.dart';

import '../interfaces/controller.dart';
import 'router.dart';

class NavigationService {
  final NavigationMode mode;
  final Map<String, MainController> _registeredControllers = {};
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  final MyRouter router = MyRouter();

  NavigationService({this.mode = NavigationMode.goRouter});

  Future<dynamic> pushNamed(String routeName, {Map<String,String>? arguments}) {
    if (_registeredControllers.containsKey(routeName)) {
      _registeredControllers[routeName]!.onInit();
    }
    if (mode == NavigationMode.goRouter) {
      MyRouter.router.pushNamed(routeName,params: arguments??{});
      return Future.value(null);
    } else {
      return navigatorKey.currentState!.pushNamed(routeName, arguments: arguments);
    }
  }

  Future<dynamic> popAndTo(String routeName, {Map<String,String>? arguments}) {
    if (_registeredControllers.containsKey(routeName)) {
      _registeredControllers[routeName]!.onInit();
    }
    if (mode == NavigationMode.goRouter) {
      MyRouter.router.goNamed(routeName,params: arguments??{});
      return Future.value(null);
    } else {
      return navigatorKey.currentState!.popAndPushNamed(routeName, arguments: arguments);
    }
  }

  void goBack({dynamic result}) {
    if (mode == NavigationMode.goRouter) {
      MyRouter.router.pop();
    } else {
      return navigatorKey.currentState!.pop(result);
    }
  }

  void goToName(String routeName, {Map<String,String>? arguments}) {
    if (_registeredControllers.containsKey(routeName)) {
      _registeredControllers[routeName]!.onInit();
    }
    if (mode == NavigationMode.goRouter) {
      MyRouter.router.goNamed(routeName,params: arguments??{});
    } else {
      navigatorKey.currentState!.pushNamedAndRemoveUntil(routeName,(_)=>false,arguments: arguments);
    }
  }

  BuildContext? get context => mode == NavigationMode.goRouter ? MyRouter.context : navigatorKey.currentState?.context;

  Future<dynamic> dialog(Widget content) {
    return showDialog(context: context!, builder: (c) => content);
  }

  snackbar(Widget content, {Color? backgroundColor, SnackBarAction? action, Duration? duration, IconData? icon}) {
    ScaffoldMessenger.of(context!).clearSnackBars();
    ScaffoldMessenger.of(context!).showSnackBar(SnackBar(
      content: icon == null
          ? content
          : Row(
              children: [Icon(icon), const SizedBox(width: 8), Expanded(child: content)],
            ),
      backgroundColor: backgroundColor,
      action: action,
      duration: duration ?? const Duration(seconds: 3),
    ));
  }

  registerController(String name, MainController controller) {
    _registeredControllers.putIfAbsent(name, () => controller);
  }

  void popDialog([dynamic result]) {
    Navigator.pop(context!,result);
  }
}

enum NavigationMode { version1, goRouter }
