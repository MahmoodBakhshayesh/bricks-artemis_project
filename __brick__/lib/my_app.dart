import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'core/navigation/router.dart';
import 'core/util/app_config.dart';
import 'core/util/shortcuts/app_shortcuts.dart';
import 'core/util/shortcuts/shortcuts_actions.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
        statusBarColor: AppConfig.themeLight!.appBarTheme.backgroundColor, // Color for Android
        // statusBarColor: Colors.white, // Color for Android
        statusBarBrightness: Brightness.dark // Dark == white status bar -- for IOS.
        ));

    return Shortcuts(
      shortcuts: AppShortcuts.shortcuts,
      child: Actions(
        dispatcher: LoggingActionDispatcher(),
        actions: <Type, Action<Intent>>{
          SelectAllIntent: SelectAllAction("Sav"),
          ESCIntent: ESCAction(),

        },
        child: Builder(builder: (context) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            theme: AppConfig.themeLight,
            routeInformationParser: MyRouter.router.routeInformationParser,
            routerDelegate: MyRouter.router.routerDelegate,
          );
        }),
      ),
    );
  }
}
