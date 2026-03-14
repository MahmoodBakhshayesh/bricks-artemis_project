import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web/web.dart' as web;
import '../constants/keys.dart';
import '../helpers/logger_service.dart';
import '../interfaces/base_key_value_store.dart';
import 'shared_preferences_helper.dart';

class SessionStorage extends BaseKeyValueStore {
  web.Storage get sessionStorage => web.window.sessionStorage;

  @override
  Future<bool> write(String key, String value) async {
    try {
      sessionStorage.setItem(key, value);
      return true;
    } catch (e) {
      appLog.e(e);
      return false;
    }
  }

  @override
  String? get(String key) => sessionStorage.getItem(key);

  @override
  Future<bool> remove(String key) async {
    try {
      sessionStorage.removeItem(key);
      return true;
    } catch (e) {
      appLog.e(e);
      return false;
    }
  }

  @override
  Future<bool> clear() async {
    try {
      sessionStorage.clear();
      return true;
    } catch (e) {
      appLog.e(e);
      return false;
    }
  }
}

Future<void> registerStorage(GetIt locator) async {
  final storage = await SharedPreferences.getInstance();
  locator.registerSingleton<BaseKeyValueStore>(SharedPreferencesHelper(storage));
  locator.registerSingleton<BaseKeyValueStore>(SessionStorage(), instanceName: Keys.sessionStorageInstance);
}
