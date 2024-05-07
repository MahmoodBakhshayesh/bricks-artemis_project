import 'package:artemis_ui_kit/artemis_ui_kit.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import '../../../initialize.dart';
import '../../interfaces/success_int.dart';
import '../../navigation/navigation_service.dart';

abstract class SuccessHandler {
  static final NavigationService navigationService = getIt<NavigationService>();

  static get context => navigationService.context;

  static void handle2(Success success, {Function? retry}) {
    navigationService.snackbar(GestureDetector(
        onTap: () {
          // AppB
        },
        child: Text(success.msg)),
        icon: Icons.check_box,
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 2),
        margin: EdgeInsets.only(
          left: 12,
          bottom: 12,
          right: MediaQuery
              .of(navigationService.context)
              .size
              .width * 0.7,
        )
      // action: SnackBarAction(
      //   textColor: Colors.white,
      //   label: "Done",
      //   onPressed: () {
      //   },
      // ),
    );
  }

  static void handle(Success success, {Function? retry}) {
    BotToast.showAttachedWidget(
        attachedBuilder: (_)=>Transform.scale(
            scale: 0.7,
            child: Material(
                child: GestureDetector(
                    onTap: () {
                      print("ee");
                      BotToast.cleanAll();
                      // cancel();  //c
                    },
                    child: AbsorbPointer(
                      child: Material(
                        child: ArtemisAwesomeSnackbarContent(
                          title: 'Success!',
                          message: '$success',
                          contentType: ContentType.success,
                        ),
                      ),))),),
            duration: const Duration(seconds: 2),
            target: const Offset(500, 20));
  }

  static void handleNoElement(String name) {

    navigationService.snackbar(Text("Could not Find $name"),
      icon: Icons.error,
      backgroundColor: Colors.orange,
      duration: const Duration(seconds: 5),
    );
  }
}
