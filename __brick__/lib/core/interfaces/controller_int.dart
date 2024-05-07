import 'dart:developer';
import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'navigation_int.dart';
import 'shared_preferences_int.dart';
import '../../../core/navigation/navigation_service.dart';
import '../../initialize.dart';

abstract class ControllerInterface {
  late NavigationInterface nav;
  late SharedPreferencesInterface prefs;
  late WidgetRef ref;
  bool initialized =false;
  ControllerInterface() {
    nav = getIt<NavigationInterface>();
    prefs = GetIt.instance<SharedPreferencesInterface>();
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