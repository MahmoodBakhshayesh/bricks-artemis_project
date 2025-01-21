import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:tree_navigation/tree_navigation.dart';
import '../../../initialize.dart';
import '../../interfaces/warning_int.dart';

abstract class WarningHandler {
  static final navigationService = GetIt.instance<NavigationInterface>();
  static get context => navigationService.context;
  static void handle(Warning warning,{Function? retry}) {
    navigationService.openSnackBar(SnackBar(content: GestureDetector(
        onTap: (){
          // AppB
        },
        child: Text(warning.msg)),
        backgroundColor: Colors.orange,
        duration: const Duration(seconds: 1),
        margin: EdgeInsets.only(
          left: 12,
          bottom: 12,
          right: MediaQuery.of(navigationService.context).size.width*0.5,
        )
    ));
  }

  static void handleNoElement(String name) {
    navigationService.openSnackBar(SnackBar(content: Text("Could not Find $name"),
      backgroundColor: Colors.orange,
      duration: const Duration(seconds: 5),
    ));
  }
}
