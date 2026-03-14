import 'package:flutter/material.dart';

class AppRoutes {
  static final rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'rootNavigator');

  static BuildContext? get rootContext => rootNavigatorKey.currentContext;
  static const home = '/login';

}
