import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../screens/login/login_state.dart';
import '../../screens/login/login_view.dart';
import '../../screens/login/login_view_phone.dart';
import '../../screens/login/login_view_tablet.dart';
import '../constants/route_names.dart';
import '../dependency_injection.dart';
import '../platform/device_info.dart';

class MyRouter {
  MyRouter._();

  static final MyRouter _instance = MyRouter._();

  factory MyRouter() => _instance;
  static late GoRouter _router;
  static late List<MyRoute> _routes;

  static void initialize() {
    _routes = <MyRoute>[
      MyRoute(
        showInMainRoute: false,
        name: RouteNames.login,
        path: '/login',
        title: 'Login',
        builder:(BuildContext context, GoRouterState state) {
          switch(DeviceInfo.deviceType(context)){
            case DeviceType.phone:
              return LoginViewPhone();
            case DeviceType.tablet:
              return LoginViewTablet();
            case DeviceType.desktop:
              return LoginView();
          }

        },
      ),

    ];
    _router = GoRouter(
      initialLocation: '/cuppsScreen',
      refreshListenable: getIt<LoginState>(),
      routes: _routes,
      redirect: (_,state) {
        LoginState loginState = getIt<LoginState>();
        // if the user is not logged in, they need to login
        final loggedIn = loginState.user != null;
        final loggingIn = state.subloc == '/login';
        if (!loggedIn) return loggingIn ? null : '/login';

        // if the user is logged in but still on the login page, send them to
        // the home page
        if (loggingIn) return '/';

        // no need to redirect at all
        return null;
      },
    );
  }

  static List<String> get currentRouteTitles {
    String cp = _router.location;
    List<String> split = cp.split("/").where((element) => !element.startsWith(":")).toList();
    List<MyRoute> crl = [];
    for (var r in _routes) {
      if (split.contains(r.path.replaceFirst("/", ""))) {
        crl.add(r);
        for (var r2 in r.routes) {
          if (split.contains(r2.path.split("/").first)) {
            crl.add(r2);
            for (var r3 in r2.routes) {
              if (split.contains(r3.path.split("/").first)) {
                crl.add(r3);
                for (var r4 in r3.routes) {
                  if (split.contains(r4.path.split("/").first)) {
                    crl.add(r4);
                    for (var r5 in r4.routes) {
                      if (split.contains(r5.path.split("/").first)) {
                        crl.add(r5);
                        for (var r6 in r5.routes) {
                          if (split.contains(r6.path.split("/").first)) {
                            crl.add(r6);
                          }
                        }
                      }
                    }
                  }
                }
              }
            }
          }
        }
      }
    }

    return crl.map((e) => e.title).toList();
    // print(crl.map((e) => e.title));

    // _routes.forEach((r) {
    //   print(r.path);
    //   r.routes.forEach((rr) {
    //     String match = (r.path + '/' + rr.path).split(":")[0];
    //     print(match);
    //   });
    // });
    // print(_router.location);
    // print(routes[1].getAllSubs.keys);
    if (_routes.any((r) => r.getAllSubs.keys.any((e) => _router.location.startsWith(e)))) {
      MyRoute r = _routes.firstWhere((r) => r.getAllSubs.keys.any((e) => _router.location.startsWith(e)));
      String m = r.getAllSubs.keys.lastWhere((e) => _router.location.startsWith(e));
      MyRoute rr = r.getAllSubs[m]!;
      // print(r.getAllSubs.any((e)=>_router.location.startsWith(e)))
      // return m.split("/").where((element) => element.isNotEmpty).toList();
      return [r.title, rr.title];
    } else if (_routes.any((r) => r.path == _router.location)) {
      MyRoute myRoute = _routes.firstWhere((r) => r.path == _router.location);
      return [myRoute.title];
    } else {
      return [""];
    }
  }

  static List<MyRoute> get currentRouteStack {
    String cp = _router.location;
    List<String> split = cp.split("/").where((element) => !element.startsWith(":")).toList();
    List<MyRoute> crl = [];
    for (var r in _routes) {
      if (split.contains(r.path.replaceFirst("/", ""))) {
        crl.add(r);
        for (var r2 in r.routes) {
          if (split.contains(r2.path.split("/").first)) {
            crl.add(r2);
            for (var r3 in r2.routes) {
              if (split.contains(r3.path.split("/").first)) {
                crl.add(r3);
                for (var r4 in r3.routes) {
                  if (split.contains(r4.path.split("/").first)) {
                    crl.add(r4);
                    for (var r5 in r4.routes) {
                      if (split.contains(r5.path.split("/").first)) {
                        crl.add(r5);
                        for (var r6 in r5.routes) {
                          if (split.contains(r6.path.split("/").first)) {
                            crl.add(r6);
                          }
                        }
                      }
                    }
                  }
                }
              }
            }
          }
        }
      }
    }

    return crl;
  }

  static List<String> get getTitles {
    List<String> titles = _routes.where((element) => element.showInMainRoute).map((r) => r.title).toList();
    return titles;
  }

  static GoRouter get router => _router;

  static List<MyRoute> get routes => _routes;

  // static BuildContext get context => _router.navigator!.context;
  static BuildContext get context => _router.routeConfiguration.navigatorKey.currentState!.context;
}

class MyRoute extends GoRoute {
  final String title;
  final String name;
  final Widget Function(BuildContext, GoRouterState) builder;
  final List<MyRoute> routes;
  final bool showInMainRoute;

  MyRoute(
      {required String path,
      required this.title,
      required this.name,
      required this.builder,
      this.routes = const [],
      this.showInMainRoute = true})
      : super(
          path: path,
          name: name,
          builder: builder,
          routes: routes,
          pageBuilder: (context, state) => NoTransitionPage<void>(key: state.pageKey, child: builder(context, state)),
        );

  Map<String, MyRoute> get getAllSubs {
    Map<String, MyRoute> matches = {title: this};
    for (var rr in routes) {
      String match = (path + '/' + rr.path).split(":")[0];
      matches.putIfAbsent(match, () => rr);
      for (var rrr in rr.routes) {
        String match2 = (path + '/' + rr.path + "/" + rrr.path).split(":")[0];
        matches.putIfAbsent(match2, () => rrr);
      }
      // print(match);
    }
    return matches;
  }
}
