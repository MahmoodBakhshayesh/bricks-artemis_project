
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
  MyRouteInfo({
    required super.path,
    required super.name,
    required super.isShellRoute,
  });

}


abstract class Routes {
  static MyRouteInfo login = MyRouteInfo(
    path: '/',
    name: 'login',
    isShellRoute: false,
  );
  static MyRouteInfo home = MyRouteInfo(
    path: '/home',
    name: 'home',
    isShellRoute: false,
  );

  static List<RouteInfo> allRoutes = [
    login,
    home,
  ];
}
