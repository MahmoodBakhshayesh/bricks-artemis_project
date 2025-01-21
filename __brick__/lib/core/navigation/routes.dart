
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/context_extensions.dart';
import 'package:go_router/go_router.dart';
import 'package:tree_navigation/tree_navigation.dart';
import '../../screens/home/home_view_desktop.dart';
import '../../screens/home/home_view_phone.dart';
import '../../screens/home/home_view_tablet.dart';
import '../../screens/login/login_view_desktop.dart';
import '../../screens/login/login_view_phone.dart';
import '../../screens/login/login_view_tablet.dart';
import '../../core/extenstions/context_exp.dart';

GlobalKey<NavigatorState> topKey = GlobalKey<NavigatorState>();
GlobalKey<NavigatorState> shellKey = GlobalKey<NavigatorState>();

class MyRouteInfo extends RouteInfo {
  final Widget phoneView;
  final Widget desktopView;
  final Widget tabletView;

  MyRouteInfo({
    required super.path,
    required super.name,
    required super.isShellRoute,
    required this.desktopView,
    required this.tabletView,
    required this.phoneView,
  });

  Widget get view => Platform.isAndroid || Platform.isIOS ? phoneView : desktopView;

  Page<dynamic> builder(BuildContext context, GoRouterState state) => MyCustomTransitionPage(
      name: name,
      key: state.pageKey,
      child: view,
      transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
        if(context.isMyTablet){
          return tabletView;
        }
        return view;
      });

  Widget getView(BuildContext context) {
    if(context.isDesktop){
      return desktopView;
    }
    if(context.isMyTablet){
      return tabletView;
    }
    return view;
  }
}


abstract class Routes {
  static MyRouteInfo login = MyRouteInfo(
    path: '/',
    name: 'login',
    isShellRoute: false,
    desktopView: const LoginViewDesktop(),
    tabletView: const LoginViewTablet(),
    phoneView: const LoginViewPhone(),
  );
  static MyRouteInfo home = MyRouteInfo(
    path: '/home',
    name: 'home',
    isShellRoute: false,
    desktopView: const HomeViewDesktop(),
    tabletView: const HomeViewTablet(),
    phoneView: const HomeViewPhone(),
  );

  static List<RouteInfo> allRoutes = [
    login,
    home,
  ];
}
