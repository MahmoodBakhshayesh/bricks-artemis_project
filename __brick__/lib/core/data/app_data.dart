import 'dart:developer';
import 'package:app_device_net_info/app_device_net_info.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/models/base/flavor_config.dart';

class AppData extends ChangeNotifier {
  AppData._();

  static final AppData instance = AppData._();
  static const String _kTokenKey = 'auth_token';
  late SharedPreferences _prefs;

  String? _token;
  int? _userId;

  String? get token => _token;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
    _token = _prefs.getString(_kTokenKey);
    log("setting token $_token");
    // Don't notify here because it's startup
  }

  Future<AppInfoData> get getAppInfo => AppDeviceNetworkInfo.getAppInfo();

  static Flavor get defaultFlavor => Flavor.dev;

  set token(String? value) {
    if (_token != value) {
      _token = value;
      if (value != null) {
        _prefs.setString(_kTokenKey, value);
        log("saving token ${value}");
      } else {
        // _prefs.remove(_kTokenKey);
      }
      notifyListeners();
    }
  }

  void setUserId(int? value) {
    if (_userId != value) {
      _userId = value;
      // if (value != null) {
      //   _prefs.setString(_kTokenKey, value);
      //   log("saving token ${value}");
      // } else {
      //   // _prefs.remove(_kTokenKey);
      // }
      notifyListeners();
    }
  }

  bool get hasToken => _token != null && _token!.isNotEmpty;
  bool get hasUserId => _userId !=null;
}
