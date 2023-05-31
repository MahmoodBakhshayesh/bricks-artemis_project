import 'dart:developer';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/navigation/navigation_service.dart';
import '../../initialize.dart';

abstract class MainController {
  late NavigationService nav;
  late SharedPreferences prefs;
  late WidgetRef ref;
  bool initialized =false;
  MainController() {
    nav = getIt<NavigationService>();
    prefs = getIt<SharedPreferences>();
    ref = getIt<WidgetRef>();

    if(!initialized) {
      onCreate();
    }
  }


  void onInit() {
    log('$runtimeType Init');
  }

  void onCreate() {
    log('$runtimeType Create');
    initialized =true;
  }
}