import 'dart:developer';
import '../data_base/share_pref.dart';
import '../dependency_injection.dart';
import '../navigation/navigation_service.dart';
import '../navigation/router.dart';

abstract class MainController {
  late NavigationService navigator;
  late SharedPrefService prefs;
  final MyRouter router = MyRouter();
  bool initialized =false;
  MainController() {
    navigator = getIt<NavigationService>();
    prefs = getIt<SharedPrefService>();
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
