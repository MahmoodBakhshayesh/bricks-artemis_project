import 'import_toggler.dart';

abstract class CookieManager {
  static Map<String, String> getAllCookies() {
    String cookie = document.cookie!;
    if (cookie.trim().isNotEmpty) {
      List<MapEntry<String, String>> entity = cookie.split("; ").map((item) {
        List<String> split = item.split("=");
        return MapEntry(split[0], split[1]);
      }).toList();
      Map<String, String> cookieMap = Map.fromEntries(entity);
      return cookieMap;
    }
    return {};
  }

  static String? getCookie({required String key}) {
    Map<String, String> cookieMap = getAllCookies();
    return cookieMap[key];
  }

  static void setCookie({required String key, required String value}) {
    Map<String, String> cookieMap = getAllCookies();
    cookieMap[key] = value;
    String newCookieString = '';
    cookieMap.forEach((key, value) {
      newCookieString += '$key=$value; ';
    });
    //remove the last ";"
    if (cookieMap.isNotEmpty) {
      newCookieString = newCookieString.trimRight().substring(0, newCookieString.length - 2);
    }
    document.cookie = newCookieString;
  }
}
