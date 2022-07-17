import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefService {
  final SharedPreferences sp;
  SharedPrefService(this.sp);

  Future<bool> setBool(String key,bool value){
    return sp.setBool(key, value);
  }
  bool? getBool(String key){
    return sp.getBool(key);
  }

  Future<bool> setString(String key,String value){
    return sp.setString(key, value);
  }
  String? getString(String key){
    return sp.getString(key);
  }

  Future<bool> setInt(String key,int value){
    return sp.setInt(key, value);
  }
  int? getInt(String key){
    return sp.getInt(key);
  }

  Future<bool> setDouble(String key,double value){
    return sp.setDouble(key, value);
  }
  double? getDouble(String key){
    return sp.getDouble(key);
  }

  Future<bool> setListString(String key,List<String> value){
    return sp.setStringList(key, value);
  }
  List<String>? getStringList(String key){
    return sp.getStringList(key);
  }



}