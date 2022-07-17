import '../classes/settings_class.dart';

class BasicClass {
  BasicClass._();
  factory BasicClass() {
    return instance;
  }
  static final BasicClass instance = BasicClass._();
  static late bool initialized;
  String? _username;
  Settings? _settings;

  static void initialize (Settings settings){
    instance._settings = settings;
  }


  static String get username => instance._username!;



}