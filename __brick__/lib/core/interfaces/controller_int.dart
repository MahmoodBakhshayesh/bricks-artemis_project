import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tree_navigation/tree_navigation.dart';
import '../interface_implementations/shared_preferences_imp.dart';
import '../navigation/routes.dart';
import '../utils_and_services/drawers/lib/anydrawer.dart';
import 'shared_preferences_int.dart';

import 'package:tree_navigation/tree_navigation.dart' as tree;

GlobalKey scaffoldMessageKey = GlobalKey<ScaffoldMessengerState>();

class ControllerInterface extends tree.ControllerInterface {
  AnyDrawerController drawerController = AnyDrawerController();

  late SharedPreferencesImp sharedPref;
  late WidgetRef ref;

  ControllerInterface() {
    sharedPref = GetIt.instance<SharedPreferencesImp>();
    ref = GetIt.instance<WidgetRef>();

    if (!initialized) {
      onCreate();
    }
  }

  Future<dynamic> goNamed(
      MyRouteInfo route, {
        Map<String, String> pathParameters = const <String, String>{},
        Map<String, dynamic> queryParameters = const <String, dynamic>{},
        Object? extra,
      }) {
    if (route.getView(navigation.context).runtimeType.toString() == "ScreenDialog") {
      return navigation.openDialog(dialog: route.getView(navigation.context));
    } else {
      return navigation.goNamed(route, pathParameters: pathParameters, queryParameters: queryParameters, extra: extra);
    }
  }

  openDrawer(BuildContext context,Widget content){
    showDrawer(
      navigation.context,
      builder: (context) {
        return content;
      },
      config:  const DrawerConfig(
        side: DrawerSide.left,
        closeOnClickOutside: true,
        closeOnEscapeKey: true,
        closeOnResume: true, // (Android only)
        closeOnBackButton: true, // (Requires a route navigator)
        backdropOpacity: 0.4,
        borderRadius: 24,
      ),
      controller: drawerController, // Optional controller to programmatically close the drawer
    );
  }

  openEndDrawer(BuildContext context,Widget content){
    showDrawer(
      context,
      builder: (context) {
        return content;
      },
      config:  const DrawerConfig(
        side: DrawerSide.right,
        closeOnClickOutside: true,
        closeOnEscapeKey: true,
        closeOnResume: true, // (Android only)
        closeOnBackButton: true, // (Requires a route navigator)
        backdropOpacity: 0.4,
        borderRadius: 24,
      ),
      controller: drawerController, // Optional controller to programmatically close the drawer
    );
  }


}
