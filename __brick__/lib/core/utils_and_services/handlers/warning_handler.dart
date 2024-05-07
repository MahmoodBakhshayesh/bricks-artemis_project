import 'package:flutter/material.dart';
import '../../../initialize.dart';
import '../../interfaces/warning_int.dart';
import '../../navigation/navigation_service.dart';

abstract class WarningHandler {
  static final NavigationService navigationService = getIt<NavigationService>();

  static void handle(Warning warning,{Function? retry}) {
    navigationService.snackbar(GestureDetector(
        onTap: (){
          // AppB
        },
        child: Text(warning.msg)),
        icon: Icons.warning,
        backgroundColor: Colors.orange,
        duration: const Duration(seconds: 1),
        margin: EdgeInsets.only(
          left: 12,
          bottom: 12,
          right: MediaQuery.of(navigationService.context).size.width*0.5,
        )
    );
  }

  static void handleNoElement(String name) {
    navigationService.snackbar(Text("Could not Find $name"),
      icon: Icons.error,
      backgroundColor: Colors.orange,
      duration: const Duration(seconds: 5),
    );
  }
}
