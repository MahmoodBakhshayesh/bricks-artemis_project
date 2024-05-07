import 'package:shared_preferences/shared_preferences.dart';

import '../interfaces/shared_preferences_int.dart';

class SharedPreferencesImp implements SharedPreferencesInterface {
  @override
  Future<List<String>?> getList({required String key}) async{
    final sp = await SharedPreferences.getInstance();
    return sp.getStringList(key);
  }

  @override
  Future<String?> getVariable({required String key}) async {
    final sp = await SharedPreferences.getInstance();
    return sp.getString(key);
  }

  @override
  Future<void> setList({required String key, required List<String> value}) async {
    final sp = await SharedPreferences.getInstance();
    sp.setStringList(key,value);
  }

  @override
  Future<void> setVariable({required String key, required String value}) async {

  }

}