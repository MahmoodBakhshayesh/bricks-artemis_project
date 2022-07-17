import 'dart:developer';
import 'package:flutter/material.dart';
import '../../constants/route_names.dart';
import '../../dependency_injection.dart';
import '../../navigation/navigation_service.dart';
import '../../navigation/router.dart';
import 'app_shortcuts.dart';

class SelectAllAction extends Action<SelectAllIntent> {
  SelectAllAction(this.model);

  final String model;

  @override
  void invoke(covariant SelectAllIntent intent) => print(model);
}

class ESCAction extends Action<ESCIntent> {
  final NavigationService navigationService = getIt<NavigationService>();
  ESCAction();

  @override
  void invoke(covariant ESCIntent intent) {
    if(MyRouter.currentRouteStack.last.name==RouteNames.login){
      /// do stuff here
    }
    log("ESC Pressed 2");
  }
}


