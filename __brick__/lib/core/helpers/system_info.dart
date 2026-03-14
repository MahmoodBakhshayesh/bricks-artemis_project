import 'package:flutter/foundation.dart';

class SystemInfo {
  static bool get isWeb => kIsWeb || kIsWasm;

  /// On Flutter Web, this is `true` when the browser runs on a mobile OS.
  static bool get isWebMobile => isWeb && (defaultTargetPlatform == TargetPlatform.iOS || defaultTargetPlatform == TargetPlatform.android);

  static bool get isWebOrDesktop =>
      isWeb ||
      defaultTargetPlatform == TargetPlatform.macOS ||
      defaultTargetPlatform == TargetPlatform.windows ||
      defaultTargetPlatform == TargetPlatform.linux;

  static String get systemOS {
    if (isWeb) return 'Web';
    return defaultTargetPlatform.name;
  }
}
