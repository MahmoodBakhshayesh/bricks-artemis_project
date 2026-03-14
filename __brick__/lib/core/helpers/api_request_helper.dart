import 'system_info.dart';

String getDomain() {
  return SystemInfo.isWebMobile
      ? 'PWA'
      : SystemInfo.isWeb
      ? 'Web'
      : SystemInfo.isWebOrDesktop
      ? 'Desktop'
      : 'App Mobile';
}
