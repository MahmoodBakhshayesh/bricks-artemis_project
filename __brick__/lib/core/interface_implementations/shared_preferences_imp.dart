import 'package:shared_preferences/shared_preferences.dart';

import '../interfaces/shared_preferences_int.dart';

class SharedPreferencesImp implements SharedPreferencesInterface {
  final SharedPreferences sp;
  SharedPreferencesImp(this.sp);
  @override
  Future<List<String>?> getList({required String key}) async{
    return sp.getStringList(key);
  }

  @override
  Future<String?> getVariable({required String key}) async {
    return sp.getString(key);
  }

  @override
  Future<void> setList({required String key, required List<String> value}) async {
    sp.setStringList(key,value);
  }

  @override
  Future<void> setVariable({required String key, required String? value}) async {
    if(value == null){
      sp.remove(key);
    }else {
      sp.setString(key, value);
    }
  }

}