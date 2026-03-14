abstract class SharedPreferencesInterface{
  Future<void> setVariable({required String key, required String value});
  Future<String?> getVariable({required String key});
  Future<void> setList({required String key, required List<String> value});
  Future<List<String>?> getList({required String key});
}