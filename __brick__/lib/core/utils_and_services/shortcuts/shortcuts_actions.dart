import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tree_navigation/tree_navigation.dart';
import '../../../initialize.dart';
import 'app_shortcuts.dart';

class SelectAllAction extends Action<SelectAllIntent> {
  SelectAllAction(this.model);

  final String model;

  @override
  void invoke(covariant SelectAllIntent intent) => log(model);
}

class ESCAction extends Action<ESCIntent> {
  final navigationService = GetIt.instance<NavigationInterface>();

  final WidgetRef ref = getIt<WidgetRef>();

  ESCAction();

  @override
  void invoke(covariant ESCIntent intent) {

    final r = navigationService.currentRoute!;
    log("ESC Pressed");
    if (navigationService.isDialogOpen) {
      navigationService.pop();
    } else {
    }
  }
}

