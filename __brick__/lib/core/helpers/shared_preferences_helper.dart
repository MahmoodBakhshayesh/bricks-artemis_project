import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/keys.dart';
import '../interfaces/base_key_value_store.dart';

/// A concrete implementation of [BaseKeyValueStore] that uses the
/// `shared_preferences` package for data storage.
class SharedPreferencesHelper extends BaseKeyValueStore {
  final SharedPreferences _storage;

  SharedPreferencesHelper(this._storage);

  @override
  String? get(String key) => _storage.getString(key);

  @override
  Future<bool> write(String key, String value) => _storage.setString(key, value);

  @override
  Future<bool> remove(String key) => _storage.remove(key);

  @override
  Future<bool> clear() async {
    bool success = false;

    success = await _storage.clear();
    if (success == false) return false;

    await _storage.reload();
    return true;
  }
}

Future<void> registerStorage(GetIt locator) async {
  final storage = await SharedPreferences.getInstance();
  locator.registerSingleton<BaseKeyValueStore>(SharedPreferencesHelper(storage));
  locator.registerSingleton<BaseKeyValueStore>(SharedPreferencesHelper(storage), instanceName: Keys.sessionStorageInstance);
}
