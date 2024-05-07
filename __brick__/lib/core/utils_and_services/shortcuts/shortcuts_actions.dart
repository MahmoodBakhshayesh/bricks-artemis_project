import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../initialize.dart';
import '../../navigation/navigation_service.dart';
import '../../navigation/route_names.dart';
import '../../navigation/router.dart';
import 'app_shortcuts.dart';

class SelectAllAction extends Action<SelectAllIntent> {
  SelectAllAction(this.model);

  final String model;

  @override
  void invoke(covariant SelectAllIntent intent) => log(model);
}

class ESCAction extends Action<ESCIntent> {
  final NavigationService navigationService = getIt<NavigationService>();
  final WidgetRef ref = getIt<WidgetRef>();

  ESCAction();

  @override
  void invoke(covariant ESCIntent intent) {

    String route = router.routerDelegate.currentConfiguration.last.route.path;
    RouteNames r = RouteNames.values.firstWhere((element) => element.title == route);
    log("ESC Pressed");
    if (navigationService.isDialogOpened) {
      print("Dialogs Are Detected Poping");
      navigationService.popDialog();
    } else {
    }
  }
}

