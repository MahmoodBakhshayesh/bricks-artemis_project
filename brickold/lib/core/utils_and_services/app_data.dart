import 'dart:io';
import 'package:flutter/foundation.dart';
import '../classes/config_class.dart';

abstract class AppData {
  static Config? _config;

  static bool get isWeb => kIsWeb;

  static bool get isWindows => !isWeb && Platform.isWindows;

  static bool get isMac => Platform.isMacOS;

  static bool get isPhone => Platform.isAndroid || Platform.isIOS;

  static bool get isDesktop => Platform.isMacOS || Platform.isWindows || isWeb;

  static Config? get config => _config;

  static void setConfig(Config newConfig) {
    _config = newConfig;
  }

  static String? _token;

  static String? get token => _token;

  static void setToken(String newToken) {
    _token = newToken;
  }
}
