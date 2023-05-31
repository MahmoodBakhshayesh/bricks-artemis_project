import 'dart:developer';
import 'package:artemis_ui_kit/artemis_ui_kit.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import '../../../initialize.dart';
import '../../abstracts/failures_abs.dart';
import '../../navigation/navigation_service.dart';

class FailureHandler {
  static final NavigationService navigationService = getIt<NavigationService>();

  static get context => navigationService.context;

  FailureHandler._();

  static void handle(Failure failure, {Function? retry}) {
    BotToast.showAttachedWidget(
        attachedBuilder: (_) => Transform.scale(
              scale: 0.7,
              child: Material(
                child: GestureDetector(
                  onTap: () {
                    BotToast.cleanAll();
                    // cancel();  //c
                  },
                  child: AbsorbPointer(
                    child: ArtemisAwesomeSnackbarContent(
                      title: 'Error!',
                      message: '$failure',
                      contentType: ContentType.failure,
                    ),
                  ),
                ),
              ),
            ),
        duration: const Duration(seconds: 10),
        target: const Offset(500, 30));
    // cancel();  //c
  }

  static void handle3(Failure failure, {Function? retry}) {
    final snackBar = SnackBar(
      /// need to set following properties for best effect of awesome_snackbar_content
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: ArtemisAwesomeSnackbarContent(
        title: 'Error!',
        message: '$failure',

        /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
        contentType: ContentType.failure,
      ),
    );

    ScaffoldMessenger.of(context)
      ..hideCurrentMaterialBanner()
      ..showSnackBar(snackBar);
  }

  static void handle2(Failure failure, {Function? retry}) {
    if (failure is ValidationFailure) {
      navigationService.snackbar(GestureDetector(onTap: () {}, child: Text("$failure")),
          margin: EdgeInsets.only(
            left: 12,
            bottom: 12,
            right: MediaQuery.of(navigationService.context).size.width * 0.5,
          ),
          icon: Icons.warning,
          backgroundColor: Colors.orangeAccent,
          duration: const Duration(seconds: 2));
    } else {
      navigationService.snackbar(GestureDetector(onTap: () {}, child: Text("$failure")),
          icon: Icons.error,
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 10),
          margin: EdgeInsets.only(
            left: 12,
            bottom: 12,
            right: MediaQuery.of(navigationService.context).size.width * 0.7,
          ),
          action: SnackBarAction(
            textColor: Colors.white,
            label: "Retry",
            onPressed: () {
              log("Retry");
              retry?.call();
            },
          ));
    }
  }

  static void handleNoElement(String name) {
    navigationService.snackbar(
      Text("Could not Find $name"),
      icon: Icons.error,
      backgroundColor: Colors.orange,
      duration: const Duration(seconds: 5),
    );
  }
}
