// import 'dart:developer';
//
// import 'package:flutter/cupertino.dart';
// import 'package:get_it/get_it.dart';
// import 'package:go_router/go_router.dart';
//
// import '../interfaces/navigation_int.dart';
// import 'routes.dart';
//
// class MyNavigationObserver extends NavigatorObserver {
//   RouteName? _findRouteByName({required String routeName}) {
//     int index = RouteName.values.indexWhere((element) => element.name == routeName);
//     if (index < 0) {
//       return null;
//     }
//     return RouteName.values[index];
//   }
//
//   @override
//   void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
//     RouteName? routeName = _findRouteByName(routeName: route.settings.name ?? '');
//     RouteName? previousRouteName = _findRouteByName(routeName: previousRoute?.settings.name ?? '');
//     NavigationInterface navigation = GetIt.instance<NavigationInterface>();
//     if (routeName != null) {
//       navigation.previousRoute = previousRouteName;
//       WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
//         navigation.initializeRoute(
//           routeName,
//           addToStack: !routeName.isShellRoute,
//         );
//       });
//       log('Pushing to ${routeName.name} from ${previousRoute?.settings.name}');
//     }
//   }
//
//   @override
//   void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
//     RouteName? routeName = _findRouteByName(routeName: route.settings.name ?? '');
//     if (routeName != null) {
//       WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
//         NavigationInterface navigation = GetIt.instance<NavigationInterface>();
//         RouteName? previousRouteName = _findRouteByName(routeName: previousRoute?.settings.name ?? '');
//         navigation.disposeRoute(previousRoute: previousRouteName, poppedRoute: routeName);
//       });
//       log('Popping to ${previousRoute?.settings.name} from ${routeName.name}');
//     }
//   }
//
//   @override
//   void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
//     RouteName? routeName = _findRouteByName(routeName: route.settings.name ?? '');
//
//     if (routeName != null) {
//       WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
//         NavigationInterface navigation = GetIt.instance<NavigationInterface>();
//         RouteName? previousRouteName = _findRouteByName(routeName: previousRoute?.settings.name ?? '');
//         if (routeName.isShellRoute) {
//           //disposing children of the shell route because they are not disposed automatically.
//           navigation.stack.sublist(0, navigation.stack.length - 1).reversed.forEach((element) {
//             navigation.registeredControllers[element]?.onDispose();
//           });
//           //keeping the last element in the stack because it is the new page that is navigated to.
//           navigation.stack = [navigation.stack.last];
//         }
//         navigation.disposeRoute(
//           previousRoute: previousRouteName,
//           poppedRoute: routeName,
//           updateStack: !routeName.isShellRoute,
//         );
//       });
//       log('Removing ${routeName.name}, previous is ${previousRoute?.settings.name}');
//     }
//   }
//
//   _disposeSubtreeOf(RouteBase routeBase) {
//     for (RouteBase element in routeBase.routes) {
//       if (element is GoRoute && element.name != null) {
//         RouteName? childRouteName = _findRouteByName(routeName: element.name!);
//         if (childRouteName != null) {
//           NavigationInterface navigation = GetIt.instance<NavigationInterface>();
//           try {
//             navigation.registeredControllers[childRouteName]?.onDispose();
//           } catch (e) {
//             log('Could not dispose controller of ${childRouteName.name}');
//           }
//         }
//       }
//       _disposeSubtreeOf(element);
//     }
//   }
//
//   @override
//   void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
//     log('in didReplace: $newRoute previous route : $oldRoute');
//   }
//
//   @override
//   void didStartUserGesture(Route<dynamic> route, Route<dynamic>? previousRoute) {
//     log('in didStartUserGesture: $route previous route : $previousRoute');
//   }
//
//   @override
//   void didStopUserGesture() {
//     log('in didStopUserGesture');
//   }
// }
